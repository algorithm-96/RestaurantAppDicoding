import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_sub2_app/data/api/api_service.dart';
import 'package:restaurant_sub2_app/data/model/restaurant_list_response.dart';
import 'call_api_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('Fetch List Restaurant', () {
    test('returns an Restaurant if the http call completes successfully', () async {
      final client = MockClient();

      when(client.get(Uri.parse(ApiService.baseUrl + ApiService.list)))
          .thenAnswer((_) async => http.Response(
          '{"restaurants":[]}',
          200
      ));
      expect(await ApiService().getListRestaurant(), isA<RestauranListtResult>());
    });
  });
}