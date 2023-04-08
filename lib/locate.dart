import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:fyp_bees/main_page.dart';


class location extends StatefulWidget {
  const location({Key? key}) : super(key: key);

  @override
  _locationState createState() => _locationState();
}

class _locationState extends State<location> {
  Position? _currentPosition;
  String _currentAddress = '';
  TextEditingController _addressController = TextEditingController();
  int hives = 0; //number of hives



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 250, 173, 58),
        centerTitle: true, // set this property to center the text
        title: Text('Register Colony'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150, // set the desired width
              height: 150, // set the desired height
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 253, 202, 106),
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('colony.png'),
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
                child: Column(children: [
                  TextFormField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(20),
                          hintText: "contact#",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 211, 211, 211),
                                width: 1.0,
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 211, 211, 211),
                                width: 1.0,
                              )),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                      onChanged: (value) {}),
                  SizedBox(height: 15),
                  TextFormField(

                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(20),
                          hintText: "Address",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 211, 211, 211),
                                width: 1.0,
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 211, 211, 211),
                                width: 1.0,
                              )),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                      controller: _addressController,
                      onChanged: (value) {}),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(20),
                          hintText: "Total Hives",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 211, 211, 211),
                                width: 1.0,
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 211, 211, 211),
                                width: 1.0,
                              )),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                      onChanged: (value) {
                        setState(() {
                          hives = int.parse(value);
                          print("total $hives");
                        });
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  Row(children: [
                    SizedBox(width: 20),
                    if (_currentPosition != null)
                      Text(
                        "Latitude: ${_currentPosition!.latitude}",
                        style: TextStyle(fontSize: 14),
                      ),
                    SizedBox(width: 40),
                    if (_currentPosition != null)
                      Text(
                        "Longitude: ${_currentPosition!.longitude}",
                        style: TextStyle(fontSize: 14),
                      ),
                    SizedBox(height: 15),
                  ])
                ])),
            SizedBox(height: 50),
            ElevatedButton(
              child: Text(
                "Get Location",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              onPressed: () {
                _getCurrentLocation();
                makePostRequest();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 250, 173, 58)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              child: Text(
                "Register...",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(
                      value: hives,
                    ),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 250, 173, 58)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _getCurrentLocation();
  // }


  void _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = position;
    });
    _getAddressFromLatLng();

  }

  void _getAddressFromLatLng() async {
    try {
      final List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);

      if (placemarks != null && placemarks.isNotEmpty) {
        setState(() {
          _currentAddress =
          '${placemarks[0].street}, ${placemarks[0].locality}, ${placemarks[0].postalCode}, ${placemarks[0].country}';
          print(_currentAddress);
        });
      }
    } catch (e) {
      //print(e);
    }
  }

  Future<void> makePostRequest() async {
    double longitude = _currentPosition!.longitude,
        latitude = _currentPosition!.latitude;
    final url = Uri.parse('http://159.203.147.149:8080/api/location-to-adress');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'longitude': longitude, 'latitude': latitude});

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      print('POST request successful');
      var jsonResponse = jsonDecode(response.body);

      // Access the JSON data
      var data = jsonResponse['address'];
      print(data);
    } else {
      print('POST request failed with status: ${response.statusCode}.');
    }
  }

}