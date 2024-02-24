import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Pred extends StatefulWidget {
  const Pred({Key? key}) : super(key: key);

  @override
  _PredState createState() => _PredState();
}

class _PredState extends State<Pred> {
  String? selectedModel; // Default selected model is initially null

  TextEditingController phController = TextEditingController();
  TextEditingController temperatureController = TextEditingController();
  TextEditingController turbidityController = TextEditingController();

  double inputWidth = 300.0;

  String result = '';

  Future<void> getResult() async {
    // Get input values
    double ph = double.tryParse(phController.text) ?? 0.0;
    double temperature = double.tryParse(temperatureController.text) ?? 0.0;
    double turbidity = double.tryParse(turbidityController.text) ?? 0.0;

    // Check if any input value is missing
    if (ph == 0.0 ||
        temperature == 0.0 ||
        turbidity == 0.0 ||
        selectedModel == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              'Missing Input',
              style: TextStyle(color: Colors.black),
            ),
            content: Text(
              'Please fill in all input fields .',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    // Make a POST request to the Flask server
    final Uri uri = Uri.parse('http://192.168.144.111:5000/predict');
    final Map<String, dynamic> requestData = {
      'model': selectedModel!,
      'ph': ph,
      'temperature': temperature,
      'turbidity': turbidity,
    };

    final http.Response response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestData),
    );

    // Handle response
    if (response.statusCode == 200) {
      setState(() {
        result = jsonDecode(response.body)['prediction'];
      });
    } else {
      setState(() {
        result = 'Failed to get result';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 4, 21, 35),
              Color.fromARGB(255, 69, 30, 43)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'AQUA PREDICTION',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                const SizedBox(height: 40),
                Container(
                  width: inputWidth,
                  child: TextField(
                    controller: phController,
                    decoration: InputDecoration(
                      labelText: 'pH',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      prefixIcon: Icon(Icons.checkroom, color: Colors.white),
                      hintText: 'value between 5.5 to 9.0',
                      hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.5), fontSize: 15),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  width: inputWidth,
                  child: TextField(
                    controller: temperatureController,
                    decoration: InputDecoration(
                      labelText: 'Temperature',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      prefixIcon: Icon(Icons.thermostat, color: Colors.white),
                      hintText: ' value between 4.0 to 35.0',
                      hintStyle:
                          TextStyle(color: Colors.white.withOpacity(0.5)),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  width: inputWidth,
                  child: TextField(
                    controller: turbidityController,
                    decoration: InputDecoration(
                      labelText: 'Turbidity',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      prefixIcon: Icon(Icons.waves, color: Colors.white),
                      hintText: 'value between 1.0 to 15.8',
                      hintStyle:
                          TextStyle(color: Colors.white.withOpacity(0.5)),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: inputWidth,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Choose Model',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      prefixIcon:
                          Icon(FontAwesomeIcons.chartLine, color: Colors.white),
                    ),
                    style: const TextStyle(color: Colors.white),
                    value: selectedModel,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedModel = newValue;
                      });
                    },
                    items: <String>['LSTM', 'BILSTM', 'GRU']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                            style: const TextStyle(color: Colors.white)),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.green,
                  ),
                  onPressed: () {
                    // Call function to get result
                    getResult();
                  },
                  child: const Text('GET RESULT'),
                ),
                const SizedBox(height: 20),
                Container(
                  width: inputWidth,
                  child: TextField(
                    controller: TextEditingController(text: result),
                    readOnly: true,
                    maxLines: null,
                    decoration: const InputDecoration(
                      labelText: 'Output',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.green,
                      ),
                      onPressed: () {
                        // Reset the values in the text fields
                        phController.clear();
                        temperatureController.clear();
                        turbidityController.clear();

                        // Clear the result
                        setState(() {
                          result = '';
                          selectedModel = null;
                        });
                      },
                      child: const Text('RESET'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.green,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('BACK'),
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
}
