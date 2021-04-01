import 'package:equatable/equatable.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

abstract class FavoriteRestaurantState extends Equatable {
  const FavoriteRestaurantState();

  @override
  List<Object> get props => [];
}

class Initial extends FavoriteRestaurantState {}

class Loading extends FavoriteRestaurantState {}

class LoadData extends FavoriteRestaurantState {
  final bool isFavorite;

  LoadData(this.isFavorite);
}

class LoadListFavorite extends FavoriteRestaurantState {
  final List<Restaurant> listRestaurant;

  LoadListFavorite(this.listRestaurant);
}