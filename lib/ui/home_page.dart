import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resstaurant_api/provider/restaurant.provider.dart';
import 'package:resstaurant_api/ui/restaurant_list_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantProvider>(
      create: (_) => RestaurantProvider(context),
      child: const RestaurantListPage(),
    );
  }
}
