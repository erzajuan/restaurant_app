import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:resstaurant_api/data/api/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:resstaurant_api/data/api/connection.service.dart';
import 'dart:convert';

import 'package:resstaurant_api/data/model/restaurant.dart';

enum ResultState { Loading, NoData, HasData, Error, NoConnection }

class RestaurantProvider extends ChangeNotifier {
  final BuildContext context;
  final apiService = ApiService();
  final connectionService = ConnectionService();

  String _message = '';
  String _query = '';
  ResultState _state;
  RestaurantResult _restaurantResult;

  String get message => _message;
  String get query => _query;
  ResultState get state => _state;
  RestaurantResult get result => _restaurantResult;

  RestaurantProvider(this.context) {
    _fetchRestaurantData();
  }
  void refresh() {
    _query = query;
    _fetchRestaurantData();
    notifyListeners();
  }

  void setQuery(String query) {
    _query = query;
    _fetchRestaurantData();
    notifyListeners();
  }

  Future<dynamic> _fetchRestaurantData() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final connection = await connectionService.connectionService(context);
      if (!connection.connected) {
        _state = ResultState.NoConnection;
        notifyListeners();
        return _message = connection.message;
      }
      final restaurant = await getRestaurantData();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'No Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error: $e';
    }
  }

  Future<RestaurantResult> getRestaurantData() async {
    String api;
    if (query == null || query == '') {
      api = ApiService.list;
    } else {
      api = ApiService.search + query;
    }
    final response = await http.get(Uri.parse(api));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to Load Restaurant Data");
    }
  }
}
