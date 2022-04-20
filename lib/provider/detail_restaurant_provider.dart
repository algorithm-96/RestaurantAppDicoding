import 'package:flutter/cupertino.dart';
import 'package:restaurant_sub2_app/data/api/api_service.dart';
import 'package:restaurant_sub2_app/data/model/restaurant_detail_response.dart';
import 'package:restaurant_sub2_app/utils/result_state.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final String restaurant;

  DetailRestaurantProvider(
      {required this.apiService, required this.restaurant}) {
    _fetchRestaurantDetail();
  }

  late RestaurantDetailResult _restaurantDetailResult;
  late ResultState _resultState;
  String _message = '';

  RestaurantDetailResult get restaurantListResult => _restaurantDetailResult;
  ResultState get resultState => _resultState;
  String get message => _message;

  Future<dynamic> _fetchRestaurantDetail() async {
    try {
      _resultState = ResultState.loading;
      notifyListeners();
      final response = await apiService.getDetailRestaurant(restaurant);
      if (response.restaurants == ResultState.noData) {
        _resultState = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _resultState = ResultState.hasData;
        notifyListeners();
        return _restaurantDetailResult = response;
      }
    } catch (e) {
      _resultState = ResultState.error;
      notifyListeners();
      return _message = 'Error ga ada sinyal keknya';
    }
  }
}
