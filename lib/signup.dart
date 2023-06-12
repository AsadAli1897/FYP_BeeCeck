import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyp_bees/login.dart';
import 'package:http/http.dart' as http;

class SignUP extends StatefulWidget {
  const SignUP({
    super.key,
  });

  @override
  State<SignUP> createState() => _SignUpState();
}

//just commit
class _SignUpState extends State<SignUP> {
//Variables for geting data from user
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _uname = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  get jsonResponse => null;

//Cleaning the resources...........
  @override
  void dispose() {
    _name.dispose();
    _uname.dispose();
    _email.dispose();
    _password.dispose();

    super.dispose();
  }

  bool _isLoading = false;

  void _startLoading() {
    _isLoading = true;
    setState(() {});

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
        SignUpPostRequest();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignIn()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : SafeArea(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'Create an Account!',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        width: 120, // set the desired width
                        height: 120, // set the desired height
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 253, 202, 106),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/logo.png'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'ApisGuardian',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 30.0, right: 30.0),
                        child: Column(
                          children: [
                            TextFormField(
                              controller:
                                  _uname, //it gets the value that a user enter
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(20),
                                  hintText: "User name",
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 211, 211, 211),
                                        width: 1.0,
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 211, 211, 211),
                                        width: 1.0,
                                      )),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30))),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller:
                                  _name, //it gets the value that a user enter
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(20),
                                  hintText: "Name",
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 211, 211, 211),
                                        width: 1.0,
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 211, 211, 211),
                                        width: 1.0,
                                      )),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30))),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller:
                                  _email, //it gets the value that a user enter
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(20),
                                hintText: "Email",
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
                                    borderRadius: BorderRadius.circular(30)),
                              ),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller:
                                  _password, //it gets the value that a user enter

                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(20),
                                  hintText: "Password",
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 211, 211, 211),
                                        width: 1.0,
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 211, 211, 211),
                                        width: 1.0,
                                      )),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30))),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(20),
                                  hintText: "Confirm password",
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 211, 211, 211),
                                        width: 1.0,
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 211, 211, 211),
                                        width: 1.0,
                                      )),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30))),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 100,
                        margin: EdgeInsets.only(left: 80, right: 80, top: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            // print('Button pressed');
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => SignIn()),
                            // );
                            _startLoading();
                            // if (_isLoading == false) {
                            // if (_formKey.currentState!.validate()) {
                            //   // TODO: Implement login logic

                            //   SignUpPostRequest();
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => SignIn()),
                            //   );
                            // }
                            // }
                          },
                          child: Text(
                            'SignUp',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 250, 173, 58)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10, left: 40),
                            child: Text(
                              "Already have an account? ",
                              style: TextStyle(
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignIn()),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                "SignIn",
                                style: TextStyle(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 250, 173, 58),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Future<void> SignUpPostRequest() async {
    //final url = Uri.parse('http://159.203.147.149:8080/api/user/register');
    final url = Uri.parse('http://34.125.82.116:8080/api/user/register');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'name': _name.text,
      'username': _uname.text,
      'email': _email.text,
      'password': _password.text,
      'role': "Farmer"
    });

    final response = await http.post(url, headers: headers, body: body);
    //print(jsonResponse['UserID']);
    if (response.statusCode == 200) {
      print('POST request successful');
      var jsonResponse = jsonDecode(response.body);

      // Access the JSON data
      //var data = jsonResponse['token'];
      // String data;
      // data = jsonResponse['done'];
      // print(data);
      // if (data != 'true') {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => SignIn()),
      //   );
      // }
    } else {
      print('POST request failed with status: ${response.statusCode}.');
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => SignIn()),
      // );
      print(_name.text);
      print(_uname.text);
      print(_email.text);
      print(_password.text);
    }
  }
}
