import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sample_application/prediciton.dart';

class Drawer1 extends StatelessWidget {
  const Drawer1({Key? key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green, Colors.blue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  FontAwesomeIcons.handshake,
                  size: 48,
                  color: Color.fromARGB(255, 25, 76, 164),
                ),
                SizedBox(width: 18),
                Text(
                  'HELLO :)',
                  style: TextStyle(
                    color: Color.fromARGB(255, 119, 22, 136),
                    fontSize: 40,
                  ),
                )
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.chartLine,
              size: 35,
              color: Colors.white,
            ),
            title: Text(
              'Prediction',
              style: TextStyle(color: Colors.deepOrange, fontSize: 25),
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => Pred()));
            }, // Corrected the onTap callback
          ),
        ],
      ),
    );
  }
}
