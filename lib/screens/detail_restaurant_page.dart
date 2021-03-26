import 'package:flutter/material.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/res/colors.dart';
import 'package:restaurant_app/widgets/base_text.dart';

class DetailRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const DetailRestaurant({Key key, @required this.restaurant})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BaseText(
          text: restaurant.name,
          typographicScale: TypographicScale.Title,
          textColor: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200.0,
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(restaurant.pictureId)),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: RestaurantColors.GREY_COLOR_3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star,
                        size: 24,
                        color: RestaurantColors.WARNING_COLOR,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      BaseText(
                        text: restaurant.rating.toString(),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_city,
                        size: 24,
                        color: RestaurantColors.ACCENT_COLOR,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      BaseText(
                        text: restaurant.city,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BaseText(
                text: restaurant.description,
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
              child: BaseText(
                text: "Makanan",
                typographicScale: TypographicScale.Title,
                textSize: 16,
              ),
            ),
            Container(
              height: 50,
              child: ListView.builder(
                  itemCount: restaurant.menu.listFood.length,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                  itemBuilder: (
                    context,
                    index,
                  ) {
                    return Container(
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        color: RestaurantColors.GREY_COLOR_2,
                      ),
                      child: Center(
                        child: BaseText(
                          textColor: Colors.black54,
                          text: restaurant.menu.listFood[index].name,
                        ),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
              child: BaseText(
                text: "Minuman",
                typographicScale: TypographicScale.Title,
                textSize: 16,
              ),
            ),
            Container(
              height: 50,
              child: ListView.builder(
                  itemCount: restaurant.menu.listDrink.length,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                  itemBuilder: (
                    context,
                    index,
                  ) {
                    return Container(
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        color: RestaurantColors.GREY_COLOR_2,
                      ),
                      child: Center(
                        child: BaseText(
                          textColor: Colors.black54,
                          text: restaurant.menu.listDrink[index].name,
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
