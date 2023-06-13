import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
    fetchData();
  }

  TextEditingController textemail = TextEditingController();
  TextEditingController textname = TextEditingController();
  TextEditingController textuname = TextEditingController();

  bool isLoading = true;

  String enteredName = '';
  String enteredUname = '';
  String enteredEmail = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 250, 173, 58),
        centerTitle: true,
        title: Text('Profile'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[300],
                ),
                child: Icon(
                  Icons.person,
                  size: 80,
                  color: Colors.grey[600],
                ),
              ),
            ),
            Visibility(
              visible: !isLoading,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Color.fromARGB(255, 211, 211, 211),
                        width: 1.0,
                      ),
                    ),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: InputBorder.none,
                        hintText: 'Name',
                        hintStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: Text(
                        'Farmer', // Replace with your desired text
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          hintText: "Name",
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
                      controller: textname,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          hintText: "Uname",
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
                      controller: textuname,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          hintText: "Email",
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
                ],
              ),
            ),
            Visibility(
              visible: isLoading,
              child: CircularProgressIndicator(),
            ),
            Container(
              margin: EdgeInsets.only(left: 80, right: 80, bottom: 30, top: 20),
              child: ElevatedButton(
                onPressed: () {
                  print('Button pressed');
                  postData();
                },
                child: Text(
                  'Update',
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

  Future<void> fetchData() async {
    final url = Uri.parse('http://34.125.82.116:5000/api/user');

    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'userId': Uid});

    setState(() {
      isLoading = true;
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      print('POST request successful');
      var jsonResponse = jsonDecode(response.body);

      var name = jsonResponse['name'];
      var em = jsonResponse['email'];
      var uname = jsonResponse['username'];

      TextEditingController mailcontroller = TextEditingController(text: em);
      TextEditingController namecontroller = TextEditingController(text: name);
      TextEditingController unamecontroller =
          TextEditingController(text: uname);
      setState(() {
        textemail = mailcontroller;
        textname = namecontroller;
        textuname = unamecontroller;
        enteredName = name;
        enteredUname = uname;
        enteredEmail = em;
        isLoading = false;
      });
    } else {
      print('POST request failed with status: ${response.statusCode}.');
      setState(() {
        isLoading = false;
      });
    }
  }

  void postData() {
    setState(() {
      enteredName = textname.text;
      enteredUname = textuname.text;
      enteredEmail = textemail.text;
      ppostData();
    }); // Add code here to send the POST request with the entered values
  }

  Future<void> ppostData() async {
    final url = Uri.parse('http://34.125.82.116:5000/api/update/user');

    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'userId': Uid,
      'name': enteredName,
      'username': enteredUname,
      'email': enteredEmail
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      print('POST request successful');
      var jsonResponse = jsonDecode(response.body);

      var ttname = jsonResponse['name'];
      var ttem = jsonResponse['email'];
      var ttuname = jsonResponse['username'];
      print(ttname);
      print(ttuname);
      print(ttem);
    } else {
      print('POST request failed with status: ${response.statusCode}.');
    }
  }
}

