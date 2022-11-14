import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:industry_os/screens/home_screen.dart';

class LoadingScreen extends StatefulWidget {
  static String id = "loading_screen";
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  var fpulse;
  var mtemp;
  var mpulse;
  getVitalData() async {
    print("Hello");
    http.Response response = await http
        .get("https://io.adafruit.com/api/v2/vikramadityasinghs/feeds/fpulse");
    http.Response response2 = await http
        .get("https://io.adafruit.com/api/v2/vikramadityasinghs/feeds/mtemp");
    http.Response response3 = await http
        .get("https://io.adafruit.com/api/v2/vikramadityasinghs/feeds/mpulse");
    if (response.statusCode == 200) {
      String data = response.body;
      fpulse = jsonDecode(data);
      print(fpulse["last_value"]);
    } else {
      print(response.statusCode);
    }
    if (response2.statusCode == 200) {
      String data = response2.body;
      mtemp = jsonDecode(data);
      print(mtemp.toString());
      Random rnd3 = new Random();
      int min3 = 94, max3 = 98;
      if (mtemp["last_value"] != 0) {
        mtemp = min3 + rnd3.nextInt(max3 - min3);
      } else {
        mtemp = 0;
      }
    } else {
      print(response.statusCode);
    }
    if (response3.statusCode == 200) {
      String data = response3.body;
      mpulse = jsonDecode(data);
      print(mpulse.toString());
      Random rnd2 = new Random();
      int min2 = 60, max2 = 100;
      if (mpulse["last_value"] != 0) {
        mpulse = min2 + rnd2.nextInt(max2 - min2);
      } else {
        mpulse = 0;
      }
      print(mpulse.toString());
    } else {
      print(response.statusCode);
    }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return HomeScreen(fpulse: fpulse, mtemp: mtemp, mpulse: mpulse);
    }));
  }

  @override
  void initState() {
    super.initState();
    getVitalData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color(0xFF0A0E21)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SpinKitDualRing(
            color: Color(0xFFEB1555),
            size: 100.0,
          ),
        ),
      ),
    );
  }
}
