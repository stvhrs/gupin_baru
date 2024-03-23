import 'dart:developer';

import 'package:Bupin/Halaman_Camera.dart';
import 'package:Bupin/Halman_Mapel.dart';
import 'package:Bupin/styles/PageTransitionTheme.dart';
import 'package:Bupin/widgets/scann_aniamtion/scanning_effect.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class HalmanScan extends StatefulWidget {
  const HalmanScan({super.key});

  @override
  State<HalmanScan> createState() => _HalmanScanState();
}

class _HalmanScanState extends State<HalmanScan> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  final List<Widget> sliders = [
    Image.asset("asset/2.png"),
    Image.asset("asset/3.png"),
    Image.asset("asset/1.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: Colors.black,
        leadingWidth: MediaQuery.of(context).size.width * 0.3,
        leading: Image.asset(
          "asset/gupin.png",
        ),
        // backgroundColor: const Color.fromARGB(255, 48, 47, 114),
      ),
      body: Container(
        child:Column(children: [
          FlutterCarousel(
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 7),
              disableCenter: true,
              height: MediaQuery.of(context).size.width * 6 / 16,
              indicatorMargin: 12.0,
              viewportFraction: 1,
              enableInfiniteScroll: true,
            ),
            items: sliders,
          ),
          Container(
              margin: EdgeInsets.all(15),
              decoration:
                  BoxDecoration( boxShadow: [
                                        BoxShadow(
                                          color:Theme.of(context) .primaryColor.withOpacity(0.1),
                                          spreadRadius: 0.5,
                                          blurRadius: 6,
                                          offset: Offset(0,
                                              0), // changes position of shadow
                                        ),
                                      ],color: Colors.white,borderRadius: BorderRadius.circular(10)),
              child: Container(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        "Pelajaran SMA XI",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 17),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconMapel(
                            color: Color.fromARGB(255, 101, 166, 225),
                            image: "asset/Icon/Geografi.png",
                            judul: "Geografi"),
                        IconMapel(
                            color: Color.fromARGB(255, 14, 13, 45),
                            image: "asset/Icon/Fisika.png",
                            judul: "Fisika"),
                        IconMapel(
                            color: Color.fromARGB(255, 62, 189, 76),
                            image: "asset/Icon/Biologi.png",
                            judul: "Biologi"),
                        IconMapel(
                            color: Color.fromARGB(255, 213, 160, 57),
                            image: "asset/Icon/Pancasila.png",
                            judul: "PPKN"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconMapel(
                            color: Color.fromARGB(255, 243, 80, 77),
                            image: "asset/Icon/Kimia.png",
                            judul: "Kimia"),
                        IconMapel(
                            color: Color.fromARGB(255, 72, 79, 155),
                            image: "asset/Icon/Bahasa Indonesia.png",
                            judul: "Indonesia"),
                        IconMapel(
                            color: Color.fromARGB(255, 241, 192, 104),
                            image: "asset/Icon/Ekonomi.png",
                            judul: "Ekonomi"),
                        IconMapel(
                            color: Color.fromARGB(255, 159, 146, 154),
                            image: "asset/Icon/Antropologi.png",
                            judul: "Antropologi"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconMapel(
                            color: Color.fromARGB(255, 120, 144, 198),
                            image: "asset/Icon/Sosiologi.png",
                            judul: "Sosiologi"),
                        IconMapel(
                            color: Color.fromARGB(255, 159, 101, 221),
                            image: "asset/Icon/Bahasa Inggris.png",
                            judul: "Inggris"),
                        IconMapel(
                            color: Color.fromARGB(255, 224, 184, 19),
                            image: "asset/Icon/Agama.png",
                            judul: "PAI"),
                        IconMapel(
                            color: Color.fromARGB(255, 117, 47, 17),
                            image: "asset/Icon/Sejarah.png",
                            judul: "Sejarah"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconMapel(
                            color: Color.fromARGB(255, 153, 178, 219),
                            image: "asset/Icon/Matematika.png",
                            judul: "Matematika"),
                      ],
                    ),
                  ],
                ),
              )),
         
        ]),
      ),
    ));
  }
}

class IconMapel extends StatelessWidget {
  final Color color;
  final String image;
  final String judul;
  IconMapel({required this.image, required this.judul, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(margin: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 8, left: 5, right: 5, bottom: 1),
            width: MediaQuery.of(context).size.width * 0.15,
            height: MediaQuery.of(context).size.width * 0.15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(CustomRoute(
                  builder: (context) =>
                      HalamanMapel(color: color, judul: judul, image: image),
                ));
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Opacity(
                      opacity: 1,
                      child:  Image.asset(
                        "asset/Icon/Bg Icon2.png",
                        color: color,
                      )),
                  Opacity(
                      opacity: 0.3, child:  Image.asset("asset/Icon/Bg t.png")),
                  Hero(
                      tag: judul,
                      child: Image.asset(image,
                          width: MediaQuery.of(context).size.width * 0.10,
                          height: MediaQuery.of(context).size.width * 0.10)),
                ],
              ),
            ),
          ),
          Text(
            judul,
            style: TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}
