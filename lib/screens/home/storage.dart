import 'package:flutter/material.dart';
import 'package:ready_set_cook/services/auth.dart';
import 'package:ready_set_cook/shared/constants.dart';

class Storage extends StatefulWidget {
  @override
  _StorageState createState() => _StorageState();
}

class _StorageState extends State<Storage> {
  final AuthService _auth = AuthService();

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.red[100],
        appBar: AppBar(
          title: Text('Storage'),
          backgroundColor: Colors.blue[120],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Return Home'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
          leading:
              Padding(padding: const EdgeInsets.all(8.0), child: SmallLogo()),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.add_rounded),
              label: 'Add Food',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.food_bank),
              label: 'Remove Food',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.inbox),
              label: 'Check Date',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_box),
              label: 'Update Food',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.green[400],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
