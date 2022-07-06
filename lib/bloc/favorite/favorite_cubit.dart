import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:submission_dicoding_app/common/status.dart';
import 'package:submission_dicoding_app/data/database/database_helper.dart';
import 'package:submission_dicoding_app/data/model/restaurant.dart';
import 'package:submission_dicoding_app/data/model/restaurant_detail.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final DatabaseHelper _databaseHelper;

  FavoriteCubit({
    required DatabaseHelper databaseHelper,
  })  : _databaseHelper = databaseHelper,
        super(FavoriteState.initial());

  void getFavoriteRestaurants() async {
    try {
      emit(
        state.copyWith(
          status: Status.loading,
        ),
      );

      final List<Restaurant> restaurants =
          await _databaseHelper.getFavoriteRestaurant();

      emit(
        state.copyWith(
          favoriteRestaurants: restaurants,
          status: Status.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          status: Status.error,
        ),
      );
    }
  }

  void insertFavoriteRestaurant({
    required RestaurantDetail restaurantDetail,
  }) async {
    try {
      emit(
        state.copyWith(
          status: Status.loading,
        ),
      );

      final bool result = await _databaseHelper.insertFavoriteRestaurant(
        restaurantDetail: restaurantDetail,
      );

      if (result) {
        emit(state.copyWith(
          status: Status.success,
        ));
      } else {
        emit(
          state.copyWith(
            status: Status.error,
            errorMessage:
                "Yah... Gagal menambahkan ke favorite kamu nih, Coba lagi nanti ya...",
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          status: Status.error,
        ),
      );
    }
  }

  void deleteFavoriteRestaurant({
    required String id,
  }) async {
    try {
      emit(
        state.copyWith(
          status: Status.loading,
        ),
      );

      final bool result = await _databaseHelper.deleteFavoriteRestaurant(
        id: id,
      );

      if (result) {
        emit(state.copyWith(
          status: Status.success,
        ));
      } else {
        emit(
          state.copyWith(
            status: Status.error,
            errorMessage:
                "Yah... Gagal mengahpus dari favorite kamu nih, Coba lagi nanti ya...",
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          status: Status.error,
        ),
      );
    }
  }

  void isFavoriteRestaurant({
    required String id,
  }) async {
    try {
      emit(
        state.copyWith(
          status: Status.loading,
        ),
      );

      final bool result = await _databaseHelper.isFavoriteRestaurant(
        id: id,
      );

      emit(
        state.copyWith(
          status: Status.success,
          isFavorite: result,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          status: Status.error,
        ),
      );
    }
  }
}
