import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

//variables..................
int cardTempText = 0;
String cardSoundText = '0';
int cardHumiText = 0;

class HiveData extends StatefulWidget {
  final int index;
  final int Uid;

  const HiveData({Key? key, required this.index, required this.Uid})
      : super(key: key);

  @override
  _HiveDataState createState() => _HiveDataState();
}

class _HiveDataState extends State<HiveData> {
  int Uid = 0;
  int index = 0;

  @override
  void initState() {
    super.initState();
    Uid = widget.Uid;
    index = widget.index;
  }

  void updateCardText(
    int temp,
    int humi,
    String sound,
  ) {
    print(Uid);
    setState(() {
      cardTempText = temp;
      cardSoundText = sound;
      cardHumiText = humi;
    });
  }

  final String _url = 'http://34.125.82.116:8050/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 250, 173, 58),
        centerTitle: true, // set this property to center the text
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // add navigation logic here
            Navigator.pop(context);
          },
        ),
        title: Text('Data ${index}'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () => DailyAverages(),
                              child: Text('Daily'),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 173, 98, 71)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () => WeeklyAverages(),
                              child: Text('Weekly'),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 173, 98, 71)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () => MonthlyAverages(),
                              child: Text('Monthly'),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 173, 98, 71)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 243, 167, 54),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(30),
                            topRight: Radius.circular(30)),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 243, 167, 54),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(30),
                              topRight: Radius.circular(30)),
                        ),
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 60,
                              width: null,
                              child: Card(
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        '$cardTempText',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 8.0),
                                      Text(
                                        'Avg. temp(C)',
                                        style: TextStyle(fontSize: 8.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 60,
                              width: null,
                              child: Card(
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        '$cardHumiText',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 8.0),
                                      Text(
                                        'Avg. Humi(C)',
                                        style: TextStyle(fontSize: 8.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 60,
                              width: null,
                              child: Card(
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        '$cardSoundText',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 8.0),
                                      Text(
                                        'Avg. Sound(A)',
                                        style: TextStyle(fontSize: 8.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),

              /////////
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.only(top: 10),
              child: kIsWeb
                  ? Center(
                      child: Text("WebView not supported on the web"),
                    )
                  : WebView(
                      initialUrl: _url,
                      javascriptMode: JavascriptMode.unrestricted,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> DailyAverages() async {
    final url = Uri.parse('http://34.125.82.116:5000/averages');
    final headers = {'Content-Type': 'application/json'};
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      print('GET request successful');
      var jsonResponse = jsonDecode(response.body);

      // Access the JSON data
      List data;
      data = jsonResponse["daily_averages"];
      //print(data[0][0]);
      int tem = data[0][0].toInt();
      int hum = data[0][2].toInt();
      String soun = data[0][1];
      print(tem);
      print(hum);

      updateCardText(tem, hum, soun);
    } else {
      print('GET request failed with status: ${response.statusCode}.');
    }
  }

  Future<void> WeeklyAverages() async {
    final url = Uri.parse('http://34.125.82.116:5000/averages');
    final headers = {'Content-Type': 'application/json'};
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      print('GET request successful');
      var jsonResponse = jsonDecode(response.body);

      // Access the JSON data
      List data;
      data = jsonResponse["weekly_averages"];
      //print(data[0][0]);
      int tem = data[0][0].toInt();
      int hum = data[0][2].toInt();
      String soun = data[0][1];
      print(tem);
      print(hum);

      updateCardText(tem, hum, soun);
    } else {
      print('GET request failed with status: ${response.statusCode}.');
    }
  }

  Future<void> MonthlyAverages() async {
    final url = Uri.parse('http://34.125.82.116:5000/averages');
    final headers = {'Content-Type': 'application/json'};
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      print('GET request successful');
      var jsonResponse = jsonDecode(response.body);

      // Access the JSON data
      List data;
      data = jsonResponse["monthly_averages"];
      //print(data[0][0]);
      int tem = data[0][0].toInt();
      int hum = data[0][2].toInt();
      String soun = data[0][1];
      print(tem);
      print(hum);

      updateCardText(tem, hum, soun);
    } else {
      print('GET request failed with status: ${response.statusCode}.');
    }
  }
}
