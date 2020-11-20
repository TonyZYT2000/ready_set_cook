import 'package:ready_set_cook/screens/storage/widget/storage_row.dart';
import 'package:flutter/material.dart';
import 'package:ready_set_cook/screens/storage/add.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Storage extends StatefulWidget {
  @override
  _StorageState createState() => _StorageState();
}

class _StorageState extends State<Storage> {
  @override
  Widget build(BuildContext context) {
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
            stream:
                FirebaseFirestore.instance.collection('storage2').snapshots(),
            builder: (ctx, storageSnapshot) {
              if (storageSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              final storageSnap = storageSnapshot.data.documents;
              return ListView.builder(
                  itemCount: storageSnap.length,
                  itemBuilder: (ctx, index) {
                    final ingredientName = storageSnap[index]["ingredientName"];
                    final quant = storageSnap[index]['quantity'];
                    final date = storageSnap[index]['dateAdded'];
                    final unit = storageSnap[index]['unit'];
                    return StorageRow(ingredientName, quant, date, unit);
                  });
            }));
  }
}
