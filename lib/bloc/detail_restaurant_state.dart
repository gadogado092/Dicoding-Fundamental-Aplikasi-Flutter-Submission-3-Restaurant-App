import 'package:equatable/equatable.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

abstract class DetailRestaurantState extends Equatable {
  const DetailRestaurantState();

  @override
  List<Object> get props => [];
}

class RestaurantInitial extends DetailRestaurantState {}

class RestaurantLoadingProgress extends DetailRestaurantState {}

class RestaurantLoadSuccess extends DetailRestaurantState {
  final Restaurant restaurant;

  RestaurantLoadSuccess(this.restaurant);
}

class RestaurantLoadFailure extends DetailRestaurantState {
  final String message;

  RestaurantLoadFailure(this.message);
}
