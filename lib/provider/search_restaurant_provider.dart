import 'package:flutter/cupertino.dart';
import 'package:restaurant_sub2_app/data/api/api_service.dart';
import 'package:restaurant_sub2_app/data/model/restaurant_search_response.dart';
import 'package:restaurant_sub2_app/utils/result_state.dart';

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  SearchRestaurantProvider({required this.apiService}) {
    fetchSearchRestaurants(query);
  }

  RestaurantSearchResult? _restaurantSearchResult;
  ResultState? _resultState;
  late String _message = '';
  late String _query = '';

  RestaurantSearchResult? get restaurantSearchResult => _restaurantSearchResult;
  ResultState? get resultState => _resultState;
  String get messsage => _message;
  String get query => _query;

  Future<dynamic> fetchSearchRestaurants(String query) async {
    try {
      if (query.isNotEmpty) {
        _resultState = ResultState.loading;
        _query = query;
        notifyListeners();

        final response = await apiService.getSearchRestaurant(query);
        if (response.restaurants.isEmpty) {
          _resultState = ResultState.noData;
          notifyListeners();
          return _message = 'Ga ada Data';
        } else {
          _resultState = ResultState.hasData;
          notifyListeners();
          return _restaurantSearchResult = response;
        }
      }
    } catch (e) {
      _resultState = ResultState.error;
      notifyListeners();
      return _message = 'Cek Internetmu';
    }
  }
}
