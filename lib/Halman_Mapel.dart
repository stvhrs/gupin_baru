import 'dart:math';

import 'package:Bupin/ApiServices.dart';
import 'package:Bupin/Halaman_Mapel/Video_Item.dart';

import 'package:Bupin/Halaman_Soal/quiz_screen.dart';
import 'package:Bupin/ListTo.dart';
import 'package:Bupin/models/Video.dart';
import 'package:Bupin/models/soal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HalamanMapel extends StatefulWidget {
  final Color color;
  final String judul;
  final String idMapel;
  final String image;
  HalamanMapel(
      {required this.color,
      required this.judul,
      required this.idMapel,
      required this.image});

  @override
  State<HalamanMapel> createState() => _HalamanMapelState();
}

class _HalamanMapelState extends State<HalamanMapel> {
  bool _stretch = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:   widget.color,
      appBar: PreferredSize(
  preferredSize: Size.fromHeight(MediaQuery.of(context).size.width * 0.3),
  child: AppBar(backgroundColor: widget.color,
    automaticallyImplyLeading: false, // hides leading widget
    flexibleSpace: 
    FlexibleSpaceBar(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SafeArea(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        widget.judul,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                       ApiService.user!.jenjang,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  titlePadding: EdgeInsets.only(right: 50, bottom: 20, left: 20),
                  background: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          SizedBox(),
                          Positioned(
                            bottom: -2,
                            child: Image.asset(
                              "asset/Icon/Wave 1.png",
                              width: MediaQuery.of(context).size.width * 0.5,
                              color: Colors.white.withOpacity(0.05),
                            ),
                          ),
                          Image.asset(
                            "asset/Icon/Wave 2.png",
                            width: MediaQuery.of(context).size.width * 0.6,
                            color: Colors.white.withOpacity(0.1),
                          ),
                          Hero(
                              tag: widget.judul,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SafeArea(
                                  child: Image.asset(
                                    widget.image,
                                    width: MediaQuery.of(context).size.width * 0.3,
                                  ),
                                ),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
    ),
  ),
      body:Stack(
                            clipBehavior: Clip.none,
                            children: [
                              SizedBox(height: MediaQuery.of(context).size.height,),
                              Positioned.fill(
                                  child: Container(
                                color: Color.fromARGB(255, 237, 240, 247),
                              )),
                              
                              Positioned.fill(
                                child:   Image.asset(
                                      "asset/Halaman_Scan/Doodle Halaman Scan@4x.png",color: widget.color,
                                      repeat: ImageRepeat.repeatY,
                                    
                                  
                                ),
                              ),  Container(
                    padding: EdgeInsets.only(top: 0, left: 15, right: 15),
                    child: SingleChildScrollView(
                      child:   Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Persiapan Ujian",
                                    style: TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                  Icon(
                                    Icons.local_fire_department_sharp,
                                    color: Colors.red,
                                    size: 18,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 15),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: 8, bottom: 8, left: 8, right: 8),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: widget.color.withOpacity(0.1),
                                            spreadRadius: 0.5,
                                            blurRadius: 6,
                                            offset: Offset(0,
                                                0), // changes position of shadow
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(3),
                                        color: Colors.white),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ListTo(widget.color, true,widget.judul)));
                                      },
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 5),
                                            child: Image.asset("asset/uts.png",
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.08,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.08),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 5, right: 5),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "PTS",
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                Text("Berbasis CBT",
                                                    style:
                                                        TextStyle(fontSize: 10)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ListTo(widget.color, false,widget.judul)));
                                      },
                                      child:Container(
                                    padding: EdgeInsets.only(
                                        top: 8, bottom: 8, left: 8, right: 8),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: widget.color.withOpacity(0.1),
                                            spreadRadius: 0.5,
                                            blurRadius: 6,
                                            offset: Offset(0,
                                                0), // changes position of shadow
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(3),
                                        color: Colors.white),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          child: Image.asset(
                                            "asset/uas.png",
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.08,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.08,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.only(left: 5, right: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "PAS",
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w700),
                                              ),
                                              Text("Berbasis CBT",
                                                  style: TextStyle(fontSize: 10)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                                  Spacer(),
                                  Spacer(),
                                  Spacer(),
                                  Spacer()
                                ],
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 15),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Divider(
                                        color: widget.color.withOpacity(0.8),
                                        thickness: 2,
                                        indent: 5,
                                        endIndent: 10,
                                      ),
                                    ),
                                    Text(
                                      "Video Pembelajaran",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                          color: widget.color.withOpacity(0.8)),
                                    ),
                                    Expanded(
                                      child: Divider(
                                        color: widget.color.withOpacity(0.8),
                                        thickness: 2,
                                        indent: 10,
                                        endIndent: 5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          
                                FutureBuilder(
                                    future: ApiService()
                                        .getMapelDetail(widget.idMapel),
                                    builder: (context, snapshot) {
                                      return snapshot.connectionState ==
                                              ConnectionState.waiting
                                          ? Column(
                                              children: List.generate(
                                                  6,
                                                  (index) => VideoItem(
                                                      Video(
                                                          "ytId",
                                                          "namaVideo",
                                                          "linkVideo",
                                                          "thumbnail"),
                                                      "",
                                                      widget.color)))
                                          : Column(
                                              children: List.generate(
                                                  snapshot.data!.length,
                                                  (index) => VideoItem(
                                                      snapshot.data![index],
                                                      snapshot.data![index]
                                                          .namaVideo!,
                                                      widget.color))
                                               );
                                    })
                              
                          ]),
                    ))]),
                  );
            
           
        
      
    
  }
}
