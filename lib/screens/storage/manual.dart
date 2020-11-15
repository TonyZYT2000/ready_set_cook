import 'package:flutter/material.dart';

class Manual extends StatefulWidget {
  @override
  _ManualState createState() => _ManualState();
}


class _ManualState extends State<Manual> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Manual Page', style: TextStyle(fontSize: 12)));
  }
}
