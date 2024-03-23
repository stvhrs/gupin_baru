import 'package:Bupin/Halaman_Login.dart';
import 'package:Bupin/Home.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  return runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Platform messages are asynchronous, so we initialize in an async method.

  @override
  Widget build(BuildContext context) {












    return MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        theme: ThemeData(
            inputDecorationTheme: InputDecorationTheme(
              hintStyle:  TextStyle(color:Color.fromARGB(255, 48, 47, 114).withOpacity(0.7),),prefixIconColor:Color.fromARGB(255, 48, 47, 114).withOpacity(0.7) ,prefixStyle: TextStyle(fontSize: 10),
              // ignore: prefer_const_constructors
              labelStyle: const TextStyle(
                fontSize: 13,
                color: Color.fromARGB(255, 48, 47, 114),
                letterSpacing: 0.7,
              ),
              contentPadding:
                  const EdgeInsets.only(left: 20, right: 5, top: 0, bottom: 0),
              filled: true,
              fillColor: Colors.grey.shade100,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade100, width: 0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                    color: Colors.grey.shade100,
                    width: 0,
                    style: BorderStyle.solid),
              ),
            ),
            appBarTheme: const AppBarTheme(
                backgroundColor: Color.fromARGB(255, 48, 47, 114),
                actionsIconTheme: IconThemeData(color: Colors.white)),
            fontFamily: 'Nunito',
            textTheme:
                const TextTheme(titleMedium: TextStyle(fontFamily: "Nunito")),
            scaffoldBackgroundColor: Color.fromARGB(255, 48, 47, 114),
            colorScheme: ColorScheme.fromSwatch().copyWith(
              secondary: const Color.fromRGBO(236, 180, 84, 1),
              primary: Color.fromARGB(255, 48, 47, 114),
            )),
        home: LoginScreen());
  }
}
