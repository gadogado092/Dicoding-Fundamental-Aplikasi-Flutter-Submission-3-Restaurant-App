import 'package:equatable/equatable.dart';

abstract class RestaurantEvent extends Equatable {
  const RestaurantEvent();

  @override
  List<Object> get props => [];
}

class FetchRestaurant extends RestaurantEvent{}

class SearchRestaurant extends RestaurantEvent {
  final query;

  SearchRestaurant(this.query);
}