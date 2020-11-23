import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ready_set_cook/models/user.dart';
import 'package:ready_set_cook/shared/constants.dart';
import 'package:ready_set_cook/models/ingredient.dart';
import 'package:ready_set_cook/services/grocery.dart';
import 'package:image_picker/image_picker.dart';

class Manual extends StatefulWidget {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  @override
  _ManualState createState() => _ManualState();
}

class _ManualState extends State<Manual> {
  final _formKey = GlobalKey<FormState>();
  // GroceryDatabase _groceryDB = null;
  
  String _name = '';
  int _quantity = 0;
  String _unit = '';
  DateTime _startDate = DateTime.now();

  File _image = null;
  final _picker = ImagePicker();
  var _imageUrl = null;
  var _filePath = null;

  void getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    _filePath = pickedFile.path;
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _onSubmit() async {
    final user = FirebaseAuth.instance.currentUser;
    final uid = user.uid;
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      var ref = FirebaseStorage.instance.ref().child('storage_image').child(_filePath);
      await ref.putFile(_image).whenComplete(() => null);
      _imageUrl = await ref.getDownloadURL();
      // _groceryDB.addItem(Ingredient(
      //     null, _name, _quantity, _unit, _startDate, null, 15, false));
      FirebaseFirestore.instance.collection('grocery').doc(uid).collection('groceryList').add({
        "name": _name,
        "quantity": _quantity,
        "unit": _unit,
        "startDate": _startDate,
        "nutrition": null,
        "shelfLife": 15,
        "spoilage": false,
        "imageUrl": _imageUrl
      });
      _image = null;
      _imageUrl = null;
      widget._controller1.clear();
      widget._controller2.clear();
      widget._controller3.clear();
      _formKey.currentState.save();
      
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // if (_groceryDB == null) {
    //   _groceryDB = GroceryDatabase(context);
    // }
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[

                  Container(
                    height: 200,
                    width: 200,
                    child: (_image == null)
                        ? Image(
                            image: NetworkImage(
                                "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/480px-No_image_available.svg.png"))
                        : Image.file(_image),
                  ),
                  FlatButton(
                    child: Text("Add Image"),
                    onPressed: getImage,
                  ),
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
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Enter Unit (Optional)'),
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
