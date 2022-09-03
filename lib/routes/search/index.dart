import 'package:flutter/material.dart';

class SearchRoute extends StatelessWidget {
  const SearchRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Search')),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Hero(
          tag: 'home-search',
          child: Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 10,
                bottom: 10,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  color: Colors.grey[300],
                ),
                height: 45,
                child: Row(children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Icon(
                          Icons.chevron_left,
                          color: Colors.grey[700],
                        )),
                  ),
                  Flexible(
                    child: TextField(
                      autofocus: true,
                      decoration: InputDecoration.collapsed(
                          hintText: 'Suche...',
                          hintStyle:
                              TextStyle(color: Colors.grey[700], fontSize: 14)),
                    ),
                  )
                ]),
              )),
        ),
      ),
    );
  }
}
