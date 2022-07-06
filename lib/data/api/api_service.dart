import 'package:dio/dio.dart';
import 'package:submission_dicoding_app/common/constant.dart';
import 'package:submission_dicoding_app/data/model/restaurant.dart';
import 'package:submission_dicoding_app/data/model/restaurant_detail.dart';

class ApiService {
  final Dio _dio;

  ApiService({required Dio dio}) : _dio = dio;

  Future<List<Restaurant>> getRestaurantList() async {
    const String url = baseUrl + '/list';

    try {
      Response response = await _dio.get(url);
      List<Restaurant> restaurants = [];

      for (var item in response.data['restaurants']) {
        restaurants.add(Restaurant.fromMap(item));
      }

      return restaurants;
    } catch (e) {
      throw Exception(
        'Gagal mengambil data, silahkan coba lagi beberapa saat...',
      );
    }
  }

  Future<RestaurantDetail> getDetailRestaurant(String id) async {
    final String url = baseUrl + '/detail/' + id;

    try {
      var response = await _dio.get(url);

      return RestaurantDetail.fromMap(response.data['restaurant']);
    } catch (e) {
      throw Exception(
        'Gagal mengambil data, silahkan coba lagi beberapa saat...',
      );
    }
  }

  Future<bool> addReview(String id, String name, String review) async {
    const String url = baseUrl + '/review';

    try {
      var response = await _dio.post(url, data: {
        'id': id,
        'name': name,
        'review': review,
      });

      if (response.data['error'] != false) {
        ///Tidak success
        return false;
      }

      return true;
    } catch (e) {
      throw Exception(
        'Gagal menyimpan data, silahkan coba lagi beberapa saat...',
      );
    }
  }

  Future<List<Restaurant>> searchRestaurant(String query) async {
    final String url = '$baseUrl/search?q=$query';

    try {
      var response = await _dio.get(url);
      List<Restaurant> restaurants = [];

      for (var item in response.data['restaurants']) {
        restaurants.add(Restaurant.fromMap(item));
      }

      return restaurants;
    } catch (e) {
      throw Exception(
        'Gagal mengambil data, silahkan coba lagi beberapa saat...',
      );
    }
  }
}
