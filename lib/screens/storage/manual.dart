import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ready_set_cook/shared/constants.dart';
import 'package:ready_set_cook/models/ingredient.dart';
import 'package:ready_set_cook/services/grocery.dart';

class Manual extends StatefulWidget {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  @override
  _ManualState createState() => _ManualState();
}

class _ManualState extends State<Manual> {
  final _formKey = GlobalKey<FormState>();
  GroceryDatabase _groceryDB = null;

  String _name = '';
  int _quantity = 0;
  String _unit = '';
  DateTime _startDate = DateTime.now();

  void _onSubmit() {
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      widget._controller1.clear();
      widget._controller2.clear();
      widget._controller3.clear();
      _formKey.currentState.save();
      _groceryDB.addItem(Ingredient(
          null, _name, _quantity, _unit, _startDate, null, 15, false));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_groceryDB == null) {
      _groceryDB = GroceryDatabase(context);
    }
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
                        hintText: 'Enter Quantity'),
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
                        textInputDecoration.copyWith(hintText: 'Enter Unit (Optional)'),
                    onChanged: ([val]) {
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
                      onPressed: _onSubmit),
                ],
              ),
            )),
      ),
    );
  }
}
