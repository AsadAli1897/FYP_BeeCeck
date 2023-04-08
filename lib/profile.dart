import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String imageUrl = 'https://picsum.photos/200';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        backgroundColor: Color.fromARGB(255, 250, 173, 58),
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
              margin: EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
              child: TextFormField(
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
            ),
            Container(
              margin: EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
              child: TextFormField(
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
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
              child: TextFormField(
                //controller: firstnameController,
                //  initialValue: _fName,

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
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
              child: TextFormField(
                //controller: firstnameController,
                //  initialValue: _fName,

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
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 80, right: 80, bottom: 30, top: 20),
              child: ElevatedButton(
                onPressed: () {
                  print('Button pressed');
                },
                child: Text(
                  'Update',
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
          ],
        ),
      ),
    );
  }
}
