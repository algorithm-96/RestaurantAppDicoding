import 'package:flutter/material.dart';
import 'package:restaurant_sub2_app/screens/search_screen.dart';
import 'package:restaurant_sub2_app/widgets/restaurant_page.dart';

class FirstScreen extends StatelessWidget {
  static const String routeName = '/second_screen';
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (const Text("Restaurant")),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchScreen.routeName);
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: RestaurantPage(),
    );
  }
}
