import 'package:Bupin/ApiServices.dart';
import 'package:Bupin/Home.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController kodesekolah = TextEditingController();
  final RoundedLoadingButtonController _btnController1 =
      RoundedLoadingButtonController();
  final List<Widget> sliders = [
    Image.asset("asset/2.png"),
    Image.asset("asset/3.png"),
    Image.asset("asset/1.png"),
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(alignment: Alignment.topCenter, children: [
      Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: size.width,
      ),
      Image.asset(
        "asset/4.png",
        width: size.width,
      ),
      FlutterCarousel(
        options: CarouselOptions(
          autoPlay: true,
          autoPlayCurve: Curves.easeInToLinear,
          autoPlayInterval: const Duration(seconds: 3),
          disableCenter: true,
          height: MediaQuery.of(context).size.width,
          indicatorMargin: 12.0,
          showIndicator: false,
          viewportFraction: 1,
          autoPlayAnimationDuration: Duration(milliseconds: 500),
          enableInfiniteScroll: true,
        ),
        items: sliders,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: ListView(
          children: [
            SizedBox(
              height: size.height * 0.3,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Stack(clipBehavior: Clip.none,
                children: [
                  Image.asset(
                    "asset/Halaman_Scan/Doodle Halaman Scan@4x.png",
                    repeat: ImageRepeat.repeatY,
                    color: Theme.of(context).primaryColor,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(
                              bottom: 10, top: 20, left: 40, right: 40),
                          child: Text(
                            textAlign: TextAlign.left,
                            "Masukan akun",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 24,
                                fontWeight: FontWeight.w700),
                          )),
                      Container(
                        alignment: Alignment.center,
                        margin:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          onChanged: (v) {
                            kodesekolah.text = v;
                            setState(() {});
                          },
                          controller: kodesekolah,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              hintText: "Kode Sekolah",
                              prefixIcon: Icon(
                                Icons.school_rounded,
                                size: 18,
                              )),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            username.text = value;
                            setState(() {});
                          },
                          controller: username,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                              hintText: "Username",
                              prefixIcon: Icon(
                                Icons.person_2_sharp,
                                size: 18,
                              )),
                        ),
                      ),
                      SizedBox(height: size.height * 0.05),
                      RoundedLoadingButton(
                        width: size.width * 0.5,
                        color: Theme.of(context).primaryColor,
                        successIcon: Icons.check_box_rounded,
                        height: 40,
                        successColor: Colors.green,
                        failedIcon: Icons.warning_rounded,
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Colors.white),
                        ),
                        controller: _btnController1,
                        onPressed: () async {
                          _btnController1.start();
                          bool login = await ApiService()
                              .login(kodesekolah.text, username.text);
                          if (login) {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => Home(),
                            ));
                          } else {
                            _btnController1.error();
                            await Future.delayed(Duration(milliseconds: 500));
                            _btnController1.reset();
                            return;
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
