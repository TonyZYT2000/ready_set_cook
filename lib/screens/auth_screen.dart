import 'package:auth_screen/widgets/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;
  void _submitAuthForm(String email, String password, String firstname,
      String lastname, bool isLogin, BuildContext ctx) async {
    UserCredential authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        print("updating");
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: email);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: email);
        FirebaseFirestore.instance.collection('users').doc(authResult.user.uid).set({
          'first name': firstname,
          'last name': lastname,
          'email': email
        });
      }
    } on PlatformException catch (err) {
      print("error");
      var message = 'An error occurred, please check your credentials';

      if (err.message != null) {
        message = err.message;
      }

      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(ctx).errorColor,
      ));
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      _isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF26DBE5), body: AuthForm(_submitAuthForm, _isLoading));
  }
}
