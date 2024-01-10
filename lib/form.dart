import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'client.dart';
//comment
class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  final response =
  http.get(Uri.parse('https://projectaz.000webhostapp.com/saveBuy.php'));

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController houseNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();


  Map<String, String> housePrices = {
    'Beirut': '100000',
    'Baalbak': '200000',
    'Tyre': '300000',
  };

  String selectedHouseName = 'Beirut';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Client Form'),
        centerTitle: true,
      ),
      body: Center(child:Padding(
        padding: const EdgeInsets.all(16.0),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: selectedHouseName,
                onChanged: (value) {
                  setState(() {
                    selectedHouseName = value!;
                    // Automatically update the price when the house is selected
                    priceController.text = housePrices[selectedHouseName] ?? '';
                  });
                },
                items: housePrices.keys.map((option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'House Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a house name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: priceController,
                readOnly: true,
                // Price is automatically calculated and cannot be edited
                decoration: InputDecoration(labelText: 'Price'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a house name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _saveData();
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }

  Future<void> _saveData() async {
    try {

      final checkResponse = await http.get(
        Uri.parse(
            'https://projectaz.000webhostapp.com/checkHouse.php?houseName=${selectedHouseName}'),
      );

      if (checkResponse.statusCode == 200) {

        Map<String, dynamic> checkData = json.decode(checkResponse.body);

        if (checkData['exists'] == true) {

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: The selected house had been sold.'),
            ),
          );
          return;
        }
      } else {

        print('Error: ${checkResponse.reasonPhrase}');
        return;
      }


      final saveResponse = await http.post(
        Uri.parse('https://projectaz.000webhostapp.com/saveBuy.php'),
        body: {
          'name': nameController.text,
          'phone': phoneController.text,
          'houseName': selectedHouseName,
          'price': priceController.text,
        },
      );

      if (saveResponse.statusCode == 200) {

        print('Data saved successfully!');

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Clients()),
        );
      } else {

        print('Error: ${saveResponse.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}