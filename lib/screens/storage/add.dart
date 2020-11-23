import 'package:flutter/material.dart';
import 'package:ready_set_cook/screens/storage/barcode.dart';
import 'package:ready_set_cook/screens/storage/manual.dart';

class Add extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _tabPages = <Widget>[
      Center(child: Barcode()),
      Center(child: Manual()),
    ];
    final _tabs = <Tab>[
      const Tab(icon: Icon(Icons.camera_alt), text: 'Scan the Barcode'),
      const Tab(icon: Icon(Icons.accessibility), text: 'Enter Manually')
    ];
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Items'),
          backgroundColor: Colors.cyan,
          // If `TabController controller` is not provided, then a
          // DefaultTabController ancestor must be provided instead.
          // Another way is to use a self-defined controller, c.f. "Bottom tab
          // bar" example.
          bottom: TabBar(
            tabs: _tabs,
          ),
        ),
        body: TabBarView(
          children: _tabPages,
        ),
      ),
    );
  }
}
