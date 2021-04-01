import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/bloc/detail_restaurant_event.dart';
import 'package:restaurant_app/bloc/detail_restaurant_state.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

class DetailRestaurantBloc
    extends Bloc<DetailRestaurantEvent, DetailRestaurantState> {
  ApiService apiService = ApiService();

  DetailRestaurantBloc() : super(RestaurantInitial());

  @override
  Stream<DetailRestaurantState> mapEventToState(
      DetailRestaurantEvent event) async* {
    if (event is FetchDetailRestaurant) {
      yield RestaurantLoadingProgress();
      try {
        DetailRestaurantResult detailRestaurantResult =
            await apiService.getDetailRestaurant(event.idRestaurant);
        if (!detailRestaurantResult.status) {
          yield RestaurantLoadSuccess(detailRestaurantResult.restaurant);
        } else {
          yield RestaurantLoadFailure(detailRestaurantResult.message);
        }
      } catch (e) {
        debugPrint("===" + e.toString());
        yield RestaurantLoadFailure("Failed Load Data");
      }
    }
  }
}
