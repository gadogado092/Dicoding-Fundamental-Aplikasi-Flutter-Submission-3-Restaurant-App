import 'package:equatable/equatable.dart';

abstract class DetailRestaurantEvent extends Equatable {
  const DetailRestaurantEvent();

  @override
  List<Object> get props => [];
}

class FetchDetailRestaurant extends DetailRestaurantEvent{
  final String idRestaurant;

  FetchDetailRestaurant(this.idRestaurant);
}
