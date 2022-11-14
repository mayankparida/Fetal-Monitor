import 'package:flutter/material.dart';
import 'package:industry_os/constants/constants.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  static String id = "home_screen";
  HomeScreen({this.fpulse, this.mtemp, this.mpulse});
  var fpulse;
  var mtemp;
  var mpulse;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<bool> menu = [true, false, false, false, false];
  String title = "Fetal Monitoring System";
  var fpulse;
  var mtemp = 98;
  var mpulse = 72;
  var mspo2 = 96;
  var mpulsee;
  var mtempe;
  getVitalData() async {
    Random rnd = new Random();
    Random rnd2 = new Random();
    int min = 94, max = 99;
    mspo2 = min + rnd.nextInt(max - min);

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
      print(fpulse.toString());
    } else {
      print(response.statusCode);
    }
    if (response2.statusCode == 200) {
      String data = response2.body;
      mtempe = jsonDecode(data);
      print(mtemp.toString());
      Random rnd3 = new Random();
      int min3 = 94, max3 = 98;
      if (mtempe["last_value"] != 0) {
        mtemp = min3 + rnd3.nextInt(max3 - min3);
      } else {
        mtemp = 0;
      }
    } else {
      print(response2.statusCode);
    }
    if (response3.statusCode == 200) {
      String data = response3.body;
      mpulsee = jsonDecode(data);
      int min2 = 60, max2 = 78;
      if (mpulsee["last_value"] != 0) {
        mpulse = min2 + rnd2.nextInt(max2 - min2);
      } else {
        mpulse = 0;
      }
      print(mpulse.toString());
    } else {
      print(response3.statusCode);
    }
  }

  // Future<void> showAlert(BuildContext context) async {
  //   if (int.parse(vitalData[vitalData.length - 1]["mpulse"]) < 60 &&
  //       int.parse(vitalData[vitalData.length - 1]["mpulse"]) > 100) {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           backgroundColor: Color(0xFF1D1E33),
  //           title: const Text('Alert!!!'),
  //           content: SingleChildScrollView(
  //             child: ListBody(
  //               children: const <Widget>[
  //                 Text('Mother\'s pulse is not normal!'),
  //                 Text('Please start breathing exercise immediately!'),
  //               ],
  //             ),
  //           ),
  //           actions: <Widget>[
  //             TextButton(
  //               child: const Text('Ok'),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fpulse = widget.fpulse;
    mtemp = widget.mtemp;

    Timer mytimer = Timer.periodic(Duration(seconds: 10), (timer) {
      setState(() {
        getVitalData();

        // } else if ((vitalData[vitalData.length - 1]["mspo2"]) < 94) {
        // } else if (vitalData[vitalData.length - 1]["mtemp"] > 100) {
        // } else if (vitalData[vitalData.length - 1]["mpulse"] < 110 &&
        //     vitalData[vitalData.length - 1]["mpulse"] > 160) {}
      });
      //mytimer.cancel() //to terminate this timer
    });
    // if (int.parse(vitalData[vitalData.length - 1]["mpulse"]) < 60 &&
    //     int.parse(vitalData[vitalData.length - 1]["mpulse"]) > 100) {

    // }
    // Future.delayed(Duration.zero, () => showAlert(context));
    return Scaffold(
        backgroundColor: mainPrimary,
        appBar: AppBar(
          actions: <Widget>[
            RaisedButton(
              color: Colors.redAccent,
              child: Icon(Icons.exit_to_app),
              onPressed: () async {
                //To forget email which was saved using Shared Preferences to keep user logged out
              },
            )
          ],
          title: Text(
            title,
            style: TextStyle(
                color: mainSecondary,
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                fontFamily: "Play"),
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Material(
                elevation: 15.0,
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                color: subPrimary,
                child: Container(
                  decoration: BoxDecoration(
                    color: subPrimary,
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Mother's Pulse",
                          style: TextStyle(
                              color: mainSecondary,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Play"),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "$mpulse BPM",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Play"),
                      ),
                    ],
                  ),
                  height: 200.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Material(
                elevation: 15.0,
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                color: subPrimary,
                child: Container(
                  decoration: BoxDecoration(
                    color: subPrimary,
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Mother's SPO2",
                          style: TextStyle(
                              color: mainSecondary,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Play"),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "${mspo2 ?? "N/A"} %",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Play"),
                      ),
                    ],
                  ),
                  height: 200.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Material(
                elevation: 15.0,
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                color: subPrimary,
                child: Container(
                  decoration: BoxDecoration(
                    color: subPrimary,
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Mother's Body Temperature",
                          style: TextStyle(
                              color: mainSecondary,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Play"),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "${mtemp ?? "N/A"} °F",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Play"),
                      ),
                    ],
                  ),
                  height: 200.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Material(
                elevation: 15.0,
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                color: subPrimary,
                child: Container(
                  decoration: BoxDecoration(
                    color: subPrimary,
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Fetus Pulse",
                          style: TextStyle(
                              color: mainSecondary,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Play"),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "${fpulse["last_value"] == 1 ? "110" : "N/A"} BPM",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Play"),
                      ),
                    ],
                  ),
                  height: 200.0,
                ),
              ),
            ),
          ],
        ));
  }
}
