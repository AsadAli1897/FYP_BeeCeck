import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//variables..................
String username = '';
String Emaill = '';
String address = '';
String role = '';
String cont = '';

class ProfileScreen extends StatefulWidget {
  final int Uid;

  const ProfileScreen({Key? key, required this.Uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final String imageUrl = 'https://picsum.photos/200';

  int Uid = 0;
  @override
  void initState() {
    super.initState();
    Uid = widget.Uid;
  } //

  void updateprofile(String uname, String email, String addr, String rol,
      {String a = '123456789'}) {
    print(Uid);
    setState(() {
      username = uname;
      Emaill = email;
      address = addr;
      role = rol;
      cont = a;
    });
  }

  TextEditingController textemail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        backgroundColor: Color.fromARGB(255, 250, 173, 58),
        centerTitle: true, // set this property to center the text
        title: Text('Profile'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(imageUrl),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
              child: TextFormField(
                //controller: firstnameController,
                //  initialValue: _fName,

                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: "role",
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
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
              child: TextFormField(
                //controller: firstnameController,
                //  initialValue: _fName,

                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: "username",
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
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
              child: TextFormField(
                //controller: firstnameController,
                //  initialValue: _fName,

                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: "Emaill",
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
                controller: textemail,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
              child: TextFormField(
                //controller: firstnameController,
                //  initialValue: _fName,

                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: "cont",
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
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
              child: TextFormField(
                //controller: firstnameController,
                //  initialValue: _fName,

                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: "address",
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
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 80, right: 80, bottom: 30, top: 20),
              child: ElevatedButton(
                onPressed: () {
                  print('Button pressed');
                  PickProfile();
                },
                child: Text(
                  'Profile',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 250, 173, 58)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> PickProfile() async {
    final url = Uri.parse('http://34.125.82.116:8080/user');

    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'userId': Uid});

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      print('POST request successful');
      var jsonResponse = jsonDecode(response.body);

      // Access the JSON data

      var em, uname, rol;
      em = jsonResponse['email'];
      uname = jsonResponse['username'];
      rol = jsonResponse['role'];
      print(em);
      print(uname);
      print(rol);

      TextEditingController controller = TextEditingController(text: em);
      setState(() {
        textemail = controller;
      });
    } else {
      print('POST request failed with status: ${response.statusCode}.');
    }
  }
}
