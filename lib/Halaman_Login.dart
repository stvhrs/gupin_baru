import 'package:Bupin/Home.dart';
import 'package:Bupin/styles/PageTransitionTheme.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.1),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    hintText: "Kode Sekolah",
                    prefixIcon: Icon(
                      Icons.person,
                      size: 18,
                    )),
              ),
            ),
            SizedBox(height: size.height * 0.015),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: Icon(
                      Icons.lock_person,
                      size: 18,
                    )),
                obscureText: true,
              ),
            ),
            SizedBox(height: size.height * 0.05),
            ElevatedButton(
                style: ButtonStyle(
                    animationDuration: Duration(seconds: 1),
                    elevation: MaterialStateProperty.all(2),overlayColor:MaterialStateProperty.all(
                        Color.fromARGB(255, 48, 47, 114)) ,
                    surfaceTintColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 48, 47, 114)),
                   
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 59, 58, 114)),
                    padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.2))),
                onPressed: () {

                  Navigator.of(context).push(CustomRoute(builder: (context) => Home(),));
                },
                child: Text(
                  "Login",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset("asset/top1.png",
                color: Colors.white, width: size.width),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset("asset/top2.png",
                color: Colors.white, width: size.width),
          ),
          Positioned(top: 200,
          
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                  Color.fromARGB(255, 48, 47, 114), BlendMode.color),
              child: Image.asset(
                "asset/main.png",
                width: size.width * 0.3,
              ),
            ),
          ),
        
          
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset("asset/bottom1.png",
                color: Colors.white, width: size.width),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset("asset/bottom2.png",
                color: Colors.white, width: size.width),
          ),
          child
        ],
      ),
    );
  }
}
