import 'package:firebase_auth/firebase_auth.dart';
import 'package:ready_set_cook/screens/profile/report_error.dart';
import 'package:ready_set_cook/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:ready_set_cook/screens/profile/edit_password.dart';
import 'package:ready_set_cook/screens/profile/forgot_password.dart';
import 'package:ready_set_cook/services/auth.dart' as fire;
import 'package:ready_set_cook/models/user.dart';
import 'package:ready_set_cook/screens/profile/dietary_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthService _auth = AuthService();

  String _userName = "My Name";
  String _profilePicURL =
      "https://i0.wp.com/nerdschalk.com/wp-content/uploads/2020/08/pogger.png?resize=768%2C757&ssl=1";
  bool _notification = false;
  String _dietaryPreferences = "Kosher, Pescatarian...";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          backgroundColor: Colors.blue[50],
          body: ListView(children: <Widget>[
            ListTile(
              trailing: CircleAvatar(
                backgroundImage: NetworkImage(_profilePicURL),
              ),
              title: Text('Username'),
              subtitle: Text('$_userName'),
              onTap: () {
                // do something
              },
            ),
            ListTile(
              title: Text('Email'),
              subtitle: Text(_auth.getCurrentUserEmail()),
            ),
            ListTile(
              title: Text('Password Reset'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChangePassword()),
                );
              },
            ),
            ListTile(
              title: Text('Dietary Preferences'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Allergy()),
                );
              },
            ),
            SwitchListTile(
                title: const Text('Notification'),
                value: _notification,
                onChanged: (bool value) {
                  setState(() {
                    _notification = value;
                  });
                }),
            ListTile(
              title: Text('Report Error'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReportError()),
                );
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.person, color: Colors.red),
              label: Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ])),
    );
  }
}
