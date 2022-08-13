// ignore_for_file: library_private_types_in_public_api

import 'package:algolia/algolia.dart';
import 'package:flutter_app/stores/pdp/pdp_hit.dart';
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
  final String containerID;

  _PDP({required this.sku, required this.containerID}) {
    _fetch();
  }

  @computed
  PDPHit get displayVariant {
    assert(hits.isNotEmpty,
        'you cannot access displayVariant before fetch finished');

    return hits.firstWhere(
        (hit) => hit.match(
              color: filters[FilterKey.color]!.value,
              size: filters[FilterKey.size]!.value,
              variant: filters[FilterKey.variant]!.value,
              style: filters[FilterKey.style]!.value,
            ),
        orElse: () => PDPHit.empty());
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
      'title',
      'flags',
      'attributes',
      'variantData'
    ]);

    // query = query.setFacets(['productNumber']);
    query = query.facetFilter('containerID:$containerID');
    query = query.setDistinct(value: 0);

    try {
      AlgoliaQuerySnapshot snap = await query.getObjects();

      Action(() {
        isFetching = false;
        hits.addAll([
          for (var hit in snap.hits.map((hit) => hit.toMap()))
            PDPHit.fromAlgoliaHit(hit)
        ]);
      })();
    } catch (e, stack) {
      print(e);
      print(stack);
      Action(() {
        isFetching = false;
        fetchError = e.toString();
      })();
    }
  }
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

  @action
  setValue(String value) {
    assert(options.contains(value));
    this.value = value;
  }
}
