import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sample_application/model_bp2.dart';

// Run on emulator url is 10.0.2.2
//Run on real android devices url will be laptop IPv4 address

class Modeldetail extends StatefulWidget {
  const Modeldetail({Key? key, required this.model2, required this.ontoggle})
      : super(key: key);

  final Model model2;
  final void Function(Model model) ontoggle;

  @override
  _ModeldetailState createState() => _ModeldetailState();
}

class _ModeldetailState extends State<Modeldetail> {
  bool isFavorited = false;
  late Future<void> _trainingFuture;

  Future<void> trainModel(String category, String id) async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:5000/train/$category'),
      );

      if (response.statusCode == 200) {
        // Success
        print('$category model with id $id trained successfully');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text(
                'MODEL TRAINED SUCCESFFULY',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.white,
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            );
          },
        );
      } else {
        // Handle error
        print(
            'Failed to train $category model with id $id. Status code: ${response.statusCode}');
        showErrorMessage('Failed to connect to the server');
      }
    } catch (e) {
      // Handle exception
      print('Error: $e');
      showErrorMessage('Failed to connect to the server');
    }
  }

  Future<void> fetchAccuracy(String category, String id) async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:5000/accuracy'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final Map<String, dynamic> accuracies = data['test_accuracies'];

        // Extract accuracy for the specific category
        final double testAccuracy = accuracies[category];

        // Format the accuracy value to show two decimal places
        final formattedAccuracy = testAccuracy.toStringAsFixed(2);

        // Display the accuracy in your Flutter app as needed
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Accuracy',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              content: Text(
                'Test Accuracy: $formattedAccuracy',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.white,
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            );
          },
        );
      } else {
        print(
            'Failed to fetch accuracy for $category model with id $id. Status code: ${response.statusCode}');
        showErrorMessage('Failed to connect to the server');
      }
    } catch (e) {
      // Handle exception
      print('Error: $e');
      showErrorMessage('Failed to connect to the server');
    }
  }

  Future<void> fetchConfusionMatrix(String category, String id) async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:5000/confusion_matrix/$category'),
      );

      if (response.statusCode == 200) {
        // Display the confusion matrix image in your Flutter app as needed
        // You can save the image to a file and then display it using Image.file
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Confusion Matrix'),
              content: Image.network(
                'http://10.0.2.2:5000/confusion_matrix/$category',
                height: 500, // Set the height as needed
                width: 500, // Set the width as needed
              ), // Update with your actual Flask server IP
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
      } else {
        // Handle error
        print(
            'Failed to fetch confusion matrix for $category model with id $id. Status code: ${response.statusCode}');
        showErrorMessage('Failed to connect to the server');
      }
    } catch (e) {
      // Handle exception
      print('Error: $e');
      showErrorMessage('Failed to connect to the server');
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(
            message,
            style: const TextStyle(color: Colors.red),
          ),
          backgroundColor: Colors.white,
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _trainingFuture = Future.value(); // Initial state: no ongoing training
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.model2.title),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isFavorited = !isFavorited;
              });
              widget.ontoggle(widget.model2);
            },
            icon: Icon(
              Icons.star,
              color: isFavorited ? Colors.yellow : Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              widget.model2.imageUrl,
              height: 300,
              width: double.infinity,
            ),
            const SizedBox(height: 5),
            const Text(
              'Description',
              style: TextStyle(fontSize: 25, color: Colors.orange),
            ),
            for (final description in [widget.model2.description])
              Text(
                description,
                style: const TextStyle(color: Colors.white, fontSize: 17),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 10),
            FutureBuilder<void>(
              future: _trainingFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // If the Future is still running, show a loading indicator
                  return const CircularProgressIndicator();
                } else {
                  // If the Future is complete, show the Train, Accuracy, and Confusion Matrix buttons
                  return Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Trigger the trainModel function based on the category and id of the model
                          setState(() {
                            _trainingFuture = trainModel(
                                widget.model2.categories.first,
                                widget.model2.id);
                          });
                        },
                        child: const Text('Train'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Trigger the fetchAccuracy function based on the category and id of the model
                          fetchAccuracy(
                              widget.model2.categories.first, widget.model2.id);
                        },
                        child: const Text('Accuracy'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Trigger the fetchConfusionMatrix function based on the category and id of the model
                          fetchConfusionMatrix(
                              widget.model2.categories.first, widget.model2.id);
                        },
                        child: const Text('Confusion Matrix'),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
