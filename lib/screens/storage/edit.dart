import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ready_set_cook/shared/constants.dart';
import 'package:ready_set_cook/models/ingredient.dart';
import 'package:ready_set_cook/services/grocery.dart';

class Edit extends StatefulWidget {
  Edit({this.docName});
  final docName;
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  int _quantity = 0;
  String _unit = '';
  DateTime _startDate = DateTime.now();

  void _onSubmit() {
    final User user = FirebaseAuth.instance.currentUser;
    final uid = user.uid;
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      widget._controller1.clear();
      widget._controller2.clear();
      widget._controller3.clear();
      _formKey.currentState.save();
      FirebaseFirestore.instance.collection('grocery').doc(uid).collection('groceryList').doc(widget.docName).update({
        "name": _name,
        "quantity": _quantity,
        "unit": _unit,
        "startDate": _startDate,
        "nutrition": null,
        "shelfLife": 15,
        "spoilage": false
      });
    }
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Edit Items'), backgroundColor: Colors.cyan),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: widget._controller1,
                      key: ValueKey("ingredient name"),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "please enter valid ingredient name";
                        }
                        return null;
                      },
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Update Ingredient Name'),
                      onChanged: (val) {
                        setState(() => _name = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: widget._controller2,
                      key: ValueKey("quantity"),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "please enter valid quantity";
                        }
                        return null;
                      },
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Update Quantity'),
                      onChanged: (val) {
                        setState(() => _quantity = int.parse(val));
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: widget._controller3,
                      key: ValueKey("unit"),
                      // validator: (value) {
                      //   if (value.isEmpty) {
                      //     return "please enter valid unit";
                      //   }
                      //   return null;
                      // },
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Update Unit (Optional)'),
                      onChanged: ([val]) {
                        setState(() => _unit = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                        color: Colors.blue[400],
                        child: Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: _onSubmit),
                  ],
                ),
              )),
        ));
  }
}
