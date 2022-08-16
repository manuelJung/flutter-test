import 'package:flutter/material.dart';
import 'package:flutter_app/routes/home/category_grid.dart';
import 'package:flutter_app/routes/home/home_app_bar.dart';
import 'package:flutter_app/routes/home/image_grid.dart';
import 'package:flutter_app/stores/animated_value/animated_value.dart';
import 'package:provider/provider.dart';

class HomeRoute extends StatelessWidget {
  const HomeRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Provider(
        create: (_) => AnimatedValue(0),
        child: Builder(builder: (context) {
          final scrollPos = context.read<AnimatedValue>();
          return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              var pixels = notification.metrics.pixels;
              if (pixels < 0) pixels = 0;
              scrollPos.setValue(pixels);
              return true;
            },
            child: CustomScrollView(
              slivers: [
                const HomeAppBar(),
                _title(context, 'Kategorien'),
                const CategoryGrid(),
                _title(context, 'Marken'),
                ImageGrid(columns: 2, ratio: 1, items: [
                  ImageGridItem(
                    imgUrl:
                        'https://res.cloudinary.com/lusini/image/upload/f_auto/q_auto/v1615384580/demo-content/Vega_Logo_Logo_Wortmarke_neg_500x500px_rgb.png',
                  ),
                  ImageGridItem(
                    imgUrl:
                        'https://res.cloudinary.com/lusini/image/upload/f_auto/q_auto/v1615384592/demo-content/ErwinM_Logo_WortBildmarke_neg_500x500px_rgb.png',
                  ),
                  ImageGridItem(
                    imgUrl:
                        'https://res.cloudinary.com/lusini/image/upload/f_auto/q_auto/v1615384598/demo-content/Jobeline_Logo_WortBildmarke_neg_500x500px_rgb.png',
                  ),
                  ImageGridItem(
                    imgUrl:
                        'https://res.cloudinary.com/lusini/image/upload/f_auto/q_auto/v1631189692/demo-content/pulsiva_Logo_WortBildmarke_CoolgrayC5_RGB.jpg',
                  ),
                ]),
                _title(context, 'Beliebte Kategorien'),
                ImageGrid(columns: 2, ratio: 2, items: [
                  ImageGridItem(
                    label: 'Outdoor',
                    imgUrl:
                        'https://res.cloudinary.com/lusini/image/upload/w_450,f_auto,dpr_2,q_80/v1658223175/cms/static-block/lusini-banner-hero-cocktails-content-desktop.jpg',
                  ),
                  ImageGridItem(
                    label: 'Gastronomie',
                    imgUrl:
                        'https://res.cloudinary.com/lusini/image/fetch/w_450,f_auto,dpr_2/https%3A%2F%2Fres.cloudinary.com%2Flusini%2Fimage%2Fupload%2Fc_crop%2Cg_south_west%2Ch_1075%2Cw_1300%2Cx_475%2Fv1657526004%2Fcms%2Fmam%2F7021_93798_VFA_M_0001.jpg',
                  ),
                  ImageGridItem(
                    label: 'Buffet',
                    imgUrl:
                        'https://res.cloudinary.com/lusini/image/upload/w_450,f_auto,dpr_2,q_80/v1635151019/cms/mam/VE6825M011.jpg',
                  ),
                  ImageGridItem(
                    label: 'Geschirr',
                    imgUrl:
                        'https://res.cloudinary.com/lusini/image/upload/w_331,f_auto,dpr_2,q_80/v1630044683/cms/category/VE6595M003-600.jpg',
                  ),
                  ImageGridItem(
                    label: 'Exotisch',
                    imgUrl:
                        'https://res.cloudinary.com/lusini/image/upload/w_450,f_auto,dpr_2,q_80/v1658223179/cms/static-block/lusini-banner-hero-cocktails-geschirr-mit-preis-desktop.jpg',
                  ),
                  ImageGridItem(
                    label: 'Hotelbedarf',
                    imgUrl:
                        'https://res.cloudinary.com/lusini/image/upload/w_450,f_auto,dpr_2,q_80/v1658311387/cms/category/HW9312M002-600.jpg',
                  ),
                ]),
                _title(context, 'Empfehlungen'),
                ImageGrid(columns: 1, ratio: 2, items: [
                  ImageGridItem(
                    label: 'Outdoor',
                    imgUrl:
                        'https://res.cloudinary.com/lusini/image/upload/w_450,f_auto,dpr_2,q_80/v1658223175/cms/static-block/lusini-banner-hero-cocktails-content-desktop.jpg',
                  ),
                  ImageGridItem(
                    label: 'Gastronomie',
                    imgUrl:
                        'https://res.cloudinary.com/lusini/image/fetch/w_450,f_auto,dpr_2/https%3A%2F%2Fres.cloudinary.com%2Flusini%2Fimage%2Fupload%2Fc_crop%2Cg_south_west%2Ch_1075%2Cw_1300%2Cx_475%2Fv1657526004%2Fcms%2Fmam%2F7021_93798_VFA_M_0001.jpg',
                  ),
                  ImageGridItem(
                    label: 'Buffet',
                    imgUrl:
                        'https://res.cloudinary.com/lusini/image/upload/w_450,f_auto,dpr_2,q_80/v1635151019/cms/mam/VE6825M011.jpg',
                  ),
                  ImageGridItem(
                    label: 'Geschirr',
                    imgUrl:
                        'https://res.cloudinary.com/lusini/image/upload/w_331,f_auto,dpr_2,q_80/v1630044683/cms/category/VE6595M003-600.jpg',
                  ),
                  ImageGridItem(
                    label: 'Exotisch',
                    imgUrl:
                        'https://res.cloudinary.com/lusini/image/upload/w_450,f_auto,dpr_2,q_80/v1658223179/cms/static-block/lusini-banner-hero-cocktails-geschirr-mit-preis-desktop.jpg',
                  ),
                  ImageGridItem(
                    label: 'Hotelbedarf',
                    imgUrl:
                        'https://res.cloudinary.com/lusini/image/upload/w_450,f_auto,dpr_2,q_80/v1658311387/cms/category/HW9312M002-600.jpg',
                  ),
                ]),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _title(BuildContext context, String title) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 30,
          left: 10,
          right: 10,
          bottom: 10,
        ),
        child: Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
