// ignore_for_file: library_private_types_in_public_api

import 'package:algolia/algolia.dart';
import 'package:flutter_app/utils/algolia.dart';
import 'package:mobx/mobx.dart';

part 'pdp.g.dart';

class PDPStore = _PDP with _$PDPStore;

abstract class _PDP with Store {
  @observable
  ObservableList<PDPHit> hits = ObservableList<PDPHit>();

  @observable
  bool isFetching = true;

  @observable
  String fetchError = '';

  Map<FilterKey, FilterStore> filters = {
    FilterKey.color: FilterStore(key: FilterKey.color),
    FilterKey.variant: FilterStore(key: FilterKey.variant),
    FilterKey.style: FilterStore(key: FilterKey.style),
    FilterKey.size: FilterStore(key: FilterKey.size),
  };

  final String sku;
  final String productNumber;

  _PDP({required this.sku, required this.productNumber}) {
    _fetch();
  }

  _fetch() async {
    Action(() {
      isFetching = true;
      fetchError = '';
    })();

    AlgoliaQuery query = algolia.instance.index('prod_lusini_de_DE_products');

    query = query.setAttributesToRetrieve(
        ['sku', 'containerID', 'images', 'title', 'flags', 'attributes']);

    query = query.facetFilter('productNumber:$productNumber');
    query = query.setDistinct(value: 0);

    try {
      AlgoliaQuerySnapshot snap = await query.getObjects();

      String imgHost =
          'https://res.cloudinary.com/lusini/w_500,h_500,q_70,c_pad,f_auto';

      Action(() {
        isFetching = false;
        hits.addAll([
          for (var hit in snap.hits.map((hit) => hit.toMap()))
            PDPHit(
              title: hit['title'],
              imgUrl: '$imgHost/${hit['images']['imageWeb'][0]['url']}',
              imgList: hit['images']['imageWeb']
                  .toList()
                  .map((l) => '$imgHost/${l['url']}'),
            )
        ]);
      })();
    } catch (e) {
      print(e);
      Action(() {
        isFetching = false;
        fetchError = e.toString();
      })();
    }
  }
}

class PDPHit {
  final String title;
  final String imgUrl;
  final List<String> imgList;
  const PDPHit(
      {required this.title, required this.imgUrl, required this.imgList});
}

enum FilterKey { variant, style, size, color }

class FilterStore = _Filter with _$FilterStore;

abstract class _Filter with Store {
  @observable
  ObservableList<String> options = ObservableList();
  @observable
  String value = '';

  final FilterKey key;
  _Filter({required this.key});
}
