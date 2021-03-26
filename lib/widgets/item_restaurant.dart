import 'package:flutter/material.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/res/colors.dart';
import 'package:restaurant_app/widgets/base_text.dart';

class ItemRestaurant extends StatelessWidget {
  const ItemRestaurant({Key key, @required this.restaurant, this.onTap})
      : super(key: key);

  final Restaurant restaurant;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 130.0,
              height: 100.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(restaurant.pictureId)),
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                color: RestaurantColors.GREY_COLOR_3,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BaseText(
                      text: restaurant.name,
                      typographicScale: TypographicScale.Title,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.location_city,
                          size: 18,
                          color: RestaurantColors.ACCENT_COLOR,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        BaseText(
                          text: restaurant.city,
                          typographicScale: TypographicScale.Caption,
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.star,
                          size: 18,
                          color: RestaurantColors.WARNING_COLOR,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        BaseText(
                          text: restaurant.rating.toString(),
                          typographicScale: TypographicScale.Caption,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
