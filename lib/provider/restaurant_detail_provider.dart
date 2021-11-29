import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:resstaurant_api/data/api/api_service.dart';
import 'package:resstaurant_api/data/api/connection.service.dart';
import 'package:resstaurant_api/data/model/restaurant_detail.dart';
import 'package:resstaurant_api/provider/restaurant.provider.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  RestaurantDetailProvider(this.context, {@required this.id}) {
    _fetchRestaurantDetailData();
  }
  final String id;
  final BuildContext context;
  final apiService = ApiService();
  final connectionService = ConnectionService();

  String _message = '';
  ResultState _state;
  RestaurantDetail _RestaurantDetailResult;

  String get message => _message;
  ResultState get state => _state;
  RestaurantDetail get result => _RestaurantDetailResult;

  Future<dynamic> _fetchRestaurantDetailData() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final connection = await connectionService.connectionService(context);
      if (!connection.connected) {
        _state = ResultState.NoConnection;
        notifyListeners();
        return _message = connection.message;
      }
      final restaurant = await getRestaurantDetail();
      if (restaurant.restaurant == null) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'No Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _RestaurantDetailResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error: $e';
    }
  }

  Future<RestaurantDetail> getRestaurantDetail() async {
    final response = await http.get(Uri.parse(ApiService.detail + id));
    if (response.statusCode == 200) {
      return RestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Ugh, seems like we\'re failed to load the resto details');
    }
  }

  void refresh() {
    _fetchRestaurantDetailData();
    notifyListeners();
  }
}
