part of 'restaurant_bloc.dart';

class RestaurantState extends Equatable {
  final List<Restaurant> restaurants;
  final Status status;
  final String errorMessage;

  const RestaurantState({
    required this.restaurants,
    required this.status,
    required this.errorMessage,
  });

  RestaurantState copyWith({
    List<Restaurant>? restaurants,
    Status? status,
    String? errorMessage,
  }) {
    return RestaurantState(
      restaurants: restaurants ?? this.restaurants,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  factory RestaurantState.initial() {
    return const RestaurantState(
      restaurants: [],
      status: Status.initial,
      errorMessage: "",
    );
  }

  @override
  List<Object> get props => [restaurants, status, errorMessage];
}
