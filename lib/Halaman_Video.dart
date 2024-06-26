// Copyright 2020 Sarbagya Dhaubanjar. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:developer';

import 'package:Bupin/Halaman_Laporan_Error.dart';
import 'package:Bupin/models/Video.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pod_player/pod_player.dart';

class HalamanVideo extends StatefulWidget {
  final String link;

  const HalamanVideo(this.link, {super.key});
  @override
  HalamanVideoState createState() => HalamanVideoState();
}

class HalamanVideoState extends State<HalamanVideo>
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
    controller!.dispose();

    super.dispose();
  }

  PodPlayerController? controller;
  @override
  void initState() {
    fetchApi();
    super.initState();
  }

  String linkQrVideo = "";
  Video? video;

  Future<void> fetchApi() async {
    final dio = Dio();

    linkQrVideo = widget.link
        .replaceAll("buku.bupin.id/?", "bupin.id/api/apibarang.php?kodeQR=");
    final response = await dio.get(linkQrVideo);

    log(response.statusCode.toString());
    if (response.statusCode != 200) {
      return;
    }

    if (response.data[0]["ytid"] == null &&
        response.data[0]["ytidDmp"] == null) {
      return;
    } else {
      video = Video.fromMap(response.data[0]);
      controller = PodPlayerController(
        playVideoFrom: PlayVideoFrom.youtube(video!.ytId!, live: false),
        podPlayerConfig: const PodPlayerConfig(
          videoQualityPriority: [720, 360],
          autoPlay: true,
        ),
      )..initialise().catchError((e) {
          log(e.toString());
          log("error");
          fetchApi();
        });
      ;
      setState(() {});
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.pop(context, false);

          controller!.pause();

          return Future.value(true);
        },
        child: (controller == null)
            ? Scaffold(
                appBar: AppBar(
                  leading: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: GestureDetector(
                        onTap: () {
                          controller!.pause();
                          Navigator.pop(context, false);
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Center(
                            child: Icon(
                              Icons.arrow_back_rounded,
                              color: Theme.of(context).primaryColor,
                              size: 15,
                              weight: 100,
                            ),
                          ),
                        )),
                  ),
                  centerTitle: true,
                  automaticallyImplyLeading: false,
                  backgroundColor: Theme.of(context).primaryColor,
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
            : video == null
                ? HalamanLaporan(
                    linkQrVideo.replaceAll(
                      "https://bupin.id/api/apibarang.php?kodeQR=",
                      "",
                    ),
                  )
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
                                  color: Theme.of(context).primaryColor,
                                  size: 15,
                                  weight: 100,
                                ),
                              ),
                            )),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                      title: Text(
                        video!.namaVideo!,
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
                                    controller: controller!,
                                    onVideoError: () {
                                      log("steve");
                                      fetchApi();
                                      return Text("Loading....");
                                    },
                                    matchFrameAspectRatioToVideo: true,
                                    matchVideoAspectRatioToFrame: true,
                                    onToggleFullScreen: (isFullScreen) {
                                      if (controller!.videoPlayerValue!.size
                                              .aspectRatio ==
                                          1.7777777777777777) {
                                        if (!isFullScreen) {
                                          SystemChrome.setPreferredOrientations(
                                              [DeviceOrientation.portraitUp]);
                                        } else {
                                          SystemChrome
                                              .setPreferredOrientations([
                                            DeviceOrientation.landscapeLeft
                                          ]);
                                          if (controller!.isFullScreen) {
                                          } else {
                                            SystemChrome.setEnabledSystemUIMode(
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
                            color: Theme.of(context).primaryColor,
                          ),
                        ],
                      ),
                    )));
  }
}
