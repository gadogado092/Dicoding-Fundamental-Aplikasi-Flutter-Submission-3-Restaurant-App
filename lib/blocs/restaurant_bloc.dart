import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/blocs/restaurant_event.dart';
import 'package:restaurant_app/blocs/restaurant_state.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  ApiService apiService = ApiService();

  RestaurantBloc() : super(RestaurantInitial());

  @override
  Stream<RestaurantState> mapEventToState(RestaurantEvent event) async* {
    if (event is FetchRestaurant) {
      yield RestaurantLoadingProgress();
      try {
        RestaurantResult restaurantResult =
            await apiService.getListRestaurant();
        if (!restaurantResult.status) {
          if (restaurantResult.listRestaurant.length == 0) {
            yield RestaurantEmptyData();
          } else {
            yield RestaurantLoadSuccess(restaurantResult.listRestaurant);
          }
        } else {
          yield RestaurantLoadFailure();
        }
      } catch (e) {
        debugPrint("===" + e.toString());
        yield RestaurantLoadFailure();
      }
    }
  }
}
