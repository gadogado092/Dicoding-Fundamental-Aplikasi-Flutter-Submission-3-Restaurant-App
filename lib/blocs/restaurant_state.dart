import 'package:equatable/equatable.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

abstract class RestaurantState extends Equatable {
  const RestaurantState();

  @override
  List<Object> get props => [];
}

class RestaurantInitial extends RestaurantState{}

class RestaurantLoadingProgress extends RestaurantState{}

class RestaurantLoadSuccess extends RestaurantState{
  final List<Restaurant> listRestaurant;

  RestaurantLoadSuccess(this.listRestaurant);
}

class RestaurantLoadFailure extends RestaurantState{}

class RestaurantEmptyData extends RestaurantState{}