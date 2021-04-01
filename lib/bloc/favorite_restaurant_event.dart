import 'package:equatable/equatable.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

abstract class FavoriteRestaurantEvent extends Equatable {
  const FavoriteRestaurantEvent();

  @override
  List<Object> get props => [];
}

class AddFavorite extends FavoriteRestaurantEvent {
  final Restaurant restaurant;

  AddFavorite(this.restaurant);
}

class DeleteFavorite extends FavoriteRestaurantEvent {
  final Restaurant restaurant;

  DeleteFavorite(this.restaurant);
}

class RemoveFavorite extends FavoriteRestaurantEvent {
  final Restaurant restaurant;

  RemoveFavorite(this.restaurant);
}

class FetchFavoriteStatus extends FavoriteRestaurantEvent {
  final Restaurant restaurant;

  FetchFavoriteStatus(this.restaurant);
}

class FetchFavorite extends FavoriteRestaurantEvent {}
