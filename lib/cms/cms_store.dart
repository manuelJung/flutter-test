import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_app/cms/category_listing_page.dart';
import 'package:flutter_app/cms/cms_link.dart';
import 'package:flutter_app/cms/home_page.dart';
import 'package:flutter_app/routes/home/index.dart';
import 'package:flutter_app/routes/listing/index.dart';
import 'package:flutter_app/stores/product_list/product_list.dart';
import 'package:mobx/mobx.dart';

part 'cms_store.g.dart';

class CMSStore = _CMSStore with _$CMSStore;

abstract class _CMSStore with Store {
  @observable
  ObservableMap<String, HomePage> dataHome = ObservableMap();
  @observable
  ObservableMap<String, CategoryListingPage> categoryListing = ObservableMap();

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

  HomePage getHomePage(String id) {
    return dataHome[id]!;
  }

  CategoryListingPage getCategoryListingPage(String id) {
    return categoryListing[id]!;
  }

  Future<void> navigate(BuildContext context, CMSLink link) async {
    if (link.type == CMSPageType.home) {
      var cms = getHomePage(link.id);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomeRoute(cms: cms)));
    }
    if (link.type == CMSPageType.categoryListing) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const ListingRoute(initialFilters: InitialFilters())));
    }
  }
}
