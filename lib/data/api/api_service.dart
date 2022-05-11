import 'dart:convert';
import 'package:restaurant_sub2_app/data/model/restaurant_detail_response.dart';
import 'package:http/http.dart' show Client;
import 'package:restaurant_sub2_app/data/model/restaurant_search_response.dart';

import '../model/restaurant_list_response.dart';

class ApiService {
  static const String _throw = 'Failed load Data';
  static const String baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String list = 'list';

  final Client client;
  ApiService(this.client);

  Future<RestauranListtResult> getListRestaurant() async {
    final response = await client.get(Uri.parse(baseUrl + list));

    if (response.statusCode == 200) {
      return RestauranListtResult.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(_throw);
    }
  }

  Future<RestaurantSearchResult> getSearchRestaurant(String query) async {
    final response = await client.get(Uri.parse(baseUrl + 'search?q=' + query));
    if (response.statusCode == 200) {
      return RestaurantSearchResult.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(_throw);
    }
  }

  Future<RestaurantDetailResult> getDetailRestaurant(String id) async {
    final response = await client.get(Uri.parse(baseUrl + 'detail/' + id));
    if (response.statusCode == 200) {
      return RestaurantDetailResult.fromJson(json.decode(response.body));
    } else {
      throw Exception(_throw);
    }
  }
}
