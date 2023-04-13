import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:fyp_bees/main_page.dart';


class park extends StatefulWidget {
  const park({Key? key}) : super(key: key);

  @override
  _parkState createState() => _parkState();
}

class _parkState extends State<park> {
  Position? _currentPosition;
  String _currentAddress = '';
  TextEditingController textEditingController = TextEditingController();
  int hives = 0; //number of hives

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 250, 173, 58),
        centerTitle: true, // set this property to center the text
        title: Text('New Location'),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
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
                  "assets/location.jpeg", // Replace with the path to your asset image
                  fit: BoxFit.cover), // set the desired height
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
              child: Column(children: [
                TextFormField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        hintText: "Previous location",
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
                        hintText: "New location",
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
                // Row(children: [
                //   SizedBox(width: 20),
                //   if (_currentPosition != null)
                //     Text(
                //       "Latitude: ${_currentPosition!.latitude}",
                //       style: TextStyle(fontSize: 14),
                //     ),
                //   SizedBox(width: 40),
                //   if (_currentPosition != null)
                //     Text(
                //       "Longitude: ${_currentPosition!.longitude}",
                //       style: TextStyle(fontSize: 14),
                //     ),
                //   SizedBox(height: 15),
                // ])
              ])),
          // SizedBox(height: 50),
          // ElevatedButton(
          //   child: Text(
          //     "Get Location",
          //     style: TextStyle(fontSize: 20, color: Colors.white),
          //   ),
          //   onPressed: () {
          //     _getCurrentLocation();
          //   },
          //   style: ButtonStyle(
          //     backgroundColor:
          //         MaterialStateProperty.all(Color.fromARGB(255, 250, 173, 58)),
          //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //       RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(10),
          //       ),
          //     ),
          //   ),
          // ),
          SizedBox(height: 30),
          ElevatedButton(
            child: Text(
              "Update Location",
              style: TextStyle(fontSize: 18, color: Colors.white,fontFamily: 'Roboto',fontWeight: FontWeight.bold,),
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


        },
        backgroundColor: Color.fromARGB(255, 250, 173, 58),
        child: Icon(Icons.check),
      ),
      //),
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
      makePostRequest();
    });
    //_getAddressFromLatLng();
  }

  // void _getAddressFromLatLng() async {
  //   try {
  //     final List<Placemark> placemarks = await placemarkFromCoordinates(
  //         _currentPosition!.latitude, _currentPosition!.longitude);
  //
  //     if (placemarks != null && placemarks.isNotEmpty) {
  //       setState(() {
  //         _currentAddress =
  //             '${placemarks[0].street}, ${placemarks[0].locality}, ${placemarks[0].postalCode}, ${placemarks[0].country}';
  //         print(_currentAddress);
  //       });
  //     }
  //   } catch (e) {
  //     //print(e);
  //   }
  // }

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
      TextEditingController controller = TextEditingController(text: data);
      setState(() {
        textEditingController=controller;
      });
    } else {
      print('POST request failed with status: ${response.statusCode}.');
    }
  }
}
