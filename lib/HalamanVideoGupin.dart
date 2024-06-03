// Copyright 2020 Sarbagya Dhaubanjar. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:developer';
import 'package:Bupin/Halaman_Laporan_Error.dart';
import 'package:Bupin/models/Video.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:pod_player/pod_player.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as ytx;
import 'dart:math' as ran;

///
class GupinVideo extends StatefulWidget {
  final String link;
  final String judul;
  final Color color;

  const GupinVideo(this.link, this.color, this.judul, {super.key});
  @override
  HalamanVideoState createState() => HalamanVideoState();
}

class HalamanVideoState extends State<GupinVideo>
    with TickerProviderStateMixin {
  late final AnimationController _controller2 = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..animateTo(1);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller2,
    curve: Curves.easeIn,
  );

  @override
  void dispose() {
    _controller2.dispose();
    if (controller != null) {
      controller!.dispose();
    }

    super.dispose();
  }
@override
  void initState() {
    fetchApi();
    super.initState();
  }
  PodPlayerController? controller;

  Future<void> fetchApi() async {
    controller = await PodPlayerController(
      playVideoFrom: PlayVideoFrom.youtube(widget.link),
      podPlayerConfig: const PodPlayerConfig(
          autoPlay: true, videoQualityPriority: [720, 360]),
    );
    await controller!.initialise();
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.pop(context, false);
          // controller.pause();
          return Future.value(true);
        },
        child:
                      controller == null
                  ? Scaffold(
                      appBar: AppBar(
                        leading: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: GestureDetector(
                              onTap: () {
                                // controller.pause();
                                Navigator.pop(context, false);
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_back_rounded,
                                    color: widget.color,
                                    size: 15,
                                    weight: 100,
                                  ),
                                ),
                              )),
                        ),
                        centerTitle: true,
                        automaticallyImplyLeading: false,
                        backgroundColor: widget.color,
                      ),
                      backgroundColor: Colors.white,
                      body: Stack(alignment: Alignment.center, children: [
                        Container(
                          color: Colors.black,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width * 9 / 16,
                        ),
                        Image.asset(
                          "asset/logo.png",
                          width: MediaQuery.of(context).size.width * 0.5,
                        ),
                      ]))
                  : Scaffold(
                      backgroundColor: Colors.white,
                      appBar: AppBar(
                        centerTitle: true,
                        leading: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context, false);
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_back_rounded,
                                    color: widget.color,
                                    size: 15,
                                    weight: 100,
                                  ),
                                ),
                              )),
                        ),
                        backgroundColor: widget.color,
                        title: Text(
                          widget.judul,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      body: SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            Stack(
                                clipBehavior: Clip.none,
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    color: Colors.black,
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.width *
                                        9 /
                                        16,
                                  ),
                                  Image.asset(
                                    "asset/logo.png",
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                  ),
                                  FadeTransition(
                                    opacity: _animation,
                                    child: PodVideoPlayer(
                                      onVideoError: () {
                                        log("steve");
                                       fetchApi();
                                        return Text("Loading....");
                                      },
                                      controller: controller!,
                                      matchFrameAspectRatioToVideo: true,
                                      matchVideoAspectRatioToFrame: true,
                                      onToggleFullScreen: (isFullScreen) {
                                        if (controller!.videoPlayerValue!.size
                                                .aspectRatio ==
                                            1.7777777777777777) {
                                          if (!isFullScreen) {
                                            SystemChrome
                                                .setPreferredOrientations([
                                              DeviceOrientation.portraitUp
                                            ]);
                                          } else {
                                            SystemChrome
                                                .setPreferredOrientations([
                                              DeviceOrientation.landscapeLeft
                                            ]);
                                            if (controller!.isFullScreen) {
                                            } else {
                                              SystemChrome
                                                  .setEnabledSystemUIMode(
                                                      SystemUiMode.leanBack);
                                            }
                                          }

                                          return Future.delayed(
                                              Duration(microseconds: 0));
                                        } else {
                                          return Future.delayed(
                                            Duration(microseconds: 0),
                                            () {
                                              if (controller!.isFullScreen) {
                                              } else {
                                                SystemChrome
                                                    .setEnabledSystemUIMode(
                                                        SystemUiMode.leanBack);
                                              }
                                            },
                                          );
                                        }
                                      },
                                    ),
                                  )
                                ]),
                            Image.asset(
                              "asset/Halaman_Scan/Doodle Halaman Scan@4x.png",
                              width: MediaQuery.of(context).size.width,
                              color: widget.color,
                            ),
                          ],
                        ),
                      ))
           );
  }
}
