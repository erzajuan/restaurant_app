import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resstaurant_api/common/styles.dart';
import 'package:resstaurant_api/provider/restaurant.provider.dart';
import 'package:resstaurant_api/widgets/card_restaurant.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search_page';

  const SearchPage({Key key}) : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _tecSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantProvider>(
      create: (_) => RestaurantProvider(context),
      child: Scaffold(
          body: Consumer<RestaurantProvider>(builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.HasData) {
          return Stack(
            children: [
              ListView.builder(
                itemCount: state.result.restaurants.length,
                itemBuilder: (context, index) {
                  return CardRestaurant(
                    restaurant: state.result.restaurants[index],
                  );
                },
                padding: const EdgeInsets.only(top: kToolbarHeight + 24),
                shrinkWrap: true,
              ),
              _searchAppbar(context, state)
            ],
          );
        } else if (state.state == ResultState.NoData) {
          return Center(
            child: Text(state.message),
          );
        } else if (state.state == ResultState.Error) {
          return Center(
            child: Text(state.message + "Error"),
          );
        } else if (state.state == ResultState.NoConnection) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  state.message,
                  style: const TextStyle(fontSize: 20, color: Colors.blueGrey),
                ),
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                  onPressed: () => state.refresh(),
                  child: const Text('Refresh'),
                )
              ],
            ),
          );
        } else {
          return const Center(
            child: Text(''),
          );
        }
      })),
    );
  }

  Container _searchAppbar(BuildContext context, RestaurantProvider state) {
    return Container(
        height: kToolbarHeight + 20,
        padding: const EdgeInsets.only(top: 25),
        color: redColor,
        width: MediaQuery.of(context).size.width,
        child: TextField(
            controller: _tecSearch,
            textInputAction: TextInputAction.search,
            style: searchText,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              hintText: 'Masukan Kata Kunci..',
              hintStyle: searchText,
            ),
            onSubmitted: (value) => state.setQuery(value)));
  }
}
