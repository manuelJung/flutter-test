import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_app/cms/category_listing_page.dart';
import 'package:flutter_app/cms/cms_link.dart';
import 'package:flutter_app/cms/home_page.dart';
import 'package:flutter_app/routes/home/index.dart';
import 'package:mobx/mobx.dart';

part 'cms_store.g.dart';

class CMSStore = _CMSStore with _$CMSStore;

abstract class _CMSStore with Store {
  Map<String, HomePage> dataHome = {};
  Map<String, CategoryListingPage> categoryListing = {};

  _CMSStore() {
    _load('home').then((map) {
      List<HomePage> pages = map.map(HomePage.fromJSON).toList();
      for (var page in pages) {
        dataHome[page.id] = page;
      }
    });
  }

  Future<List<dynamic>> _load(String type) async {
    var json = await rootBundle.loadString('assets/cms/$type.json');
    var map = jsonDecode(json);
    return map;
  }

  Future<HomePage> getHomePage(String id) async {
    return dataHome[id]!;
  }

  Future<HomePage> getCategoryListingPage(String id) async {
    return dataHome[id]!;
  }

  Future<void> navigate(BuildContext context, CMSLink link) async {
    if (link.type == CMSPageType.home) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeRoute()));
    }
    if (link.type == CMSPageType.categoryListing) {
      throw 'categoryListing link not implemented';
    }
  }
}
