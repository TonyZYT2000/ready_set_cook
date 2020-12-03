import 'package:flutter/material.dart';

class ViewRecipeInstructTile extends StatelessWidget {
  final String instruction;
  ViewRecipeInstructTile(this.instruction);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10.0),
        child: Container(
            child: InputDecorator(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue[100], width: 100),
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          child: Text(instruction),
        )));
  }
}
