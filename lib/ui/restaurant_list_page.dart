import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:resstaurant_api/common/styles.dart';
import 'package:resstaurant_api/provider/restaurant.provider.dart';
import 'package:resstaurant_api/ui/favotire_page.dart';
import 'package:resstaurant_api/ui/setting_page.dart';
import 'package:resstaurant_api/widgets/card_restaurant.dart';
import 'package:resstaurant_api/widgets/search_restaurant.dart';
import 'package:resstaurant_api/widgets/size_config.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({Key key}) : super(key: key);

  Widget _buildList() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Text(
              "Restaurant App",
              style: titleText,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              "Recomendation restaurant for you!",
              style: secondaryText,
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: Consumer<RestaurantProvider>(
                builder: (context, state, _) {
                  if (state.state == ResultState.Loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.state == ResultState.HasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.result.restaurants.length,
                      itemBuilder: (context, index) {
                        var restaurant = state.result.restaurants[index];
                        return CardRestaurant(restaurant: restaurant);
                      },
                    );
                  } else if (state.state == ResultState.NoData) {
                    return Center(child: Text(state.message));
                  } else if (state.state == ResultState.Error) {
                    return Center(child: Text(state.message));
                  } else {
                    return const Center(child: Text(''));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: redColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Menu',
                  style: TextStyle(
                      color: blackColor,
                      fontSize: 28,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Setting'),
              onTap: () => Navigator.pushNamed(context, SettingPage.routeName),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: redColor,
        title: const Text("Restaurant App"),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, FavoritePage.routeName),
            icon: const Icon(Icons.favorite, color: Colors.white),
          ),
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pushNamed(context, SearchPage.routeName),
          ),
        ],
      ),
      body: _buildList(),
    );
  }
}
