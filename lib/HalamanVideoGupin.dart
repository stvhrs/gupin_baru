// Copyright 2020 Sarbagya Dhaubanjar. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:developer';
import 'package:Bupin/ApiServices.dart';
import 'package:Bupin/Halaman_Laporan_Error.dart';
import 'package:Bupin/models/Video.dart';
import 'package:Bupin/widgets/enterFullSceen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'dart:math' as ran;

import 'package:youtube_player_iframe/youtube_player_iframe.dart';

///
class GupinVideo extends StatefulWidget {
  final String link;
  final String ytId;
  final String judul;
  final Color color;

  const GupinVideo(this.ytId, this.link, this.color, this.judul, {super.key});
  @override
  GupinVideoState createState() => GupinVideoState();
}

class GupinVideoState extends State<GupinVideo> with TickerProviderStateMixin {
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

    super.dispose();
  }

  double aspectRatio = 16 / 9;
  late YoutubePlayerController _controller;

  bool noInternet = true;
  String? _getYoutubeVideoIdByURL (String url) {
    final regex = RegExp(r'.*\?v=(.+?)($|[\&])', caseSensitive: false);

    try {
      if (regex.hasMatch(url)) {
        return regex.firstMatch(url)!.group(1);
      }
    } catch (e) {
      return null;
    }
  }
  Future<void> fetchApi() async {
    _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
          mute: false,
          showFullscreenButton: true,
          color: "red",
          loop: false,
          strictRelatedVideos: true),
    );

    _controller.setFullScreenListener(
      (isFullScreen) {},
    );

     _controller.loadVideo(widget.link);

    final isVertical =
        await ApiService.isVertical(_getYoutubeVideoIdByURL(widget.link).toString());

    if (isVertical) {
      aspectRatio = 9 / 16;
    } else {
      aspectRatio = 16 / 9;
    }
    noInternet = false;
    setState(() {});
    return;
  }

  @override
  void initState() {
    fetchApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("Video");
    // ignore: deprecated_member_use
    return WillPopScope(
        onWillPop: () {
          Navigator.pop(context, false);
          if (noInternet == false) {
            _controller.stopVideo();
          }
          return Future.value(true);
        },
        child: (noInternet == true)
            ? Scaffold(
                appBar: AppBar(
                  title: Text(
                    widget.judul,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
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
            : YoutubePlayerScaffold(
                backgroundColor: Colors.black,
                aspectRatio: aspectRatio,
                controller: _controller,
                builder: (context, player) {
                  return Scaffold(
                      backgroundColor: Colors.white,
                      appBar: AppBar(
                        centerTitle: true,
                        leading: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: GestureDetector(
                              onTap: () {
                                _controller.stopVideo();
                                // _controller.close();
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
                      body: LayoutBuilder(
                        builder: (context, constraints) {
                          return Column(
                            children: [
                              Stack(alignment: Alignment.center, children: [
                                Image.asset(
                                  "asset/logo.png",
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                ),
                                FadeTransition(
                                    opacity: _animation, child: player)
                              ]),
                              aspectRatio == 9 / 16
                                  ? const SizedBox()
                                  : Expanded(
                                      child: Stack(
                                        alignment: Alignment.topCenter,
                                        children: [
                                          Container(
                                            color: Colors.white,
                                          ),
                                          aspectRatio == 9 / 16
                                              ? const SizedBox()
                                              : Positioned.fill(
                                                  child: Opacity(
                                                    opacity: 0.05,
                                                    child: Image.asset(
                                                      "asset/Halaman_Scan/Doodle Halaman Scan@4x.png",
                                                      repeat:
                                                          ImageRepeat.repeatY,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      fit: BoxFit.fitWidth,
                                                    ),
                                                  ),
                                                ),
                                         
                                           Padding(
                                            padding:
                                                EdgeInsets.only(right: 0.0),
                                            child:  Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PlayPauseButtonBar(widget.color)
        ],
      ),
                                            ),
                                      )],
                                      ),
                                    ),
                            ],
                          );
                        },
                      ));
                },
              ));
  }
}


///
