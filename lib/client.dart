import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'home.dart';

class Clients extends StatefulWidget {
  @override
  _ClientsState createState() => _ClientsState();
}

class _ClientsState extends State<Clients> {
  List<Map<String, dynamic>> buyData = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final response = await http.get(Uri.parse('https://projectaz.000webhostapp.com/getBuy.php'));

    if (response.statusCode == 200) {
      // Parse the JSON response
      List<dynamic> data = json.decode(response.body);

      // Update the state with the fetched data
      setState(() {
        buyData = List<Map<String, dynamic>>.from(data);
      });
    } else {

      ('Error: ${response.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Home()),
            (route) => false,
      );
      return false;
    },
        child: Scaffold(
    appBar: AppBar(
    title: Text(' Clients Page '),
        backgroundColor: Colors.deepPurple,
    ),
          body: Container(
            color: Colors.lightBlueAccent,
    child: ListView.builder(
      itemCount: buyData.length,
       itemBuilder: (context, index) {
    return Card(
      elevation: 5,
     margin: EdgeInsets.all(10),
       color: Colors.orangeAccent,
      child: Padding(
          padding: const EdgeInsets.all(16.0),
    child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
    children: [
           Text(
                'Name: ${buyData[index]['name']}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                      fontSize: 18,
                          color: Colors.white,
    ),
    ),
    SizedBox(height: 8),
     Text(
     'Phone: ${buyData[index]['phone']}',
         style: TextStyle(
             fontSize: 16,
               color: Colors.white,
    ),
    ),
    SizedBox(height: 8),
      Text(
        'House Name: ${buyData[index]['houseName']}',
            style: TextStyle(
              fontSize: 16,
                color: Colors.white,
    ),
    ),
    SizedBox(height: 8),
     Text(
       'Price: ${buyData[index]['price']}',
         style: TextStyle(
           fontSize: 16,
               color: Colors.white,
      ),
       ),
         ],
           ),
              ),
                 );
                    },
                      ),
                        ),
                           )
                             );

  }
}

