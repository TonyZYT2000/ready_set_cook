import 'package:ready_set_cook/screens/profile/forgot_password.dart';
import 'package:ready_set_cook/services/auth.dart';
import 'package:ready_set_cook/shared/constants.dart';
import 'package:ready_set_cook/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:ready_set_cook/screens/home/home.dart';

class EditPassword extends StatefulWidget {
  final Function toggleView;
  EditPassword({this.toggleView});

  @override
  _EditPasswordState createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  // text field state
  String email = '';
  String oldPassword = '';
  String newPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[120],
        elevation: 0.0,
        title: Text('Change Password'),
        actions: <Widget>[],
        leading:
            Padding(padding: const EdgeInsets.all(8.0), child: SmallLogo()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        },
        child: Icon(Icons.arrow_back),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 40.0),
                  Text(
                    "Enter your old password!",
                    style: new TextStyle(
                      fontSize: 30.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    validator: (val) => val.isEmpty ? 'Enter an email' : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    obscureText: true,
                    decoration:
                        textInputDecoration.copyWith(hintText: 'Old Password'),
                    validator: (val) => val.length < 8
                        ? 'Enter a password 8+ chars long'
                        : null,
                    onChanged: (val) {
                      setState(() => oldPassword = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    obscureText: true,
                    decoration:
                        textInputDecoration.copyWith(hintText: 'New Password'),
                    validator: (val) => val.length < 8
                        ? 'Enter a password 8+ chars long'
                        : null,
                    onChanged: (val) {
                      setState(() => newPassword = val);
                    },
                  ),
                  SizedBox(height: 40.0),
                  RaisedButton(
                      color: Colors.blue[400],
                      child: Text(
                        'Password Reset',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, oldPassword);
                          if (result == null) {
                            setState(() {
                              error =
                                  'Could not sign in with those credentials';
                            });
                          }
                        }
                      }),

                  SizedBox(height: 40.0),
                  RaisedButton(
                      color: Colors.blue[400],
                      child: Text(
                        'I forgot my old password',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPassword()),
                        );
                      }),

                  SizedBox(height: 12.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                  SizedBox(height: 12.0),
                  //BigLogo()
                ],
              ),
            )),
      ),
    );
  }
}
