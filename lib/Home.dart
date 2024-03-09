import 'package:Bupin/Banner.dart';
import 'package:Bupin/Halaman_Camera.dart';
import 'package:Bupin/Halaman_Soal.dart';
import 'package:Bupin/Home_Het.dart';
import 'package:Bupin/Home_Belajar.dart';
import 'package:Bupin/Soal/flashcard_screen.dart';
import 'package:Bupin/styles/PageTransitionTheme.dart';
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
    _controller = TabController(length: 3, vsync: this);
    _controller.animateTo(1);
  }

  int _selectedIndex = 1;

  static List<Widget> _widgetOptions = <Widget>[
    HalmanHet(),
    HalmanScan(),
  
  ];

  void _onItemTapped(int index) {
    _selectedIndex = index;
    if (_selectedIndex == 2) {
      Navigator.of(context).push(CustomRoute(
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
    return
        Scaffold(
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _controller,
            children: _widgetOptions,
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_book_rounded),
                label: 'E-Book BSE',
                backgroundColor: Color.fromARGB(255, 48, 47, 114),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.cast_for_education_rounded),
                label: 'Belajar',
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
