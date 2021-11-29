import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:resstaurant_api/alarm/background_services.dart';
import 'package:resstaurant_api/alarm/notification_helper.dart';
import 'package:resstaurant_api/data/preferences/preferences_helper.dart';
import 'package:resstaurant_api/provider/favorite_provider.dart';
import 'package:resstaurant_api/provider/preferences_provider.dart';
import 'package:resstaurant_api/provider/restaurant.provider.dart';
import 'package:resstaurant_api/provider/scheduling_provider.dart';
import 'package:resstaurant_api/ui/favotire_page.dart';
import 'package:resstaurant_api/ui/home_page.dart';
import 'package:resstaurant_api/ui/restaurant_detail_page.dart';
import 'package:resstaurant_api/ui/restaurant_list_page.dart';
import 'package:resstaurant_api/ui/setting_page.dart';
import 'package:resstaurant_api/widgets/search_restaurant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/database/database_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantProvider>(
          create: (_) => RestaurantProvider(context),
        ),
        ChangeNotifierProvider<RestaurantFavoriteProvider>(
          create: (_) => RestaurantFavoriteProvider(
            databaseHelper: DatabaseHelper(),
          ),
        ),
        ChangeNotifierProvider<SchedulingProvider>(
          create: (_) => SchedulingProvider(),
        ),
        ChangeNotifierProvider<PreferencesProvider>(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: "Submission Restaurant Api",
        theme: ThemeData(
          textTheme: GoogleFonts.robotoTextTheme(),
        ),
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (context) => const HomePage(),
          SearchPage.routeName: (context) => const SearchPage(),
          RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
                id: ModalRoute.of(context).settings.arguments as String,
              ),
          FavoritePage.routeName: (context) => const FavoritePage(),
          SettingPage.routeName: (context) => const SettingPage(),
        },
      ),
    );
  }
}
