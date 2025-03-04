import 'package:flutter/material.dart';
import 'utils.dart';
import 'provider.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => SearchProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {

  static const List<Tab> myTabs = <Tab>[
    Tab(text: "Currently"),
    Tab(text: "Today"),
    Tab(text: "Weekly"),
  ];

  final TextEditingController searchController = TextEditingController();


  MyApp({super.key}) {
    searchController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: weatherAppBar(searchController, context),
          body: weatherBody(myTabs, searchController),
        ),
      ),
    );
  }
}