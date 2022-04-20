import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_sub2_app/data/api/api_service.dart';
import 'package:restaurant_sub2_app/data/model/restaurant_list_response.dart';
import 'package:restaurant_sub2_app/provider/detail_restaurant_provider.dart';
import 'package:restaurant_sub2_app/utils/result_state.dart';
import 'package:restaurant_sub2_app/widgets/detail_restaurant_page.dart';

class SecondScreen extends StatelessWidget {
  static const routeName = "/second_screen";

  final Restaurant restaurant;

  const SecondScreen({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailRestaurantProvider>(
      create: (_) => DetailRestaurantProvider(
          apiService: ApiService(), restaurant: restaurant.id),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Detail Restaurant"),
        ),
        body: Consumer<DetailRestaurantProvider>(
          builder: (context, value, _) {
            if (value.resultState == ResultState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (value.resultState == ResultState.hasData) {
              return Scaffold(
                body: DetailRestaurantPage(
                  restaurant: value.restaurantListResult.restaurants,
                ),
              );
            } else if (value.resultState == ResultState.noData) {
              return Center(child: Text(value.message));
            } else if (value.resultState == ResultState.error) {
              return Center(child: Text(value.message));
            } else {
              return const Center(child: Text(''));
            }
          },
        ),
      ),
    );
  }
}
