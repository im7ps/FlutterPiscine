import 'package:flutter/material.dart';
import 'search_bar.dart';
// import 'package:flutter/rendering.dart';


void main() {
  // debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  static const List<Tab> myTabs = <Tab>[
    Tab(text: "Currently"),
    Tab(text: "Today"),
    Tab(text: "Weekly"),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            leading: IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                  ),
                
                tooltip: 'Search city',
                onPressed: () {
                  debugPrint('Riggiu?');
                },
              ),
            title: Row(
              children: [
                Expanded(
                  child: MySearchBar(),
                ),
              ],
            ),
            actions: <Widget>[
              IconButton(
               icon: const Icon(
                  Icons.beach_access,
                  color: Colors.white,
                ),
               tooltip: 'Get current location',
               onPressed: () {
                debugPrint('Riggiu!');
               },
             ),
            ],
          ),
          body: TabBarView(
            children: myTabs.map((Tab tab) {
              final String label = tab.text!.toLowerCase();
              return Center(
                child: Text('Chistu: $label'),
              );
            }).toList(),
            ),
          bottomNavigationBar: BottomAppBar(
            child: TabBar(
              labelColor: Colors.blue,
              tabs: myTabs,
            ),
          ),
        ),
      ),
    );
  }
}