import 'package:flutter/cupertino.dart';
import 'package:restaurant_sub2_app/data/api/api_service.dart';
import 'package:restaurant_sub2_app/utils/result_state.dart';

import '../data/model/restaurant_list_response.dart';

class ListRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  ListRestaurantProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }

  late RestauranListtResult _restaurantList;
  late ResultState _resultState;
  String _message = '';

  RestauranListtResult get restaurantListResult => _restaurantList;
  ResultState get resultState => _resultState;
  String get message => _message;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _resultState = ResultState.loading;
      notifyListeners();
      final response = await apiService.getListRestaurant();
      if (response.restaurants.isEmpty) {
        _resultState = ResultState.noData;
        notifyListeners();
        return _message = 'Ga Ada Data';
      } else {
        _resultState = ResultState.hasData;
        notifyListeners();
        return _restaurantList = response;
      }
    } catch (e) {
      _resultState = ResultState.error;
      notifyListeners();
      return _message = 'Gagal Memuat Data';
    }
  }
}
