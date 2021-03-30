import 'package:json_annotation/json_annotation.dart';
import 'package:restaurant_app/data/model/drink.dart';
import 'package:restaurant_app/data/model/food.dart';

part 'restaurant.g.dart';

@JsonSerializable()
class RestaurantResult {
  @JsonKey(name: 'error')
  final bool status;
  final String message;
  @JsonKey(name: 'restaurants')
  final List<Restaurant> listRestaurant;

  RestaurantResult(this.listRestaurant, this.status, this.message);
  factory RestaurantResult.fromJson(Map<String, dynamic> json) =>
      _$RestaurantResultFromJson(json);
}

@JsonSerializable()
class DetailRestaurantResult {
  @JsonKey(name: 'error')
  final bool status;
  final String message;
  @JsonKey(name: 'restaurant')
  final Restaurant restaurant;

  DetailRestaurantResult(this.restaurant, this.status, this.message);
  factory DetailRestaurantResult.fromJson(Map<String, dynamic> json) =>
      _$DetailRestaurantResultFromJson(json);
}

@JsonSerializable()
class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final String address;
  @JsonKey(name: "customerReviews")
  final List<CustomerReview> customerReview;
  @JsonKey(name: "categories")
  final List<Category> category;
  @JsonKey(name: 'menus')
  Menu menu;

  Restaurant(this.id, this.name, this.description, this.pictureId, this.city,
      this.rating, this.address, this.customerReview, this.category);

  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      _$RestaurantFromJson(json);
}

@JsonSerializable()
class Menu {
  @JsonKey(name: 'foods')
  final List<Food> listFood;

  @JsonKey(name: 'drinks')
  final List<Drink> listDrink;

  Menu(this.listFood, this.listDrink);

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);
}

@JsonSerializable()
class Category {
  Category({
    this.name,
  });

  String name;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}

@JsonSerializable()
class CustomerReview {
  CustomerReview(
    this.name,
    this.review,
    this.date,
  );

  final String name;
  final String review;
  final String date;

  factory CustomerReview.fromJson(Map<String, dynamic> json) =>
      _$CustomerReviewFromJson(json);
}
