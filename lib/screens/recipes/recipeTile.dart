import 'package:flutter/material.dart';
import 'package:ready_set_cook/models/recipe.dart';

class RecipeTile extends StatelessWidget {

  final String name;

  RecipeTile( { this.name } );

  @override
  Widget build(BuildContext context) {
    if(name == "") {
      return Container();
    }

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30.0,
            backgroundColor: Colors.blue[300],
            ),
            title: Text(name),
            // subtitle: Text('Rating: ${recipe.rating}/5'),
        ),
      )
    );
  }
}