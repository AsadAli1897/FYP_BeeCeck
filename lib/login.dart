import 'dart:convert';

import 'package:fyp_bees/signup.dart';
import 'package:flutter/material.dart';
import 'package:fyp_bees/locate.dart';
import 'package:fyp_bees/main_page.dart';
import 'package:http/http.dart' as http;

bool Registration = false;

//class SignIn extends StatelessWidget
class SignIn extends StatefulWidget {
  const SignIn({
    super.key,
  });

  @override
  State<SignIn> createState() => _SignInState();
}

//just commit
class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final _uname = TextEditingController();
  final _password = TextEditingController();
  final _email = TextEditingController();
  TextEditingController _userid = TextEditingController();

  bool _isLoading = false;

  String? emailErrorText;
  String? passwordErrorText;
  String? unameErrorText;

  bool areAllFieldsFilled() {
    bool isValid = true;

    if (_uname.text.isEmpty) {
      setState(() {
        unameErrorText = 'Please enter Username';
      });
      isValid = false;
    } else {
      setState(() {
        unameErrorText = null;
      });
    }

    if (_email.text.isEmpty) {
      setState(() {
        emailErrorText = 'Please enter Email';
      });
      isValid = false;
    } else {
      setState(() {
        emailErrorText = null;
      });
    }

    if (_password.text.isEmpty) {
      setState(() {
        passwordErrorText = 'Please enter Password';
      });
      isValid = false;
    } else {
      setState(() {
        passwordErrorText = null;
      });
    }

    return isValid;
  }

  void login() {
    if (areAllFieldsFilled()) {
      // Perform login logic here
      _startLoading();
      print('Login successful');
    } else {
      // Display error or prompt to fill all fields
      print('Please fill all fields');
    }
  }

  void _startLoading() {
    _isLoading = true;
    setState(() {});

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
        SinginPostRequest();
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
                          'Sign into your Account!',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        width: 150, // set the desired width
                        height: 150, // set the desired height
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
                        child: TextFormField(
                          controller: _uname,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(20),
                              hintText: "UserName",
                              errorText: unameErrorText,
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
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(top: 20, left: 30.0, right: 30.0),
                        child: TextFormField(
                          controller: _email,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(20),
                              hintText: "Email",
                              errorText: emailErrorText,
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
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(top: 20, left: 30.0, right: 30.0),
                        child: TextFormField(
                          controller: _password,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(20),
                              hintText: "Password",
                              errorText: passwordErrorText,
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
                          obscureText: true,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10, right: 40),
                            child: Text(
                              'Forgot your password?',
                              style: TextStyle(
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 40,
                        width: 100,
                        margin: EdgeInsets.only(left: 80, right: 80, top: 20),
                        child: ElevatedButton(
                          onPressed: login,
                          child: Text(
                            'Login',
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
                              "Don't have an account? ",
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
                                    builder: (context) => SignUP()),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                "Create Account",
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

  Future<void> SinginPostRequest() async {
    final url = Uri.parse('http://34.125.82.116:8080/api/login');

    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'email': _email.text, 'password': _password.text});

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      print('POST request successful');
      var jsonResponse = jsonDecode(response.body);

      // Access the JSON data

      String data;
      data = jsonResponse['userexist'];
      int id = jsonResponse['userId'];
      //int Uid = id as int;
      print(data);
      if (data == 'true') {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Registration
                  ? MyHomePage(
                      value: 0,
                      id: id,
                    )
                  : location(Uid: id)),
        );
      }
    } else {
      print('POST request failed with status: ${response.statusCode}.');
    }
  }
}
