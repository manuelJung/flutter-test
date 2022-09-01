import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_app/cms/cms_store.dart';
import 'navigation/app.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent, // navigation bar color
    statusBarColor: Colors.transparent, // status bar color
  ));
  runApp(const MyApp());
  // var store = CMSStore();
  // await Future.delayed(Duration(milliseconds: 300));
  // print(store.dataHome);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const App(),
    );
  }
}
