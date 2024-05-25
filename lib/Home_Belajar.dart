import 'dart:developer';

import 'package:Bupin/HalamanVideoGupin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';


import 'package:Bupin/ApiServices.dart';
import 'package:Bupin/Halaman_Login.dart';
import 'package:Bupin/Halman_Mapel.dart';
import 'package:url_launcher/url_launcher.dart';

class IconMapel extends StatelessWidget {
  final Color color;
  final String image;
  final String idMapel;
  final String judul;
  IconMapel(
      {required this.image,
      required this.judul,
      required this.color,
      required this.idMapel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.15,
            height: MediaQuery.of(context).size.width * 0.15,
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(15),
            // ),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => HalamanMapel(
                    color: color,
                    judul: judul,
                    image: image,
                    idMapel: idMapel,
                  ),
                ));
              },
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Opacity(
                      opacity: 1,
                      child: Image.asset(
                        "asset/Icon/Bg Icon2.png",
                        color: color,
                      )),
                  Opacity(
                      opacity: 0.3, child: Image.asset("asset/Icon/Bg t.png")),
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
            maxLines: 1,
            overflow: TextOverflow.visible,
            style: TextStyle(
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}

class HalamanBelajar extends StatelessWidget {
    Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  const HalamanBelajar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Image.asset("asset/4.png"),
          NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [HomAppBar()];
              },
              body: Stack(
                children: [Container(
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).padding.top *
                                        1.5),
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 237, 240, 247),
                                    borderRadius: 
                                    BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
                
                                    
                              
                                width: MediaQuery.of(context).size.width,
                              ),
                              Positioned.fill(child: Image.asset("asset/Halaman_Scan/Doodle Halaman Scan@4x.png",repeat: ImageRepeat.repeatY,color: Theme.of(context).primaryColor,)),
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: ListView(padding: EdgeInsets.zero, children: [
                        Card(
                          margin: EdgeInsets.only(left: 6,right: 6,bottom: 10),elevation: 2,
                          color: Colors.white,
                          surfaceTintColor: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  "Pelajaran "+ ApiService.user!.jenjang,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 15,
                                      color: Theme.of(context).primaryColor),
                                ),
                              ),
                              Container(
                                  child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          bottom: 10,
                                          top: 10),
                                      child: GridView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 4),
                                        itemCount: ApiService.listMapel!.length,
                                        itemBuilder: (context, index) =>
                                            IconMapel(
                                                image: ApiService
                                                    .listMapel![index].asset,
                                                judul: ApiService
                                                    .listMapel![index].mapel,
                                                idMapel: ApiService
                                                    .listMapel![index].idMapel,
                                                color: ApiService
                                                    .listMapel![index].color),
                                      ))),
                            ],
                          ),
                        ), InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => GupinVideo(
                                  "https://www.youtube.com/watch?v=4KEs7FhZWQw",
                                  Theme.of(context).primaryColor,
                                  "Product Knowledge Gupin"),
                            ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset("asset/tutor.png")),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            _launchInBrowser(
                                Uri.parse("https://pemesanan.bupin.id/"));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset("asset/beli.png")),
                          ),
                        ),
                       
                      ])),
                ],
              )),
        ],
      ),
    );
  }
}

class HomAppBar extends StatelessWidget {
  double top = 0;
  final List<Widget> sliders = [
    Image.asset(
      "asset/2.png",
      fit: BoxFit.cover,
    ),
    Image.asset(
      "asset/3.png",
      fit: BoxFit.cover,
    ),
    Image.asset(
      "asset/1.png",
      fit: BoxFit.cover,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        backgroundColor: Colors.transparent,
        // bottom: PreferredSize(
        //   preferredSize: Size.fromHeight(10),
        //   child: Container(height: 10,
        //     decoration: BoxDecoration(
        //         color: Colors.white,
        //         borderRadius: BorderRadius.only(
        //             topLeft: Radius.circular(100),
        //             topRight: Radius.circular(100))),
        //   ),
        // ),
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        stretch: true,
        expandedHeight: MediaQuery.of(context).size.height * 0.2,
        floating: false,
        actions: [],
        pinned: true,
        flexibleSpace: Stack(alignment: Alignment.topCenter, children: [
          Positioned.fill(
              child: Image.asset(
            "asset/4.png",
            fit: BoxFit.fitWidth,
          )),
          LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            top = constraints.biggest.height;
            log(top.toString());
            return FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(bottom: 5, left: 10,right: 10),
              title: AnimatedOpacity(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'asset/gupin.png',
                      height: 40,
                    ),
                    IconButton(
                        onPressed: () async {
                          bool logout = await ApiService().logout();
                          if (logout) {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ));
                          }
                        },
                        icon: const Icon(
                          Icons.power_settings_new_outlined,
                          color: Colors.white,
                        )),
                  ],
                ),
                duration: const Duration(milliseconds: 200),
                opacity: top <=
                        MediaQuery.of(context).padding.top + kToolbarHeight 
                    ? 1.0
                    : 0.0,
              ),
              background: Container(
                child: OverflowBox(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned.fill(
                          child: Image.asset(
                        "asset/4.png",
                        fit: BoxFit.fitWidth,
                      )),
                      Positioned(
                        bottom: -140,
                        child: Container(
                          padding: EdgeInsets.only(top: 10),
                          width: MediaQuery.of(context).size.width,
                          child: FlutterCarousel(
                            options: CarouselOptions(
                              autoPlay: true,
                              autoPlayCurve: Curves.easeInCirc,
                              autoPlayInterval: const Duration(seconds: 5),
                              disableCenter: true,
                              indicatorMargin: 12.0,
                              showIndicator: false,
                              viewportFraction: 1,
                              // height: MediaQuery.of(context).size.h,
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 500),
                              enableInfiniteScroll: true,
                            ),
                            items: sliders,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          })
        ]));
  }
}
