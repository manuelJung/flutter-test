import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'animations.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scrollPos = context.read<BottomSheetAnimation>();
    return Observer(builder: (context) {
      double size = scrollPos.interpolate(
        xs: [0, 0.4, 0.8, 1],
        ys: [1, 1, 0, 0],
      );
      return Opacity(
        opacity: size,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(100)),
          width: 50,
          height: 50,
          padding: EdgeInsets.zero,
          margin: const EdgeInsets.only(top: 20, left: 10),
          child: Center(
              child: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.arrow_back_ios_new,
              size: size * 20,
            ),
            onPressed: () => Navigator.pop(context),
          )),
        ),
      );
    });
  }
}
