import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:resstaurant_api/data/api/api_service.dart';
import 'package:resstaurant_api/data/model/restaurant.dart';
import 'provider_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  group(
    'fetchRestaurantData',
    () {
      test(
        'Restaurant Provider test if result from ApiService has called succesfully ',
        () async {
          final client = MockClient();
          when(client.get(Uri.parse(ApiService.list))).thenAnswer(
            (_) async => http.Response('''{
                          "error": false,
                          "message": "success",
                          "count": 20,
                          "restaurants": [
                              {
                                  "id": "rqdv5juczeskfw1e867",
                                  "name": "Melting Pot",
                                  "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
                                  "pictureId": "14",
                                  "city": "Medan",
                                  "rating": 4.2
                              },
                              {
                                  "id": "s1knt6za9kkfw1e867",
                                  "name": "Kafe Kita",
                                  "description": "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
                                  "pictureId": "25",
                                  "city": "Gorontalo",
                                  "rating": 4
                              }
                          ]
                      }
            ''', 200),
          );
          // assert
          expect(await ApiService(client: client).getRestaurants(),
              isA<RestaurantResult>());
        },
      );
    },
  );
}
