import 'package:ready_set_cook/services/auth.dart';
import 'package:ready_set_cook/shared/constants.dart';
import 'package:ready_set_cook/screens/profile/edit_password.dart';
import 'package:flutter/material.dart';
import 'package:ready_set_cook/screens/profile/profile.dart';
import 'package:ready_set_cook/screens/home/home.dart';
import 'package:ready_set_cook/services/allergy_service.dart';
import 'package:ready_set_cook/models/allergies.dart';

class Add_allergy extends StatefulWidget {
  final Function toggleView;
  Add_allergy({this.toggleView});

  @override
  _Add_allergyState createState() => _Add_allergyState();
}

class _Add_allergyState extends State<Add_allergy> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  AllergyDatabase _allergyDB = null;

  String dropdownValue = 'Vegan';

  @override
  Widget build(BuildContext context) {
    if (_allergyDB == null) {
      _allergyDB = AllergyDatabase(context);
    }

    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[120],
        elevation: 0.0,
        title: Text('Dietary Preference'),
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
                    "Add your dietary preference",
                    style: new TextStyle(
                      fontSize: 30.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40.0),
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 30,
                    elevation: 16,
                    style: TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>[
                      'Vegan',
                      'Peanut Allergy',
                      'Lactose Intolerant',
                      'Seafood Allergy'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 40.0),
                  RaisedButton(
                      color: Colors.blue[400],
                      child: Text(
                        'Add',
                        style: TextStyle(color: Colors.white),
                      ),
                      //onPressed: () async {}

                      onPressed: () async {
                        _allergyDB.addAllergy(DiePref(dropdownValue));

                        //Navigator.of(context).pop();
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  title: Text('Added ' + dropdownValue + '!'),
                                  content: Text('You can add more or delete'),
                                ));
                      }),
                  SizedBox(height: 12.0),
                ],
              ),
            )),
      ),
    );
  }
}
