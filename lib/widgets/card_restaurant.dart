import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resstaurant_api/common/styles.dart';
import 'package:resstaurant_api/data/api/api_service.dart';
import 'package:resstaurant_api/data/model/restaurant.dart';
import 'package:resstaurant_api/provider/favorite_provider.dart';
import 'package:resstaurant_api/ui/restaurant_detail_page.dart';

class CardRestaurant extends StatelessWidget {
  const CardRestaurant({Key key, @required this.restaurant}) : super(key: key);

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantFavoriteProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isFavorited(restaurant.id),
          builder: (context, snapshot) {
            var isFav = snapshot.data ?? false;
            return Material(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RestaurantDetailPage.routeName,
                      arguments: restaurant.id);
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Hero(
                          tag: Image.network(
                            ApiService.smallImage + restaurant.pictureId,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              ApiService.smallImage + restaurant.pictureId,
                              height: 78.0,
                              width: 78.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              restaurant.name,
                              style: primaryText,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.stars,
                                  color: yellowColor,
                                  size: 20.0,
                                ),
                                Text(
                                  restaurant.rating.toString(),
                                  style: secondaryText,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            // mainAxisAlignment: MainAxisAlignment.start,
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: redColor,
                                  size: 20.0,
                                ),
                                Text(
                                  restaurant.city,
                                  style: TextStyle(
                                    color: locationColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            )
                          ],
                        ),
                        const Expanded(
                          child: SizedBox(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: IconButton(
                            icon: isFav
                                ? IconButton(
                                    onPressed: () =>
                                        provider.removeFavorite(restaurant.id),
                                    icon: Icon(
                                      Icons.favorite,
                                      color: redColor,
                                    ),
                                  )
                                : IconButton(
                                    onPressed: () =>
                                        provider.addFavorite(restaurant),
                                    icon: Icon(
                                      Icons.favorite_border,
                                      color: redColor,
                                    ),
                                  ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
