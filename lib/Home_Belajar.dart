import 'dart:developer';

import 'package:Bupin/ApiServices.dart';
import 'package:Bupin/Halaman_Camera.dart';
import 'package:Bupin/Halaman_Login.dart';
import 'package:Bupin/Halman_Mapel.dart';
import 'package:Bupin/styles/PageTransitionTheme.dart';
import 'package:Bupin/widgets/scann_aniamtion/scanning_effect.dart';
import 'package:flutter/cupertino.dart';
import 'package:tex_text/tex_text.dart';
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
        actions: [
          IconButton(
              onPressed: () async {
                bool logout = await ApiService().logout();
                if (logout) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ));
                }
              },
              icon: Icon(Icons.logout))
        ],
        leadingWidth: MediaQuery.of(context).size.width * 0.3,
        leading: Image.asset(
          "asset/gupin.png",
        ),
        // backgroundColor: const Color.fromARGB(255, 48, 47, 114),
      ),
      body: Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 3),
            child: Text(
              "Pelajaran " + ApiService.user!.jenjang,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
            ),
          ),
          Expanded(
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4),
                      itemCount: ApiService.listMapel!.length,
                      itemBuilder: (context, index) => IconMapel(
                          image: ApiService.listMapel![index].asset,
                          judul: ApiService.listMapel![index].mapel,
                          idMapel: ApiService.listMapel![index].idMapel,
                          color: ApiService.listMapel![index].color),
                    ))),
          ),
        ]),
      ),
    ));
  }
}

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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
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
