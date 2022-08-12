import 'package:algolia/algolia.dart';

const Algolia algolia = Algolia.init(
  applicationId: 'WAVYBEW6OQ',
  apiKey: 'bf4bf9193d5f34cd369647376521dbc8',
);

// class Application {
//   static const Algolia algolia = Algolia.init(
//     applicationId: 'WAVYBEW6OQ',
//     apiKey: 'bf4bf9193d5f34cd369647376521dbc8',
//   );
// }

// void main() async {
//   AlgoliaQuery query =
//       Application.algolia.instance.index('prod_lusini_de_DE_products');

//   query = query.setAttributesToRetrieve([
//     'sku',
//     'containerID',
//     'images',
//     'title',
//   ]);

//   query = query.query('Hose');

//   AlgoliaQuerySnapshot snap = await query.getObjects();

//   for (var hit in snap.hits) {
//     print(hit);
//   }
// }
