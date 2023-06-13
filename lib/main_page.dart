import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp_bees/hive_data.dart';
import 'package:fyp_bees/profile.dart';
import 'package:fyp_bees/parking.dart';
import 'package:fyp_bees/login.dart';
import 'package:fyp_bees/notification.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  final int value, id;

  const MyHomePage({Key? key, required this.value, required this.id})
      : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _searchTerm = '';
  ScrollController _scrollController = ScrollController();
  int _counter = 0;
  final TextEditingController _num_hives = TextEditingController();
  int hives = 0; //number of hives

  int hive_ind = 0; //hive index
  int Uid = 0;
  List<Card> hiveCards = [];
  bool search = false;
  List<Card> matchingCard = [];

  @override
  void initState() {
    super.initState();
    hives = widget.value;
    Uid = widget.id;

    // Generate the list of hive cards
    for (int i = 1; i <= hives; i++) {
      hiveCards.add(get_card(i));
    }
  }

  void _onHiveTap(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HiveData(index: index, Uid: Uid),
      ),
    );
  }

  void _onSearchTap() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Search Hive'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                _searchTerm = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Enter Hive Id',
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Search'),
              onPressed: () {
                // Find the matching card index
                int matchingIndex = int.tryParse(_searchTerm) ?? -1;

                if (matchingIndex >= 1 && matchingIndex <= hives) {
                  // Filter the list to get the matching card
                  matchingCard.add(hiveCards[matchingIndex - 1]);
                  Navigator.pop(context);
                  setState(() {
                    search = true;
                  });
                }

                // Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Card get_card(int n) {
    return Card(
      elevation: 4.0,
      child: InkWell(
        onTap: () {
          // Handle tap event here
          _onHiveTap(n);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset(
              'assets/hive.png',
              //fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Hive $n',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showimage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // List<String> images = ['image.JPG'];

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        backgroundColor: Color.fromARGB(255, 250, 173, 58),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _onSearchTap,
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Implement your refresh logic here
              setState(() {
                matchingCard.clear();
                search = false;
              });
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 250, 173, 58),
              ),
              // child: Image.asset('image.JPG'),
              child: Container(
                width: 80, // set the desired width
                height: 80, // set the desired height
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 253, 202, 106),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/logo.png'),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              iconColor: Color.fromARGB(255, 165, 109, 6),
              textColor: Colors.black87,
              onTap: () {
                // TODO: Navigate to Profile screen
                //PickProfile();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileScreen(Uid: Uid)),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.location_city),
              title: Text('Update Parking'),
              iconColor: Color.fromARGB(255, 165, 109, 6),
              textColor: Colors.black87,
              onTap: () {
                // TODO: Navigate to parking screen screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => park()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notification'),
              iconColor: Color.fromARGB(255, 165, 109, 6),
              textColor: Colors.black87,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CardWidget()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              iconColor: Color.fromARGB(255, 165, 109, 6),
              textColor: Colors.black87,
              onTap: () {
                //TODO: Navigate to Login screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignIn()),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.8,
          children: search ? matchingCard : hiveCards,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('How many hives you want to Enter?'),
                content: TextField(
                  controller: _num_hives,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration:
                      InputDecoration(hintText: 'Enter number of hives'),
                ),
                actions: [
                  TextButton(
                    child: Text('Cancel',
                        selectionColor: Color.fromARGB(255, 250, 173, 58)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  TextButton(
                    child: Text('OK',
                        selectionColor: Color.fromARGB(255, 250, 173, 58)),
                    onPressed: () {
                      // Store the input in a variable

                      setState(() {
                        hives += int.parse(_num_hives.text);
                        // Generate the list of hive cards
                        for (int i = hiveCards.length + 1; i <= hives; i++) {
                          hiveCards.add(get_card(i));
                        }
                      });
                      // Do something with the input
                      // ...
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
