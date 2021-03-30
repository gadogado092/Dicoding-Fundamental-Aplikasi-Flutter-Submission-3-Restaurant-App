// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantResult _$RestaurantResultFromJson(Map<String, dynamic> json) {
  return RestaurantResult(
    (json['restaurants'] as List)
        ?.map((e) =>
            e == null ? null : Restaurant.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['error'] as bool,
    json['message'] as String,
  );
}

Map<String, dynamic> _$RestaurantResultToJson(RestaurantResult instance) =>
    <String, dynamic>{
      'error': instance.status,
      'message': instance.message,
      'restaurants': instance.listRestaurant,
    };

DetailRestaurantResult _$DetailRestaurantResultFromJson(
    Map<String, dynamic> json) {
  return DetailRestaurantResult(
    json['restaurant'] == null
        ? null
        : Restaurant.fromJson(json['restaurant'] as Map<String, dynamic>),
    json['error'] as bool,
    json['message'] as String,
  );
}

Map<String, dynamic> _$DetailRestaurantResultToJson(
        DetailRestaurantResult instance) =>
    <String, dynamic>{
      'error': instance.status,
      'message': instance.message,
      'restaurant': instance.restaurant,
    };

Restaurant _$RestaurantFromJson(Map<String, dynamic> json) {
  return Restaurant(
    json['id'] as String,
    json['name'] as String,
    json['description'] as String,
    json['pictureId'] as String,
    json['city'] as String,
    (json['rating'] as num)?.toDouble(),
    json['address'] as String,
    (json['customerReviews'] as List)
        ?.map((e) => e == null
            ? null
            : CustomerReview.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['categories'] as List)
        ?.map((e) =>
            e == null ? null : Category.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )..menu = json['menus'] == null
      ? null
      : Menu.fromJson(json['menus'] as Map<String, dynamic>);
}

Map<String, dynamic> _$RestaurantToJson(Restaurant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'pictureId': instance.pictureId,
      'city': instance.city,
      'rating': instance.rating,
      'address': instance.address,
      'customerReviews': instance.customerReview,
      'categories': instance.category,
      'menus': instance.menu,
    };

Menu _$MenuFromJson(Map<String, dynamic> json) {
  return Menu(
    (json['foods'] as List)
        ?.map(
            (e) => e == null ? null : Food.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['drinks'] as List)
        ?.map(
            (e) => e == null ? null : Drink.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MenuToJson(Menu instance) => <String, dynamic>{
      'foods': instance.listFood,
      'drinks': instance.listDrink,
    };

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category(
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'name': instance.name,
    };

CustomerReview _$CustomerReviewFromJson(Map<String, dynamic> json) {
  return CustomerReview(
    json['name'] as String,
    json['review'] as String,
    json['date'] as String,
  );
}

Map<String, dynamic> _$CustomerReviewToJson(CustomerReview instance) =>
    <String, dynamic>{
      'name': instance.name,
      'review': instance.review,
      'date': instance.date,
    };
