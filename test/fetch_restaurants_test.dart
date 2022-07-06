import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:submission_dicoding_app/common/constant.dart';
import 'package:submission_dicoding_app/data/api/api_service.dart';
import 'package:submission_dicoding_app/data/model/restaurant.dart';
import 'package:submission_dicoding_app/data/model/restaurant_detail.dart';

import 'fetch_restaurants_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  group("fetch restaurant", () {
    test(
      "return the restaurant list if request success",
      () async {
        final dio = MockDio();
        const String url = baseUrl + '/list';
        final response = Response(
          requestOptions: RequestOptions(path: ""),
          data: {
            "error": false,
            "message": "success",
            "count": 20,
            "restaurants": [
              {
                "id": "rqdv5juczeskfw1e867",
                "name": "Melting Pot",
                "description":
                    "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
                "pictureId": "14",
                "city": "Medan",
                "rating": 4.2
              },
              {
                "id": "s1knt6za9kkfw1e867",
                "name": "Kafe Kita",
                "description":
                    "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
                "pictureId": "25",
                "city": "Gorontalo",
                "rating": 4
              }
            ]
          },
        );

        when(dio.get(url)).thenAnswer((_) async => response);
        final result = await ApiService(
          dio: dio,
        ).getRestaurantList();
        expect(result, isA<List<Restaurant>>());
      },
    );

    test(
      "return the restaurant detail if request success",
      () async {
        final dio = MockDio();
        const String url = baseUrl + '/detail/rqdv5juczeskfw1e867';
        final response = Response(
          requestOptions: RequestOptions(path: ""),
          data: {
            "error": false,
            "message": "success",
            "restaurant": {
              "id": "rqdv5juczeskfw1e867",
              "name": "Melting Pot",
              "description":
                  "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
              "city": "Medan",
              "address": "Jln. Pandeglang no 19",
              "pictureId": "14",
              "categories": [
                {"name": "Italia"},
                {"name": "Modern"}
              ],
              "menus": {
                "foods": [
                  {"name": "Paket rosemary"},
                  {"name": "Toastie salmon"}
                ],
                "drinks": [
                  {"name": "Es krim"},
                  {"name": "Sirup"}
                ]
              },
              "rating": 4.2,
              "customerReviews": [
                {
                  "name": "Ahmad",
                  "review": "Tidak rekomendasi untuk pelajar!",
                  "date": "13 November 2019"
                }
              ]
            }
          },
        );

        when(dio.get(url)).thenAnswer((_) async => response);
        final result = await ApiService(
          dio: dio,
        ).getDetailRestaurant("rqdv5juczeskfw1e867");
        expect(result, isA<RestaurantDetail>());
      },
    );
  });
}
