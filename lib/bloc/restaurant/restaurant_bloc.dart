import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:submission_dicoding_app/common/status.dart';

import 'package:submission_dicoding_app/data/api/api_service.dart';
import 'package:submission_dicoding_app/data/model/restaurant.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final ApiService _apiService;

  RestaurantBloc({
    required ApiService apiService,
  })  : _apiService = apiService,
        super(RestaurantState.initial()) {
    on<GetListRestaurant>(_getListRestaurant);
    on<SearchRestaurant>(_searchRestaurant);
    on<ClearRestaurant>(_clearRestaurant);
  }

  void _getListRestaurant(
    GetListRestaurant event,
    Emitter<RestaurantState> emit,
  ) async {
    try {
      //set loading state
      emit(state.copyWith(
        status: Status.success,
      ));

      final List<Restaurant> restaurants =
          await _apiService.getRestaurantList();
      emit(state.copyWith(
        restaurants: restaurants,
        status: Status.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: Status.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void _searchRestaurant(
    SearchRestaurant event,
    Emitter<RestaurantState> emit,
  ) async {
    try {
      //set loading state
      emit(state.copyWith(
        status: Status.success,
      ));

      final List<Restaurant> restaurants =
          await _apiService.searchRestaurant(event.query);
      emit(state.copyWith(
        restaurants: restaurants,
        status: Status.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: Status.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void _clearRestaurant(
    ClearRestaurant event,
    Emitter<RestaurantState> emit,
  ) async {
    emit(state.copyWith(
      status: Status.initial,
      errorMessage: "",
      restaurants: [],
    ));
  }
}
