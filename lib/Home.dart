import 'package:Bupin/Banner.dart';
import 'package:Bupin/Halaman_Camera.dart';
import 'package:Bupin/Halaman_Soal.dart';
import 'package:Bupin/Home_Het.dart';
import 'package:Bupin/Home_Belajar.dart';
import 'package:Bupin/test.dart';
import 'package:Bupin/widgets/scann_aniamtion/scanning_effect.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Flutter code sample for [BottomNavigationBar].

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    _controller.animateTo(0);
  }

  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[  Bimbee(),
    HalmanHet(),
  
  ];

  void _onItemTapped(int index) {
    _selectedIndex = index;
    if (_selectedIndex == 2) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => QRViewExample(false),
      ));
    } else {
      setState(() {
        _controller.animateTo(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Stack(alignment: Alignment.center, children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const QRViewExample(false),
            ));
          },
          child: Container(
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.width * 0.15,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(100),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 20,
                    offset: const Offset(0.5, 0.5),
                  ),
                ],
              ),
              child: Icon(
                Icons.qr_code_scanner_rounded,
                color: Colors.white,
                size: MediaQuery.of(context).size.width * 0.09,
              )),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.28,
          height: MediaQuery.of(context).size.width * 0.28,
          child:  ScanningEffect(
            enableBorder: false,
            scanningColor: Color.fromRGBO(236, 180, 84, 1),
            delay: Duration(milliseconds: 200),
            duration: Duration(seconds: 2),
            child: SizedBox(),
          ),
        ),
      ]),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _controller,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[

          BottomNavigationBarItem(
            icon: Icon(Icons.cast_for_education_rounded),
            label: 'Belajar',
            backgroundColor: Color.fromARGB(255, 48, 47, 114),
          ),          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_rounded),
            label: 'E-Book BSE',
            backgroundColor: Color.fromARGB(255, 48, 47, 114),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 48, 47, 114),
        onTap: _onItemTapped,
      ),
    );
  }
}
