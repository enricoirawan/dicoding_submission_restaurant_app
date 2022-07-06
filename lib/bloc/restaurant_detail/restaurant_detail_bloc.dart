import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:submission_dicoding_app/common/status.dart';
import 'package:submission_dicoding_app/data/api/api_service.dart';
import 'package:submission_dicoding_app/data/model/restaurant_detail.dart';

part 'restaurant_detail_event.dart';
part 'restaurant_detail_state.dart';

class RestaurantDetailBloc
    extends Bloc<RestaurantDetailEvent, RestaurantDetailState> {
  final ApiService _apiService;
  RestaurantDetailBloc({required ApiService apiService})
      : _apiService = apiService,
        super(RestaurantDetailState.initial()) {
    on<GetRestaurantDetail>(_getRestaurantDetail);
  }

  void _getRestaurantDetail(
    GetRestaurantDetail event,
    Emitter<RestaurantDetailState> emit,
  ) async {
    try {
      emit(state.copyWith(
        status: Status.loading,
      ));

      final RestaurantDetail restaurantDetail =
          await _apiService.getDetailRestaurant(
        event.id,
      );

      emit(state.copyWith(
        status: Status.success,
        restaurantDetail: restaurantDetail,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: Status.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
