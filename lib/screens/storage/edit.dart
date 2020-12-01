import 'package:flutter/material.dart';
import 'package:ready_set_cook/shared/constants.dart';
import 'package:ready_set_cook/services/grocery.dart';
import 'package:ready_set_cook/models/ingredient.dart';

class Edit extends StatefulWidget {
  final Ingredient _ingredient;
  Edit(this._ingredient);

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
      widget._ingredient.name = _name != null ? _name : widget._ingredient.name;
      widget._ingredient.quantity =
          _quantity != null ? _quantity : widget._ingredient.quantity;
      widget._ingredient.unit = _unit != null ? _unit : widget._ingredient.unit;

      _groceryDB.updateItem(widget._ingredient.id, widget._ingredient);

      _name = null;
      _quantity = null;
      _unit = null;
      widget._controller1.clear();
      widget._controller2.clear();
      widget._controller3.clear();
      _formKey.currentState.save();
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
                    Container(
                        height: 240,
                        width: 250,
                        child: (widget._ingredient.imageUrl == null)
                            ? Image(
                                image: NetworkImage(
                                    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/480px-No_image_available.svg.png"))
                            : Image(
                                image:
                                    NetworkImage(widget._ingredient.imageUrl))),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: widget._controller1,
                      key: ValueKey("ingredient name"),
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Update Name: ' + widget._ingredient.name),
                      onChanged: (val) {
                        setState(() => _name = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: widget._controller2,
                      key: ValueKey("quantity"),
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Update Quantity: ' +
                              widget._ingredient.quantity.toString()),
                      onChanged: (val) {
                        setState(() => _quantity = int.parse(val));
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: widget._controller3,
                      key: ValueKey("unit"),
                      decoration: textInputDecoration.copyWith(
                          hintText: 'Update Unit: ' + widget._ingredient.unit),
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
