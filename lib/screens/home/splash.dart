import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jelajah_nusantara/screens/auth/Login_Screen.dart';
import 'package:jelajah_nusantara/screens/widgets/splashClipperBottom.dart';
import 'package:jelajah_nusantara/screens/widgets/splashClipperTop.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  double _opacity1 = 0.0;
  double _opacity2 = 0.0;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 500), () {
    setState(() {
      _opacity1 = 1.0;
    });
  });
  Timer(const Duration(milliseconds: 1500), () {
    setState(() {
      _opacity2 = 1.0;
    });
  });

  Timer(Duration(milliseconds: 2500), () {
    setState(() {
      Navigator.pushReplacement(
        context ,
        MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Align(
              alignment: AlignmentGeometry.center,
              child: ClipPath(
                clipper: WaveClipBottom(),
                child: Container(
                  color: Color(0XFFD1A824),
                  height: MediaQuery.of(context).size.height * 3/4,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedOpacity(
                        opacity: _opacity1,
                        duration: Duration(milliseconds: 800),
                        child: Text('JELAJAH',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontFamily: 'NicoMoji',
                        ),),),
                        AnimatedOpacity(
                          opacity: _opacity2,
                          duration: Duration(milliseconds: 800),
                          child: Text("NUSANTARA",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontFamily: "NicoMoji",
                          ),
                        ),
                      ),
                    ]
                  )
                ),
              ),
            ),
            ClipPath(
              clipper: WaveClipTop(),
              child: Container(
                color: Color(0XFFF6F2E5),
                height: MediaQuery.of(context).size.height * 1/3,
              ),
            ),
          ],
        )),
    );
  }
}