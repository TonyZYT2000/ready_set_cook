import 'package:flutter/material.dart';
import 'package:ready_set_cook/shared/constants.dart';
//import 'package:ready_set_cook/models/ingredient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Manual extends StatefulWidget {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  @override
  _ManualState createState() => _ManualState();
}

class _ManualState extends State<Manual> {
  final _formKey = GlobalKey<FormState>();
  String _ingredientName = '';
  var _quantity = 0;
  DateTime _addDate = null;
  var _unit = '';
  // Ingredient ingredient = new ;

  void _onSubmit() {
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      widget._controller1.clear();
      widget._controller2.clear();
      widget._controller3.clear();
      _formKey.currentState.save();
      FirebaseFirestore.instance.collection('storage2').add({
        "ingredientName": _ingredientName,
        "quantity": _quantity,
        "dateAdded": _addDate,
        "unit": _unit
      });
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        hintText: 'Enter Ingredient Name'),
                    onChanged: (val) {
                      setState(() => _ingredientName = val);
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
                        hintText: 'Enter Quantity'),
                    onChanged: (val) {
                      setState(() => _quantity = int.parse(val));
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: widget._controller3,
                    key: ValueKey("unit"),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "please enter valid unit";
                      }
                      return null;
                    },
                    decoration:
                        textInputDecoration.copyWith(hintText: 'Enter unit'),
                    onChanged: (val) {
                      setState(() => _unit = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                      color: Colors.blue[400],
                      child: Text(
                        'Enter',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: _onSubmit
                      // onPressed: () async {
                      //   _addDate = new DateTime.now();
                      //}
                      ),
                ],
              ),
            )),
      ),
    );
  }
}
