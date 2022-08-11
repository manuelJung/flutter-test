import 'package:flutter/material.dart';

class FilterListRoute extends StatelessWidget {
  const FilterListRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Filtern'),
        ),
        body: const Center(child: Text('Filter List')));
  }
}
