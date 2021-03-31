import 'package:flutter/material.dart';
import 'package:restaurant_app/blocs/restaurant_state.dart';
import 'package:restaurant_app/blocs/restaurant_event.dart';
import 'package:restaurant_app/blocs/search_restaurant_bloc.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/res/colors.dart';
import 'package:restaurant_app/routes/route_paths.dart';
import 'package:restaurant_app/widgets/empty.dart';
import 'package:restaurant_app/widgets/error.dart';
import 'package:restaurant_app/widgets/item_restaurant.dart';
import 'package:restaurant_app/widgets/loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchRestaurantPage extends StatefulWidget {
  @override
  _SearchRestaurantPageState createState() => _SearchRestaurantPageState();
}

class _SearchRestaurantPageState extends State<SearchRestaurantPage> {
  final _searchController = TextEditingController();
  SearchRestaurantBloc _searchRestaurantBloc;

  @override
  void initState() {
    _searchRestaurantBloc = BlocProvider.of(this.context);
    _searchRestaurantBloc.add(SearchRestaurant(""));
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
                        padding: const EdgeInsets.all(8),
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
                                    _searchRestaurantBloc
                                        .add(SearchRestaurant(value));
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
              child: BlocBuilder<SearchRestaurantBloc, RestaurantState>(
                builder: (context, state) {
                  if (state is RestaurantLoadSuccess) {
                    return ListView.builder(
                        itemCount: state.listRestaurant.length,
                        itemBuilder: (context, position) {
                          Restaurant restaurant =
                              state.listRestaurant[position];
                          return ItemRestaurant(
                            restaurant: restaurant,
                            onTap: () {
                              Navigator.pushNamed(
                                  context, detailRestaurantPageRoute,
                                  arguments: restaurant);
                            },
                          );
                        });
                  } else if (state is RestaurantLoadingProgress) {
                    return LoadingWidget();
                  } else if (state is RestaurantLoadFailure) {
                    return Error(
                      onTap: () => _searchRestaurantBloc.add(
                          SearchRestaurant(_searchController.text.toString())),
                    );
                  } else if (state is RestaurantEmptyData) {
                    return EmptyWidget(msg: "Data Not Found",);
                  }
                  return Container();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
