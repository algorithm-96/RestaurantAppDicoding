import 'package:flutter/material.dart';
import 'package:restaurant_sub2_app/common/navigation.dart';
import 'package:restaurant_sub2_app/common/style.dart';
import 'package:restaurant_sub2_app/data/model/restaurant_list_response.dart';
import 'package:restaurant_sub2_app/screens/detail_page.dart';

class CardResult extends StatelessWidget {
  final Restaurant restaurant;
  const CardResult({Key? key, required this.restaurant}) : super(key: key);

  static const String _baseUrlImage =
      'https://restaurant-api.dicoding.dev/images/small/';

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigation.intentWithData(DetailPage.routeName, restaurant);
      },
      leading: Image.network(_baseUrlImage + restaurant.pictureId),
      title: Text(restaurant.name),
      subtitle: Text(restaurant.city),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(restaurant.rating),
          const Icon(
            Icons.star,
            color: colorPrimary,
          )
        ],
      ),
    );
  }
}
