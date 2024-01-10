
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'client.dart';

import 'chat.dart';
import 'form.dart';

class Home extends StatefulWidget {


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  bool _showAllHouses = true;
  bool _showHousesUnder200k = false;
  bool _showHousesAbove200k = false;

  List<Map<String, dynamic>> houses = [
    {'name': 'Beirut', 'price': 100000},
    {'name': 'Baalbak', 'price': 200000},
    {'name': 'Tyre', 'price': 300000},
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredHouses;

    if (_showAllHouses) {
      filteredHouses = houses;
    } else if (_showHousesUnder200k) {
      filteredHouses = houses.where((house) => house['price'] <= 200000).toList();
    } else {
      filteredHouses = houses.where((house) => house['price'] > 200000).toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Real Estate App'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            for (Map<String, dynamic> house in filteredHouses)
              HouseItem('/${house['name']}.png', house['name']),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                _showAllHouses = true;
                _showHousesUnder200k = false;
                _showHousesAbove200k = false;
              });
            },
            child: Text('All Houses'),
          ),
          SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _showAllHouses = false;
                _showHousesUnder200k = true;
                _showHousesAbove200k = false;
              });
            },
            child: Text('Houses <= 200,000'),
          ),
          SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _showAllHouses = false;
                _showHousesUnder200k = false;
                _showHousesAbove200k = true;
              });
            },
            child: Text('Houses > 200,000'),
          ),
          SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Clients()),
              ).then((value) {
                // Refresh the home page when returning from the add house page
                setState(() {});
              });
            },
            child: Icon(Icons.shopping_cart),
          ),
        ],
      ),
    );
  }
}

class HouseItem extends StatelessWidget {
  final String assetName;
  final String pictureName;

  HouseItem(this.assetName, this.pictureName);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        height: 190,
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                assetName,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 150,
              ),
              SizedBox(height: 8),
              Text(
                pictureName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HouseDetail(pictureName)),
            );
          },
        ),
      ),
    );
  }

}






class HouseDetail extends StatelessWidget {
  final String pictureName;

  HouseDetail(this.pictureName);

  Widget getDetailWidget() {
    String detailImage;
    String detailText;

    if (pictureName == 'Beirut') {
      detailImage = 'Beirut1.png';
      detailText = '100,000 Dollar \n '
          'This house is located in the Beirut area \n '
          'and consists from 3 rooms : \n'
          '1 Living room \n '
          '1 Master Bedroom \n'
          '1 Bedroom \n'
          '1 Guest room\n'
          '1 Kitchen\n'
          '2 Bathroom\n'
          'for more info contact the Agent  \n';
    } else if (pictureName == 'Baalbak') {
      detailImage = 'Baalbak1.png';
      detailText = '200,000 Dollar \n '
          'This house is located in the Baalbak area \n '
          'and consists from 4 rooms : \n'
          '1 Living room \n '
          '3 Bedroom \n'
          '1 Machine room\n'
          '1 Kitchen\n'
          '2 Bathroom\n'
          '1 Sauna\n'
          'for more info contact the Agent  \n';
    } else {
      detailImage = 'Tyre1.png';
      detailText = '300,000 Dollar \n '
          'This house is located in the Tyre area \n '
          'and consists from 4 rooms : \n'
          '1 Living room \n'
          '1 Master bedroom \n'
          '2 Bedroom\n'
          '1 Dining room '
          '1 Kitchen\n'
          '2 Bathroom\n'
          '1 Laundry room\n'
          'for more info contact the Agent  \n';
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
            '/$detailImage', width: 600, height: 250, fit: BoxFit.cover),
        SizedBox(height: 20),
        Text(
          detailText,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details about $pictureName'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getDetailWidget(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Chat()));
              },
              child: Text('Chat with Agent'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyForm()));
              },
              child: Text('Buy'),
            ),
          ],
        ),
      ),
    );
  }
}

