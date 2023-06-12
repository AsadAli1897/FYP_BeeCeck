import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:fyp_bees/main_page.dart';

class location extends StatefulWidget {
  final int Uid;
  const location({Key? key, required this.Uid}) : super(key: key);

  @override
  _locationState createState() => _locationState();
}

class _locationState extends State<location> {
  Position? _currentPosition;
  String _currentAddress = '';
  TextEditingController textEditingController = TextEditingController();
  TextEditingController _contact = TextEditingController();
  int hives = 0;
  int Uid = 0;

  @override
  void initState() {
    super.initState();
    Uid = widget.Uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 250, 173, 58),
        centerTitle: true, // set this property to center the text
        title: Text('Register Colony'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Container(
            height: 200, // Replace with your desired height
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                  10), // Replace with your desired border radius
              child: Image.asset(
                  "assets/colony2.jpeg", // Replace with the path to your asset image
                  fit: BoxFit.cover), // set the desired height
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
              child: Column(children: [
                TextFormField(
                    controller: _contact,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        hintText: "contact#",
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 211, 211, 211),
                              width: 1.0,
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 211, 211, 211),
                              width: 1.0,
                            )),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onChanged: (value) {}),
                SizedBox(height: 10),
                TextFormField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        hintText: "Address",
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 211, 211, 211),
                              width: 1.0,
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 211, 211, 211),
                              width: 1.0,
                            )),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    controller: textEditingController,
                    onChanged: (value) {}),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        hintText: "Total Hives",
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 211, 211, 211),
                              width: 1.0,
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 211, 211, 211),
                              width: 1.0,
                            )),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onChanged: (value) {
                      setState(() {
                        hives = int.parse(value);
                        print("total $hives");
                      });
                    }),
              ])),
          SizedBox(height: 50),
          ElevatedButton(
            child: Text(
              "Get Location",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              _getCurrentLocation();
            },
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Color.fromARGB(255, 250, 173, 58)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(Uid);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyHomePage(
                value: hives,
                id: Uid,
              ),
            ),
          );
        },
        backgroundColor: Color.fromARGB(255, 250, 173, 58),
        child: Icon(Icons.check),
      ),
    );
  }

  void _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = position;
      makePostRequest();
    });
  }

  Future<void> makePostRequest() async {
    double longitude = _currentPosition!.longitude,
        latitude = _currentPosition!.latitude;
    final url = Uri.parse('http://34.125.82.116:8080/api/location-to-adress');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'longitude': longitude, 'latitude': latitude});

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      print('POST request successful');
      var jsonResponse = jsonDecode(response.body);

      // Access the JSON data
      var data = jsonResponse['address'];
      print(data);
      TextEditingController controller = TextEditingController(text: data);
      setState(() {
        textEditingController = controller;
      });
    } else {
      print('POST request failed with status: ${response.statusCode}.');
    }
  }
}
