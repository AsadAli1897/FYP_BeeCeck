import 'package:flutter/material.dart';
import 'package:fyp_bees/login.dart';

class SignUP extends StatefulWidget {
  const SignUP({
    super.key,
  });

  @override
  State<SignUP> createState() => _SignUpState();
}

//just commit
class _SignUpState extends State<SignUP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                    //controller: firstnameController,
                    //  initialValue: _fName,

                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        hintText: "UserName",
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
                  SizedBox(height: 10),
                  TextFormField(
                    //controller: firstnameController,
                    //  initialValue: _fName,

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
                    //controller: firstnameController,
                    //  initialValue: _fName,

                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        hintText: "Password",
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
                  SizedBox(height: 10),
                  TextFormField(
                    //controller: firstnameController,
                    //  initialValue: _fName,

                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        hintText: "Confirm password",
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
                ],
              ),
            ),
            Container(
              height: 40,
              width: 100,
              margin: EdgeInsets.only(left: 80, right: 80, top: 20),
              child: ElevatedButton(
                onPressed: () {
                  print('Button pressed');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignIn()),
                  );
                },
                child: Text(
                  'SignUp',
                  style: TextStyle(color: Colors.white),
                ),
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
                      MaterialPageRoute(builder: (context) => SignIn()),
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
    );
  }
}
