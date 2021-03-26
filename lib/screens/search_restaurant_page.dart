import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/res/colors.dart';
import 'package:restaurant_app/routes/route_paths.dart';
import 'package:restaurant_app/widgets/base_text.dart';
import 'package:restaurant_app/widgets/item_restaurant.dart';
import 'package:restaurant_app/widgets/loading.dart';

class SearchRestaurant extends StatefulWidget {
  @override
  _SearchRestaurantState createState() => _SearchRestaurantState();
}

class _SearchRestaurantState extends State<SearchRestaurant> {
  final _searchController = TextEditingController();
  List<Restaurant> _listSearchRestaurant = [];
  List<Restaurant> _listRestaurant = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              margin: EdgeInsets.zero,
              color: RestaurantColors.PRIMARY_COLOR,
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Padding(
                        padding:
                            const EdgeInsets.all(8),
                        child: Icon(
                          Icons.arrow_back,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                                color: RestaurantColors.GREY_COLOR_3,
                                borderRadius: BorderRadius.circular(4)),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  color: RestaurantColors.TEXT_PRIMARY_COLOR,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                    child: TextFormField(
                                  controller: _searchController,
                                  cursorColor: Colors.black,
                                  onChanged: (value) {
                                    setState(() {
                                      _listSearchRestaurant = _listRestaurant
                                          .where((element) => element.name
                                              .toLowerCase()
                                              .contains(value
                                                  .toString()
                                                  .toLowerCase()))
                                          .toList();
                                    });
                                  },
                                  decoration: new InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.zero,
                                      hintText: "Search Restaurant"),
                                )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<String>(
                future: DefaultAssetBundle.of(context)
                    .loadString('assets/local_restaurant.json'),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data =
                        Restaurants.fromJson(jsonDecode(snapshot.data));
                    _listRestaurant = data.listRestaurant;
                    if (_listSearchRestaurant.length != 0 &&
                        _searchController.text.isNotEmpty) {
                      return ListView.builder(
                          itemCount: _listSearchRestaurant.length,
                          itemBuilder: (context, position) {
                            Restaurant restaurant =
                                _listSearchRestaurant[position];
                            return ItemRestaurant(
                              restaurant: restaurant,
                              onTap: () {
                                Navigator.pushNamed(
                                    context, detailRestaurantPageRoute,
                                    arguments: restaurant);
                              },
                            );
                          });
                    } else if (_listSearchRestaurant.length == 0 &&
                        _searchController.text.isNotEmpty) {
                      return Center(
                          child: BaseText(text: "Restaurant Not Found"));
                    } else {
                      return ListView.builder(
                          itemCount: _listRestaurant.length,
                          itemBuilder: (context, position) {
                            Restaurant restaurant = _listRestaurant[position];
                            return ItemRestaurant(
                              restaurant: restaurant,
                              onTap: () {
                                Navigator.pushNamed(
                                    context, detailRestaurantPageRoute,
                                    arguments: restaurant);
                              },
                            );
                          });
                    }
                  } else if (snapshot.hasError) {
                    return Center(child: BaseText(text: "Error Load Data"));
                  }

                  return Loading();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
