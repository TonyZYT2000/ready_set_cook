import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ready_set_cook/shared/constants.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ready_set_cook/services/recipes_database.dart';
import 'package:ready_set_cook/models/recipe.dart';
import 'package:ready_set_cook/models/ingredient.dart';

class AddInstruction extends StatefulWidget {
  final Function toggleView;
  AddInstruction({this.toggleView});
  @override
  _AddInstructionState createState() => _AddInstructionState();
}

class _AddInstructionState extends State<AddInstruction> {
  final _formKey = GlobalKey<FormState>();

  String instruction = "";
  List<String> _instructions = [];

  void _addInstruction(String instruction) {
    // Only add the task if the user actually entered something
    if (instruction.length > 0) {
      setState(() => _instructions.add(instruction));
    }
  }

  Widget _buildInstructions() {
    return new ListView.builder(
      // ignore: missing_return
      itemBuilder: (context, index) {
        if (index < _instructions.length) {
          return _buildOneInstruction(_instructions[index]);
        }
      },
    );
  }

  Widget _buildOneInstruction(String instruction) {
    return new ListTile(title: new Text(instruction));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildInstructions(),
      floatingActionButton: new FloatingActionButton(
          onPressed: _pushAddInstruction,
          tooltip: 'Add task',
          child: new Icon(Icons.add)),
    );
  }

  void _pushAddInstruction() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new Scaffold(
          appBar: new AppBar(title: new Text('Add a new task')),
          body: new TextField(
            autofocus: true,
            onSubmitted: (val) {
              _addInstruction(val);
              Navigator.pop(context); // Close the add todo screen
            },
            decoration: new InputDecoration(
                hintText: 'Enter something to do...',
                contentPadding: const EdgeInsets.all(16.0)),
          ));
    }));
  }
}
