import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp_bees/hive_data.dart';
import 'package:fyp_bees/profile.dart';
import 'package:fyp_bees/parking.dart';
import 'package:fyp_bees/login.dart';


class MyHomePage extends StatefulWidget {
  final int value;

  const MyHomePage({Key? key, required this.value}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _searchTerm = '';
  int _counter = 0;
  final TextEditingController _num_hives = TextEditingController();
  int hives = 0; //number of hives

  int hive_ind = 0; //hive index

  @override
  void initState() {
    super.initState();
    hives = widget.value;
  }

  void _onHiveTap(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HiveData(index: index),
      ),
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
              'hive.png',
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
            onPressed: () async {
              // final searchTerm = await showSearch(
              //   context: context,
              //   delegate: CardNumberSearchDelegate(),
              // );
              // setState(() {
              //   _searchTerm = searchTerm ?? ' ';
              // });
              // Open search screen
              print("jkajsdhjashjasf    $hive_ind");
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
                    image: AssetImage('logo.png'),
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

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
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
              leading: Icon(Icons.stacked_bar_chart_rounded),
              title: Text('States'),
              iconColor: Color.fromARGB(255, 165, 109, 6),
              textColor: Colors.black87,
              onTap: () {},
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
        child: GridView.builder(
          itemCount: hives,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                print("pressed");
                //Get.to(() => SignUP());
              },
              child: GridTile(
                child: get_card(index + 1),
              ),
            );
          },
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
