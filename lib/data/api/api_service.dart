import 'dart:convert';
import 'package:resstaurant_api/data/model/restaurant.dart';
import 'package:http/http.dart' show Client;

class ApiService {
  static const baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const list = baseUrl + 'list';
  static const detail = baseUrl + 'detail/';
  static const search = baseUrl + 'search?q=';
  static const smallImage = baseUrl + 'images/small/';
  static const mediumImage = baseUrl + 'images/medium/';
  static const largeImage = baseUrl + 'images/large/';

  Client client;
  ApiService({this.client}) {
    client ??= Client();
  }

  Future<RestaurantResult> getRestaurants() async {
    final response = await client.get(Uri.parse(list));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurants');
    }
  }
}
