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
  GupinVideoState createState() => GupinVideoState();
}

class GupinVideoState extends State<GupinVideo>
    with TickerProviderStateMixin {
  late final AnimationController animationcon = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..animateTo(1);
  late final Animation<double> _animation = CurvedAnimation(
    parent: animationcon,
    curve: Curves.easeIn,
  );

  @override
  void dispose() {
    // ScaffoldMessenger.of(context).dispose();f
    animationcon.dispose();
    videoYoutube.dispose();
    audioYoutube.dispose();

    noInternet = true;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  late final PodPlayerController videoYoutube;

  bool noInternet = true;

  late PodPlayerController audioYoutube;
  Future<void> fetchApi() async {
    var yt = ytx.YoutubeExplode();

    var manifest = await yt.videos.streamsClient.getManifest(widget.link);
    audioYoutube = PodPlayerController(
      playVideoFrom: PlayVideoFrom.network(
        manifest.audioOnly.first.url.toString(),
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      ),
      podPlayerConfig: PodPlayerConfig(
        autoPlay: false,
      ),
    )..initialise();
    videoYoutube = PodPlayerController(
      playVideoFrom: PlayVideoFrom.network(
        manifest.videoOnly.bestQuality.url.toString(),
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      ),
      podPlayerConfig: const PodPlayerConfig(
        autoPlay: false,
      ),
    )..initialise();

    videoYoutube.addListener(() {
      if (videoYoutube.isVideoBuffering || audioYoutube.isVideoBuffering) {
        videoYoutube.pause();
        audioYoutube.pause();
        if (videoYoutube.videoPlayerValue!.position !=
            audioYoutube.videoPlayerValue!.position) {
          audioYoutube.videoSeekTo(videoYoutube.videoPlayerValue!.position);
        }

        // ScaffoldMessenger.of(context)
        //     .showSnackBar(SnackBar(content: Text("Loading")));
      } else {
        if (!videoYoutube.isVideoBuffering &&
            !audioYoutube.isVideoBuffering &&
            !videoYoutube.isVideoPlaying &&
            !audioYoutube.isVideoPlaying) {
          videoYoutube.play();
          audioYoutube.play();
          //  ScaffoldMessenger.of(context).clearSnackBars();
        }
      }

      if (videoYoutube.isVideoPlaying) {
        audioYoutube.play();
      } else {
        audioYoutube.pause();

        // videoYoutube.removeListener(() {});
      }
    });
    ;
   Timer.periodic(Duration(seconds: 3), (timer) {
  if(videoYoutube.isInitialised&&audioYoutube.isInitialised){
 audioYoutube.play();
      videoYoutube.play();
      timer.cancel();

  }
     
    });
    noInternet = false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.pop(context, false);

          return Future.value(true);
        },
        child: FutureBuilder<void>(
            future: fetchApi(),
            builder: (context, snapshot) {
              return (noInternet == true)
                  ? Scaffold(
                      appBar: AppBar(
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
                                  Transform.scale(
                                    scale: 0.1,
                                    child: PodVideoPlayer(
                                      controller: audioYoutube,
                                    ),
                                  ),
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
                                      controller: videoYoutube,
                                      matchFrameAspectRatioToVideo: true,
                                      matchVideoAspectRatioToFrame: true,
                                      onToggleFullScreen: (isFullScreen) {
                                        if (videoYoutube.videoPlayerValue!.size
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
                                          }

                                          return Future.delayed(
                                              Duration(microseconds: 0));
                                        } else {
                                          return Future.delayed(
                                            Duration(microseconds: 0),
                                            () {
                                              videoYoutube.enableFullScreen();
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
                      ));
            }));
  }
}
