import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/cms/cms_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'navigation/app.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent, // navigation bar color
    statusBarColor: Colors.transparent, // status bar color
  ));
  runApp(const MyApp());
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
      home: SafeArea(
        top: false,
        // bottom: false,
        // maintainBottomViewPadding: false,
        child: Provider(
            create: (_) => CMSStore(),
            child: Observer(builder: (context) {
              var store = context.read<CMSStore>();

              if (store.dataHome.containsKey('home')) {
                return const App();
              }

              return const Center(child: Text('loading...'));
            })),
      ),
    );
  }
}
