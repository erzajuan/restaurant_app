import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resstaurant_api/common/styles.dart';
import 'package:resstaurant_api/data/api/api_service.dart';
import 'package:resstaurant_api/provider/restaurant.provider.dart';
import 'package:resstaurant_api/provider/restaurant_detail_provider.dart';
import 'package:resstaurant_api/widgets/size_config.dart';

class RestaurantDetailPage extends StatefulWidget {
  const RestaurantDetailPage({Key key, @required this.id}) : super(key: key);
  static const routeName = "/detail_page";
  final String id;

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (_) => RestaurantDetailProvider(context, id: widget.id),
      child: Scaffold(
        body: Consumer<RestaurantDetailProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.HasData) {
              return Scaffold(
                  backgroundColor: backgroundColor,
                  body: NestedScrollView(
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverAppBar(
                          backgroundColor: redColor,
                          expandedHeight: 50.0,
                          floating: false,
                          leading: IconButton(
                            icon: const Icon(Icons.arrow_back_ios,
                                color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ];
                    },
                    body: SingleChildScrollView(
                      child: SizedBox(
                        height: 1100,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 310,
                              child: Stack(
                                children: [
                                  Hero(
                                    tag: ApiService.smallImage +
                                        state.result.restaurant.pictureId,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(20.0),
                                        bottomRight: Radius.circular(20.0),
                                      ),
                                      child: Image.network(ApiService
                                              .largeImage +
                                          state.result.restaurant.pictureId),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    left: 50,
                                    right: 50,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Container(
                                        width: 315,
                                        height: 90,
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      state.result.restaurant
                                                          .name,
                                                      style: primaryText),
                                                  const SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(Icons.location_on,
                                                          color: redColor),
                                                      Text(
                                                          state.result
                                                              .restaurant.city,
                                                          style: secondaryText),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const Flexible(
                                                flex: 1,
                                                child: SizedBox(
                                                  width: 130.0,
                                                ),
                                              ),
                                              Icon(Icons.stars,
                                                  color: yellowColor, size: 30),
                                              Text(
                                                state.result.restaurant.rating
                                                    .toString(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  Container(
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Description",
                                            style: TextStyle(
                                              color: redColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          const SizedBox(height: 15.0),
                                          Text(
                                            state.result.restaurant.description,
                                            style: TextStyle(
                                                color: blackColor,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            height: 20.0,
                                          ),
                                          Text(
                                            "Menu",
                                            style: TextStyle(
                                                color: redColor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.white,
                                    height: 200.0,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: state
                                            .result.restaurant.menus.foods
                                            .map(
                                              (food) => Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: SizedBox(
                                                  height: 150,
                                                  width: 150,
                                                  child: Column(
                                                    children: [
                                                      Icon(
                                                        Icons.food_bank,
                                                        size: 60,
                                                        color: redColor,
                                                      ),
                                                      // Icon(Icons.food_bank, size: 50),
                                                      Text(food.name,
                                                          style: primaryText),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.white,
                                    height: 200.0,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: state
                                            .result.restaurant.menus.drinks
                                            .map(
                                              (food) => Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: SizedBox(
                                                  height: 150,
                                                  width: 150,
                                                  child: Column(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .emoji_food_beverage,
                                                        size: 60,
                                                        color: redColor,
                                                      ),
                                                      // Icon(Icons.food_bank, size: 50),
                                                      Text(food.name,
                                                          style: primaryText),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));
            } else if (state.state == ResultState.NoData) {
              return Center(child: Text(state.message));
            } else if (state.state == ResultState.Error) {
              return Center(child: Text(state.message));
            } else if (state.state == ResultState.NoConnection) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () => state.refresh(),
                      child: const Text('Refresh'),
                    )
                  ],
                ),
              );
            } else {
              return const Center(child: Text(''));
            }
          },
        ),
      ),
    );
  }
}
