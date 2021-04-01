import 'package:flutter/material.dart';
import 'package:restaurant_app/bloc/favorite_restaurant_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/bloc/favorite_restaurant_state.dart';
import 'package:restaurant_app/bloc/favorite_restaurant_event.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/routes/route_paths.dart';
import 'package:restaurant_app/widgets/base_text.dart';
import 'package:restaurant_app/widgets/item_restaurant.dart';
import 'package:restaurant_app/widgets/loading.dart';

class FavoriteRestaurantPage extends StatefulWidget {
  @override
  _FavoriteRestaurantPageState createState() => _FavoriteRestaurantPageState();
}

class _FavoriteRestaurantPageState extends State<FavoriteRestaurantPage> {
  FavoriteRestaurantBloc _favoriteRestaurantBloc;

  @override
  void initState() {
    _favoriteRestaurantBloc = BlocProvider.of(this.context);
    _favoriteRestaurantBloc.add(FetchFavorite());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BaseText(
          text: "Favorite Restaurant",
          typographicScale: TypographicScale.Title,
          textColor: Colors.white,
        ),
      ),
      body: BlocBuilder<FavoriteRestaurantBloc, FavoriteRestaurantState>(
        builder: (context, state) {
          if (state is LoadListFavorite) {
            if (state.listRestaurant.length == 0) {
              return Center(
                child: BaseText(
                  text: "Add Favorite Restaurant",
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: state.listRestaurant.length,
                  itemBuilder: (context, position) {
                    Restaurant restaurant = state.listRestaurant[position];
                    return ItemRestaurant(
                      restaurant: restaurant,
                      onTap: () {
                        Navigator.pushNamed(context, detailRestaurantPageRoute,
                                arguments: restaurant)
                            .then((value) =>
                                _favoriteRestaurantBloc.add(FetchFavorite()));
                      },
                    );
                  });
            }
          }
          return LoadingWidget();
        },
      ),
    );
  }
}
