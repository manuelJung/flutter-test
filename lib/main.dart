import 'package:flutter/material.dart';
import 'package:flutter_app/navigation/app.dart';
import 'package:flutter_app/routes/home.dart';
import 'package:flutter_app/routes/product_list.dart';
import 'package:flutter_app/stores/navigation.dart';
import 'package:flutter_app/stores/product_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const Program());
}

class Program extends StatelessWidget {
  const Program({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => ProductListCubit(ProductListState.initial())),
        BlocProvider(
            create: (_) => NavigationCubit(stacks: [
                  const NavigationStack(widgets: [HomeRoute()]),
                  const NavigationStack(widgets: [ProductListRoute()])
                ])),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: App()
        home: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) => state.widget,
        ),
      ),
    );
  }
}
