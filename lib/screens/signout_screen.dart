import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Signout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      child: Center(
        child: RaisedButton(
          child: Text("Sign Out"),
          onPressed: (){
            FirebaseAuth.instance.signOut();
          },
        )
      )
    )
    );
    // return 
  }
}