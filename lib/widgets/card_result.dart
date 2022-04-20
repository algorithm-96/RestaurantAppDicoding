import 'package:flutter/material.dart';
import 'package:restaurant_sub2_app/common/style.dart';
import 'package:restaurant_sub2_app/data/model/restaurant_list_response.dart';

class CardResult extends StatelessWidget {
  final Restaurant restaurant;
  const CardResult({required this.restaurant});

  static const String _baseUrlImage =
      'https://restaurant-api.dicoding.dev/images/small/';

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(_baseUrlImage + restaurant.pictureId),
      title: Text(restaurant.name),
      subtitle: Text(restaurant.city),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(restaurant.rating),
          Icon(
            Icons.star,
            color: colorPrimary,
          )
        ],
      ),
    );
  }
}
