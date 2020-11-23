import 'package:flutter/material.dart';
import 'package:ready_set_cook/shared/constants.dart';
import 'package:ready_set_cook/services/grocery.dart';
import 'package:ready_set_cook/models/ingredient.dart';

class Edit extends StatefulWidget {
  final String _id;
  final Ingredient _ingredient;
  Edit(this._id, this._ingredient);

  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  final _formKey = GlobalKey<FormState>();
  String _name = null;
  int _quantity = null;
  String _unit = null;
  GroceryDatabase _groceryDB = null;

  void _onSubmit() {
    //final isValid = _formKey.currentState.validate();
    //if (isValid) {
    if (_name != null || _quantity != null || _unit != null) {
      widget._controller1.clear();
      widget._controller2.clear();
      widget._controller3.clear();
      _formKey.currentState.save();

      widget._ingredient.name = _name != null ? _name : widget._ingredient.name;
      widget._ingredient.quantity =
          _quantity != null ? _quantity : widget._ingredient.quantity;
      widget._ingredient.unit = _unit != null ? _unit : widget._ingredient.unit;

      _groceryDB.updateItem(widget._id, widget._ingredient);
    }
    setState(() {});
  }

  Widget build(BuildContext context) {
    if (_groceryDB == null) {
      _groceryDB = GroceryDatabase(context);
    }

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
                      /*
                      validator: (value) {
                        if (value.isEmpty) {
                          return "please enter valid ingredient name";
                        }
                        return null;
                      },
                      */
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Update Ingredient Name (Optional)'),
                      onChanged: (val) {
                        setState(() => _name = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: widget._controller2,
                      key: ValueKey("quantity"),
                      /*
                      validator: (value) {
                        if (value.isEmpty) {
                          return "please enter valid quantity";
                        }
                        return null;
                      },
                      */
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Update Quantity (Optional)'),
                      onChanged: (val) {
                        setState(() => _quantity = int.parse(val));
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: widget._controller3,
                      key: ValueKey("unit"),
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Update Unit (Optional)'),
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
