import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/res/colors.dart';
import 'package:restaurant_app/routes/route_paths.dart';
import 'package:restaurant_app/widgets/base_text.dart';
import 'package:restaurant_app/widgets/item_restaurant.dart';
import 'package:restaurant_app/widgets/loading.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              height: 150,
              child: Stack(
                children: [
                  Container(
                    height: 120,
                    padding: EdgeInsets.all(24),
                    color: RestaurantColors.PRIMARY_COLOR,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        BaseText(
                          text: 'Juragan Restaurant',
                          typographicScale: TypographicScale.H1,
                          textColor: Colors.white,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        BaseText(
                            text: 'Where do you want to Eat?',
                            textColor: Colors.white)
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, searchRestaurantPageRoute);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  BaseText(
                                    text: 'Find Restaurant',
                                    textColor: RestaurantColors.GREY_COLOR_1,
                                  ),
                                  Icon(
                                    Icons.search,
                                    color: RestaurantColors.PRIMARY_COLOR,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )),
          Expanded(
            child: FutureBuilder<String>(
              future: DefaultAssetBundle.of(context)
                  .loadString('assets/local_restaurant.json'),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final restaurants =
                      Restaurants.fromJson(jsonDecode(snapshot.data));
                  return ListView.builder(
                      itemCount: restaurants.listRestaurant.length,
                      itemBuilder: (context, position) {
                        Restaurant restaurant =
                            restaurants.listRestaurant[position];
                        return ItemRestaurant(
                          restaurant: restaurant,
                          onTap: () {
                            Navigator.pushNamed(
                                context, detailRestaurantPageRoute,
                                arguments: restaurant);
                          },
                        );
                      });
                } else if (snapshot.hasError) {
                  return Center(child: BaseText(text: "Error Load Data"));
                }

                return Loading();
              },
            ),
          )
        ],
      )),
    );
  }
}
