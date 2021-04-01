import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/bloc/favorite_restaurant_event.dart';
import 'package:restaurant_app/bloc/favorite_restaurant_state.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/utils/database_helper.dart';

class FavoriteRestaurantBloc
    extends Bloc<FavoriteRestaurantEvent, FavoriteRestaurantState> {
  FavoriteRestaurantBloc() : super(Initial());

  DatabaseHelper dbHelper = DatabaseHelper();

  @override
  Stream<FavoriteRestaurantState> mapEventToState(
      FavoriteRestaurantEvent event) async* {
    if (event is AddFavorite) {
      yield Loading();
      yield LoadData(true);
      try {
        await dbHelper.insertFavoriteRestaurant(event.restaurant);
      } catch (e) {
        debugPrint("===" + e.toString());
        yield LoadData(false);
      }
    } else if (event is DeleteFavorite) {
      yield Loading();
      yield LoadData(false);
      try {
        await dbHelper.deleteFavoriteRestaurant(event.restaurant);
      } catch (e) {
        debugPrint("===" + e.toString());
        yield LoadData(true);
      }
    } else if (event is FetchFavorite) {
      yield Loading();
      try {
        List<Restaurant> data = await dbHelper.getFavoriteRestaurant();
        yield LoadListFavorite(data);
      } catch (e) {
        debugPrint("===" + e.toString());
        yield LoadListFavorite([]);
      }
    } else if (event is FetchFavoriteStatus) {
      yield Loading();
      try {
        yield LoadData(await dbHelper.checkFavoriteStatus(event.restaurant.id));
      } catch (e) {
        debugPrint("===" + e.toString());
        yield LoadData(false);
      }
    }
  }
}
