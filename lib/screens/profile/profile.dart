import 'package:flutter/material.dart';
import 'package:ready_set_cook/screens/profile/edit_password.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String _userName = "My Name";
  String _email = "myname@gmail.com";
  String _password = "*******";
  String _profilePicURL =
      "https://i0.wp.com/nerdschalk.com/wp-content/uploads/2020/08/pogger.png?resize=768%2C757&ssl=1";
  bool _notification = false;
  String _dietaryPreferences = "Kosher, Pescatarian...";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          backgroundColor: Colors.blue[50],
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.edit),
          ),
          body: ListView(children: <Widget>[
            ListTile(
              trailing: CircleAvatar(
                backgroundImage: NetworkImage(_profilePicURL),
              ),
              title: Text('User Name'),
              subtitle: Text('$_userName'),
              onTap: () {
                // do something
              },
            ),
            ListTile(
              title: Text('Email'),
              subtitle: Text('$_email'),
            ),
            ListTile(
              title: Text('Password Reset'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditPassword()),
                );
              },
            ),
            ListTile(
              title: Text('Dietary Preferences'),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                // do something
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
          ])),
    );
  }
}
