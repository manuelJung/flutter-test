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

    query = query.setAttributesToRetrieve(PDPHit.algoliaAttributes);

    // query = query.setFacets(['productNumber']);
    query = query.facetFilter('containerID:$containerID');
    query = query.setDistinct(value: 0);

    try {
      AlgoliaQuerySnapshot snap = await query.getObjects();

      var _hits = [
        for (var hit in snap.hits.map((hit) => hit.toMap()))
          PDPHit.fromAlgoliaHit(hit)
      ];

      Action(() {
        isFetching = false;
        hits.addAll(_hits);
        filters[FilterKey.color]!.options.addAll(_Filter.calcOptions(
              hits,
              FilterKey.color,
              color: filters[FilterKey.color]!.value,
              variant: filters[FilterKey.variant]!.value,
              style: filters[FilterKey.style]!.value,
              size: filters[FilterKey.size]!.value,
            ));
        filters[FilterKey.variant]!.options.addAll(_Filter.calcOptions(
              hits,
              FilterKey.variant,
              color: filters[FilterKey.color]!.value,
              variant: filters[FilterKey.variant]!.value,
              style: filters[FilterKey.style]!.value,
              size: filters[FilterKey.size]!.value,
            ));
        filters[FilterKey.size]!.options.addAll(_Filter.calcOptions(
              hits,
              FilterKey.size,
              color: filters[FilterKey.color]!.value,
              variant: filters[FilterKey.variant]!.value,
              style: filters[FilterKey.style]!.value,
              size: filters[FilterKey.size]!.value,
            ));
        filters[FilterKey.style]!.options.addAll(_Filter.calcOptions(
              hits,
              FilterKey.style,
              color: filters[FilterKey.color]!.value,
              variant: filters[FilterKey.variant]!.value,
              style: filters[FilterKey.style]!.value,
              size: filters[FilterKey.size]!.value,
            ));
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
  ObservableList<FilterOption> options = ObservableList();
  @observable
  String value = '';

  final FilterKey key;
  _Filter({required this.key});

  @action
  setValue(String value) {
    assert(options.where((opt) => opt.title == value).isNotEmpty);
    this.value = value;
  }

  static List<FilterOption> calcOptions(
    List<PDPHit> hits,
    FilterKey key, {
    required String color,
    required String variant,
    required String style,
    required String size,
  }) {
    List<PDPHit> selectableHits = hits
        .where((hit) =>
            hit.match(color: color, size: size, variant: variant, style: style))
        .toList();

    Set<String> allOptions = hits.map((hit) => hit.filters[key]!).toSet();

    return allOptions
        .map((opt) {
          return FilterOption(
            title: opt,
            img: hits.firstWhere((hit) => hit.filters[key] == opt).imgList[0],
            selectable: selectableHits
                .where((hit) => hit.filters[key] == opt)
                .isNotEmpty,
          );
        })
        .where((element) => element.title != '')
        .toList();
  }
}

class FilterOption {
  final String title;
  final String? img;
  final bool selectable;

  FilterOption({required this.title, required this.selectable, this.img});
}
