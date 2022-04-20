import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_sub2_app/data/api/api_service.dart';
import 'package:restaurant_sub2_app/data/model/restaurant_list_response.dart';
import 'package:restaurant_sub2_app/provider/list_restaurant_provider.dart';
import 'package:restaurant_sub2_app/provider/search_restaurant_provider.dart';
import 'package:restaurant_sub2_app/screens/first_screen.dart';
import 'package:restaurant_sub2_app/screens/search_screen.dart';
import 'package:restaurant_sub2_app/screens/second_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ListRestaurantProvider>(
          create: (_) => ListRestaurantProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider<SearchRestaurantProvider>(
          create: (_) => SearchRestaurantProvider(apiService: ApiService()),
        )
      ],
      child: MaterialApp(
        title: 'RestaurantApp',
        theme: ThemeData(),
        home: FirstScreen(),
        routes: {
          FirstScreen.routeName: (context) => FirstScreen(),
          SecondScreen.routeName: (context) => SecondScreen(
                restaurant:
                    ModalRoute.of(context)?.settings.arguments as Restaurant,
              ),
          SearchScreen.routeName: (context) => SearchScreen()
        },
      ),
    );
  }
}
