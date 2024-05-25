import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(backgroundColor: Theme.of(context).primaryColor,body: Padding(
      padding: const EdgeInsets.all(50.0),
      child: Center(child: Image.asset('asset/gupin.png')),
    ),);
  }
}