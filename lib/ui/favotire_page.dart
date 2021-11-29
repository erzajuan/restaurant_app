import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resstaurant_api/common/styles.dart';
import 'package:resstaurant_api/provider/favorite_provider.dart';
import 'package:resstaurant_api/provider/restaurant.provider.dart';
import 'package:resstaurant_api/widgets/card_restaurant.dart';
import 'package:resstaurant_api/widgets/size_config.dart';

class FavoritePage extends StatelessWidget {
  static const String routeName = '/favorite_page';

  const FavoritePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: redColor,
        title: const Text(
          'Favorite Page',
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return Consumer<RestaurantFavoriteProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.HasData) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.favorite.length,
            itemBuilder: (context, index) {
              return CardRestaurant(
                restaurant: provider.favorite[index],
              );
            },
          );
        } else {
          return Center(
            child: Text(provider.message),
          );
        }
      },
    );
  }
}
