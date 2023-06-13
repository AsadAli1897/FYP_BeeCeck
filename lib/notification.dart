import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  List<Map<String, dynamic>> notifications = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: 16.0),
        child: isLoading ? buildProgressIndicator() : buildListView(),
      ),
    );
  }

  Widget buildProgressIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildListView() {
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        var notification = notifications[index];
        var date = notification['date'];
        var device = notification['device'];
        var location = notification['location'];
        var notificationText = notification['notification'];

        return Card(
          elevation: 4.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Date: $date",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 8.0),
                Text(
                  "Device: $device",
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
                SizedBox(height: 8.0),
                Text(
                  "Location: $location",
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
                SizedBox(height: 8.0),
                Text(
                  "Notification: $notificationText",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void fetchData() async {
    var url = Uri.parse('http://34.125.82.116:5000/get-notifications');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var responseBody = response.body;
      parseResponse(responseBody);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  void parseResponse(String response) {
    var jsonData = jsonDecode(response);
    var fetchedNotifications = jsonData['notifications'];

    if (fetchedNotifications is List && fetchedNotifications.isNotEmpty) {
      setState(() {
        notifications = fetchedNotifications
            .map<Map<String, dynamic>>((notification) => notification)
            .toList()
            .reversed
            .toList();
        isLoading = false;
      });
    } else {
      print('No notifications found.');
      setState(() {
        isLoading = false;
      });
    }
  }
}
