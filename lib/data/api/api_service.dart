import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/restaurant.dart';

class ApiService {
  static final String _baseUrl = "https://restaurant-api.dicoding.dev/";
  static final String baseUrlImage = "${_baseUrl}images/";

  Future<RestaurantResult> getListRestaurant() async {
    final response = await http.get(_baseUrl + "list");
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed Load List Restaurant');
    }
  }

  Future<DetailRestaurantResult> getDetailRestaurant(String id) async {
    final response = await http.get(_baseUrl + "/detail/$id");
    if (response.statusCode == 200) {
      return DetailRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed Load Restaurant');
    }
  }

  Future<RestaurantResult> searchRestaurant(String query) async {
    final response = await http.get(_baseUrl + "/search?q=$query");
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed Load Restaurant');
    }
  }
}
