part of 'favorite_cubit.dart';

class FavoriteState extends Equatable {
  final List<Restaurant> favoriteRestaurants;
  final Status status;
  final String errorMessage;
  final bool isFavorite;

  const FavoriteState({
    required this.favoriteRestaurants,
    required this.status,
    required this.errorMessage,
    required this.isFavorite,
  });

  FavoriteState copyWith({
    List<Restaurant>? favoriteRestaurants,
    Status? status,
    String? errorMessage,
    bool? isFavorite,
  }) {
    return FavoriteState(
      favoriteRestaurants: favoriteRestaurants ?? this.favoriteRestaurants,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory FavoriteState.initial() {
    return const FavoriteState(
      favoriteRestaurants: [],
      status: Status.initial,
      errorMessage: "",
      isFavorite: false,
    );
  }

  @override
  List<Object> get props => [
        favoriteRestaurants,
        status,
        isFavorite,
        errorMessage,
      ];
}
