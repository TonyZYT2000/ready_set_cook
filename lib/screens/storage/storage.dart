import 'package:flutter/material.dart';
import 'package:ready_set_cook/screens/storage/widget/storage_row.dart';
import 'package:ready_set_cook/screens/storage/add.dart';
import 'package:ready_set_cook/screens/storage/edit.dart';
import 'package:ready_set_cook/services/grocery.dart';
import 'package:ready_set_cook/models/ingredient.dart';

class Storage extends StatefulWidget {
  @override
  _StorageState createState() => _StorageState();
}

class _StorageState extends State<Storage> {
  GroceryDatabase _groceryDB = null;

  @override
  Widget build(BuildContext context) {
    if (_groceryDB == null) {
      _groceryDB = GroceryDatabase(context);
    }
    return Scaffold(
        backgroundColor: Colors.blue[50],
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Add()),
            );
          },
          child: Icon(Icons.add),
        ),
        body: StreamBuilder(
            stream: _groceryDB.getGrocerySnap(),
            // FirebaseFirestore.instance.collection('storage2').snapshots(),
            builder: (ctx, storageSnapshot) {
              if (storageSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              final storageSnap = storageSnapshot.data.documents;
              return ListView.builder(
                  itemCount: storageSnap.length,
                  itemBuilder: (ctx, index) {
                    final String id = storageSnap[index].id;
                    final String name = storageSnap[index]["name"];
                    final int quant = storageSnap[index]['quantity'];
                    final String unit = storageSnap[index]['unit'];
                    final String imageUrl = storageSnap[index]['imageUrl'];
                    final DateTime date = DateTime.parse(
                        storageSnap[index]['startDate'].toDate().toString());
                    final docName = storageSnap[index].documentID;
                    print("popoopopopopopo" + "       "  + docName);

                    // return a widget that can be slided
                    return Dismissible(
                      onDismissed: (DismissDirection direction) {
                        // right->left delete, left->right edit
                        if (direction == DismissDirection.endToStart) {
                          setState(() {
                            _groceryDB.deleteItem(id);
                          });
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text("$name deleted")));
                        } else {
                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Edit(docName: docName)));
                          });
                        }
                      },
                      // background for edit
                      background: Container(
                        child: Center(
                          child: Text(
                            'Edit',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        color: Colors.blue,
                      ),
                      // background for delete
                      secondaryBackground: Container(
                        child: Center(
                          child: Text(
                            'Delete',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        color: Colors.red,
                      ),
                      child: StorageRow(Ingredient(
                          id, name, quant, unit, date, null, 15, false, imageUrl)),
                      key: UniqueKey(),
                      //direction: DismissDirection.endToStart,
                    );
                  });
            }));
  }
}
