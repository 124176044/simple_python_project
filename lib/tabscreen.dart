import 'package:flutter/material.dart';
import 'package:sample_application/mainscreen.dart';
import 'package:sample_application/model_bp2.dart';
import 'package:sample_application/modelscreen.dart';
import 'package:sample_application/drawer.dart';

class tabscreen extends StatefulWidget {
  const tabscreen({super.key});
  @override
  State<tabscreen> createState() {
    return _tabscreen();
  }
}

class _tabscreen extends State<tabscreen> {
  int _selectindex = 0;
  final List<Model> _favouritemodel = [];

  showmessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          duration: const Duration(seconds: 4),
          content: Text(message),
          action: SnackBarAction(
              label: 'OK',
              onPressed: () {
                Navigator.pop(context);
              })),
    );
  }

  void _togglestatus(Model md) {
    final isExisting = _favouritemodel.contains(md);

    if (isExisting) {
      setState(() {
        _favouritemodel.remove(md);
      });
      showmessage('Model is no longer available');
    } else {
      setState(() {
        _favouritemodel.add(md);
      });
      showmessage('Model is added to favourite');
    }
  }

  void _selectpage(int index) {
    setState(() {
      _selectindex = index;
    });
  }

  Widget build(context) {
    Widget activepage = mainscreen(
      ontoo: _togglestatus,
    );

    if (_selectindex == 1) {
      activepage = Modelscreen(
          models: _favouritemodel, onto: _togglestatus, cate: 'Favourite');
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('DEEP LEARNING MODEL'),
      ),
      drawer: const Drawer1(),
      body: activepage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectpage,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.scatter_plot), label: 'Models_Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.start), label: 'Favourite'),
        ],
      ),
    );
  }
}
