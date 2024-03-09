
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
        home: const Home());
  }
}
