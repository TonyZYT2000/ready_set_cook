import 'package:flutter/material.dart';
import 'package:ready_set_cook/screens/storage/add.dart';
import 'package:ready_set_cook/dbp_Storage/Groceries.dart';
import 'package:ready_set_cook/shared/basicListTile.dart';
import 'package:ready_set_cook/models/pracIngredients.dart';

class Storage extends StatefulWidget {
  @override
  _StorageState createState() => _StorageState();
}

class _StorageState extends State<Storage> {
  final List<Grocery> groceries = GroceryList.getGroceries();

  Widget _buildGroceryList() {
    return Container(
      child: groceries.length > 0
          ? ListView.builder(
              itemCount: groceries.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  onDismissed: (DismissDirection direction) {
                    setState(() {
                      groceries.removeAt(index);
                    });
                  },
                  secondaryBackground: Container(
                    child: Center(
                      child: Text(
                        'Delete',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    color: Colors.red,
                  ),
                  background: Container(),
                  child: GroceryCard(grocery: groceries[index]),
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                );
              },
            )
          : Center(child: Text('No Items')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[100],
      body: _buildGroceryList(),
      // Add Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Add()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
