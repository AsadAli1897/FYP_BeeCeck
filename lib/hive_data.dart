import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

//variables..................
int cardTempText = 0;
int cardSoundText = 0;
int cardHumiText = 0;

class HiveData extends StatefulWidget {
  final int index;

  const HiveData({Key? key, required this.index}) : super(key: key);

  @override
  _HiveDataState createState() => _HiveDataState();
}

class _HiveDataState extends State<HiveData> {
  void updateCardText(int temp, int sound, int humi) {
    setState(() {
      cardTempText = temp;
      cardSoundText = sound;
      cardHumiText = humi;
    });
  }

  final String _url = 'http://159.203.147.149:8050/';

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
        title: Text('Data ${widget.index}'),
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
                              onPressed: () => updateCardText(10, 20, 200),
                              child: Text('Daily'),

                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 173, 98, 71)),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),

                                  ),
                                ),
                                foregroundColor: MaterialStateProperty.all(Colors.white),
                              ),

                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () => updateCardText(20, 160, 37),
                              child: Text('Weekly'),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 173, 98, 71)),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                foregroundColor: MaterialStateProperty.all(Colors.white),
                              ),
                            ),

                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () => updateCardText(30, 132, 98),
                              child: Text('Monthly'),

                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 173, 98, 71)),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                foregroundColor: MaterialStateProperty.all(Colors.white),
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
}
