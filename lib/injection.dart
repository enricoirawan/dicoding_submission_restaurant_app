import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:submission_dicoding_app/bloc/favorite/favorite_cubit.dart';
import 'package:submission_dicoding_app/bloc/restaurant_detail/restaurant_detail_bloc.dart';
import 'package:submission_dicoding_app/bloc/restaurant/restaurant_bloc.dart';
import 'package:submission_dicoding_app/data/api/api_service.dart';
import 'package:submission_dicoding_app/data/database/database_helper.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio: Dio()));
  getIt.registerLazySingleton<RestaurantBloc>(
      () => RestaurantBloc(apiService: getIt.get<ApiService>()));
  getIt.registerLazySingleton<RestaurantDetailBloc>(
      () => RestaurantDetailBloc(apiService: getIt.get<ApiService>()));
  getIt.registerLazySingleton<FavoriteCubit>(
      () => FavoriteCubit(databaseHelper: DatabaseHelper()));
}
