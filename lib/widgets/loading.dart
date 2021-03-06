import 'package:flutter/material.dart';
import 'package:restaurant_app/res/colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(
      backgroundColor: RestaurantColors.GREY_COLOR_1,
      valueColor:
          new AlwaysStoppedAnimation<Color>(RestaurantColors.PRIMARY_COLOR),
    ));
  }
}
