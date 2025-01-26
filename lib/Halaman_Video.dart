// Copyright 2020 Sarbagya Dhaubanjar. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:developer';

import 'package:Bupin/ApiServices.dart';
import 'package:Bupin/Halaman_Laporan_Error.dart';
import 'package:Bupin/models/Video.dart';
import 'package:Bupin/widgets/enterFullSceen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class HalamanVideo extends StatefulWidget {
  final String link;
  final Color color;

  const HalamanVideo(this.link, this.color, {super.key});
  @override
  HalamanVideoState createState() => HalamanVideoState();
}

class HalamanVideoState extends State<HalamanVideo> {
  bool autoFullScreen = true;
  double aspectRatio = 16 / 9;
  YoutubePlayerController? _controller;
  String linkQrVideo = "";
  Video? video;
  bool full = true;

  String videoThumbnail = "";
  var playerState = PlayerState.buffering;
  @override
  initState() {
    if (mounted) {
      NetworkInfo.checkConnectivity(context);
    }

    fetchApi();

    super.initState();
  }

  int counter = 0; // Counter value
  Timer? timer; // Timer instance
  bool loading = true;
  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (_controller != null &&
          video != null &&
          loading == false &&
          FirebaseAuth.instance.currentUser != null) {
        if (playerState == PlayerState.playing) {
          counter++;
          log(counter.toString());
          log(playerState.toString());
        }
        if (counter == 120) {
          context.read<NavigationProvider>().setRecentPoint(
            {
              "user_id": FirebaseAuth.instance.currentUser!.uid,
              "scan_id": widget.link
                  .replaceAll("https://buku.bupin.my.id/api/vid.php?", ""),
              "subject": video!.namaMapel!,
              "scan_type": "VID",
              "scan_xp": 100
            },
          );
          var data = await ApiService.hitMetric(
              context.read<NavigationProvider>().recentPoint);

          context.read<NavigationProvider>().setRecentPoint(
            {
              "user_id": FirebaseAuth.instance.currentUser!.uid,
              "scan_id": widget.link
                  .replaceAll("https://buku.bupin.my.id/api/vid.php?", ""),
              "subject": video!.namaMapel!,
              "scan_type": "VID",
              "scan_xp": (data["data"]["pointsAdded"]).floor()
            },
          );
        }
      }
    });
  }

  updatingRecent() async {
    try {
      log("updateing recent;");

      Provider.of<NavigationProvider>(context, listen: false)
          .addRecentVideo(RecentVideo(
              widget.link,
              videoThumbnail,
              video!.namaVideo!,
              Duration(
                seconds: counter.toInt(),
              ),
              Duration(
                seconds: _controller!.value.metaData.duration.inSeconds,
              ),
              video!.namaKelas,
              video!.namaMapel!,
              DateTime.now().toIso8601String()));

      Provider.of<NavigationProvider>(context, listen: false)
          .selectingRecentVideo = null;
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void dispose() {
    log("dispose video");

    timer?.cancel(); // Cancel timer when widget is disposed

    super.dispose();
  }

  Future<void> fetchApi() async {
    try {
      final dio = Dio();

      linkQrVideo = widget.link
          .replaceAll("buku.bupin.id/?", "buku.bupin.my.id/api/vid.php?");
      final response = await dio.get(linkQrVideo);
      log(response.data.toString());

      if (response.data["ytid_dmp"] == null && response.data["ytid"] == null) {
        video = null;
        loading = false;
      } else {
        video = Video.fromMap(response.data);
      }
      final data = await ApiService.isVertical(video!);
      videoThumbnail = data!["imageUrl"];
      log(videoThumbnail);
      if (data["isVertical"]) {
        aspectRatio = 9 / 16;
      } else {
        aspectRatio = 16 / 9;
      }
      if (video != null) {
        _controller = YoutubePlayerController(
            params: YoutubePlayerParams(
          strictRelatedVideos: true,
          showFullscreenButton: data["isVertical"] == false,
          color: "red",
        ))
          ..listen((event) {
            playerState = event.playerState;
          });

        _controller!.setFullScreenListener(
          (isFullScreen) {
            full = isFullScreen;
          },
        );
        startTimer();

        if (Provider.of<NavigationProvider>(context, listen: false)
                .selectedRecentVideo !=
            null) {
          var seconds = Provider.of<NavigationProvider>(context, listen: false)
              .selectedRecentVideo!
              .recentDuration
              .inSeconds
              .toString();
          log("seek to $seconds");
          _controller!.loadVideo("${video!.linkVideo!}&t=$seconds");
        } else {
          _controller!.loadVideo(video!.linkVideo!);
        }
      }
      loading = false;
      setState(() {});
    } catch (e) {}
    log(loading.toString());
  }

  @override
  Widget build(BuildContext context) {
    log("Video");

    return OrientationBuilder(builder: (context, orientation) {
      return WillPopScope(
          onWillPop: () {
            if (orientation == Orientation.portrait) {
              Provider.of<CameraProvider>(context, listen: false).resume();
            }
            log("will");

            if (loading) {
              Provider.of<CameraProvider>(context, listen: false).resume();
            }
            // Provider.of<CameraProvider>(context, listen: false).resume();

            Provider.of<CameraProvider>(context, listen: false).scaning = false;

            if (counter >= 120) {
              context.read<NavigationProvider>().setIndex = 0;

              log("back point");

              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const Navigation(),
              ));
              updatingRecent();
            }
            return Future.value(true).then(
              (value) {
                return true;
              },
            );
          },
          child: PopScope(
              canPop: full == false || loading == true,
              onPopInvokedWithResult: (c, didPop) {
                if (aspectRatio == 16 / 9 &&
                    full &&
                    video != null &&
                    _controller != null) {
                  _controller!.exitFullScreen(lock: false);
                  return;
                }
              },
              child: (loading == true)
                  ? Scaffold(
                      appBar: AppBar(
                        centerTitle: true,
                        automaticallyImplyLeading: false,
                        backgroundColor: widget.color,
                      ),
                      backgroundColor: Colors.white,
                      body: Center(
                          child: CircularProgressIndicator(
                        color: widget.color,
                        backgroundColor: const Color.fromRGBO(236, 180, 84, 1),
                      )),
                    )
                  : video == null
                      ? HalamanLaporan(
                          linkQrVideo.replaceAll(
                              "https://buku.bupin.my.id/api/vid.php?", ""),
                        )
                      : YoutubePlayerScaffold(
                          backgroundColor: Colors.black,
                          aspectRatio: aspectRatio,
                          controller: _controller!,
                          builder: (context, player) {
                            if (autoFullScreen && aspectRatio == 16 / 9) {
                              _controller!.toggleFullScreen();
                              autoFullScreen = false;
                              log(" fullsceen");
                            }
                            log("not fullsceen");
                            return Scaffold(
                                backgroundColor: Colors.white,
                                appBar: AppBar(
                                  centerTitle: true,
                                  leading: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: GestureDetector(
                                        onTap: () {
                                          if (counter >= 120) {
                                            updatingRecent();
                                            log("back point");

                                            context
                                                .read<NavigationProvider>()
                                                .setIndex = 0;

                                            Navigator.of(context)
                                                .pushReplacement(
                                                    MaterialPageRoute(
                                              builder: (context) =>
                                                  const Navigation(),
                                            ));
                                          }

                                          _controller!.stopVideo();

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
                                    video!.namaVideo!,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                body: LayoutBuilder(
                                    builder: (context, constraints) {
                                  return player;
                                }));
                          },
                        )));
    });
  }
}

class Controls extends StatelessWidget {
  const Controls({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PlayPauseButtonBar(),
        ],
      ),
    );
  }
}

///
