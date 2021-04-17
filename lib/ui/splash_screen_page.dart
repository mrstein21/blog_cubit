import 'dart:async';
import 'package:blog/routes.dart';
import 'package:blog/ui/home/home_page.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  startSplashScreen() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, () {
      Navigator.pushNamed(context, RouterGenerator.routeHome);
    });
  }

  @override
  void initState() {
    print("eksekysi");

    this.startSplashScreen();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/logo.png",
                height: 120,
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                "Article,News And Sarcasm",
                style: TextStyle(fontFamily: "Montserrat", fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
