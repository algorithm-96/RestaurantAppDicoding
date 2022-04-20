import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_sub2_app/provider/list_restaurant_provider.dart';
import 'package:restaurant_sub2_app/utils/result_state.dart';
import 'package:restaurant_sub2_app/widgets/restaurant_card.dart';

class RestaurantPage extends StatelessWidget {
  const RestaurantPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ListRestaurantProvider>(
      builder: ((context, value, _) {
        if (value.resultState == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (value.resultState == ResultState.hasData) {
            return Scaffold(
              body: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                shrinkWrap: true,
                itemCount: value.restaurantListResult.restaurants.length,
                itemBuilder: (BuildContext context, index) {
                  var restaurant =
                      value.restaurantListResult.restaurants[index];
                  return RestaurantCard(restaurant: restaurant);
                },
              ),
            );
          } else if (value.resultState == ResultState.noData) {
            return Center(
              child: Text(value.message),
            );
          } else if (value.resultState == ResultState.error) {
            return Center(
              child: Text(value.message),
            );
          } else {
            return const Center(
              child: Text(""),
            );
          }
        }
      }),
    );
  }
}
