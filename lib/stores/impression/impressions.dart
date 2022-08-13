import 'package:algolia/algolia.dart';
import 'package:flutter_app/stores/impression/impression_item.dart';
import 'package:mobx/mobx.dart';

import '../../utils/algolia.dart';

part 'impressions.g.dart';

// ignore: library_private_types_in_public_api
class ImpressionsStore = _ImpressionsStore with _$ImpressionsStore;

abstract class _ImpressionsStore with Store {
  @observable
  ObservableList<ImpressionItem> items = ObservableList();

  @observable
  int page = 0;

  @observable
  bool isFetching = false;

  @observable
  String fetchError = '';

  _ImpressionsStore() {
    _fetch();
  }

  @action
  void extend() {
    page = page + 1;
    _fetch();
  }

  _fetch() async {
    Action(() {
      isFetching = true;
      fetchError = '';
    })();

    AlgoliaQuery query = algolia.instance.index('prod_lusini_de_DE_products');

    query = query.setAttributesToRetrieve([
      'sku',
      'containerID',
      'images',
    ]);

    query = query.setPage(page);
    query = query.setHitsPerPage(100);

    try {
      AlgoliaQuerySnapshot snap = await query.getObjects();

      Action(() {
        isFetching = false;
        items.addAll([
          for (var hit in snap.hits.map((hit) => hit.toMap()))
            if (ImpressionItem.hasMilieu(hit))
              ImpressionItem.fromAlgoliaHit(hit)
        ]);
      })();
    } catch (e, stack) {
      print(e);
      print(stack);
      isFetching = false;
      fetchError = e.toString();
    }
  }
}
