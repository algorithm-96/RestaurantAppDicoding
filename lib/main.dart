import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_sub2_app/common/navigation.dart';
import 'package:restaurant_sub2_app/data/api/api_service.dart';
import 'package:restaurant_sub2_app/data/database/database_helper.dart';
import 'package:restaurant_sub2_app/data/model/restaurant_list_response.dart';
import 'package:restaurant_sub2_app/provider/database_provider.dart';
import 'package:restaurant_sub2_app/provider/list_restaurant_provider.dart';
import 'package:restaurant_sub2_app/provider/search_restaurant_provider.dart';
import 'package:restaurant_sub2_app/screens/home_page.dart';
import 'package:restaurant_sub2_app/screens/search_page.dart';
import 'package:restaurant_sub2_app/screens/detail_page.dart';
import 'package:restaurant_sub2_app/utils/background_service.dart';
import 'package:restaurant_sub2_app/utils/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ListRestaurantProvider>(
          create: (_) => ListRestaurantProvider(apiService: ApiService(Client())),
        ),
        ChangeNotifierProvider<SearchRestaurantProvider>(
          create: (_) => SearchRestaurantProvider(apiService: ApiService(Client())),
        ),
         ChangeNotifierProvider<DatabaseProvider>(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        )
      ],
      child: MaterialApp(
        title: 'RestaurantApp',
        navigatorKey: navigatorKey,
        theme: ThemeData(),
        home: const HomePage(),
        routes: {
          HomePage.routeName: (context) => const HomePage(),
         DetailPage.routeName: (context) => DetailPage(
                restaurant:
                    ModalRoute.of(context)?.settings.arguments as Restaurant,
              ),
          SearchPage.routeName: (context) => const SearchPage()
        },
      ),
    );
  }
}
