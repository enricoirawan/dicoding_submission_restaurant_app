part of 'restaurant_detail_bloc.dart';

class RestaurantDetailState extends Equatable {
  final RestaurantDetail restaurantDetail;
  final Status status;
  final String errorMessage;

  const RestaurantDetailState({
    required this.restaurantDetail,
    required this.status,
    required this.errorMessage,
  });

  @override
  List<Object> get props => [restaurantDetail, status, errorMessage];

  RestaurantDetailState copyWith({
    RestaurantDetail? restaurantDetail,
    Status? status,
    String? errorMessage,
  }) {
    return RestaurantDetailState(
      restaurantDetail: restaurantDetail ?? this.restaurantDetail,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  factory RestaurantDetailState.initial() {
    return RestaurantDetailState(
      restaurantDetail: RestaurantDetail.initial(),
      errorMessage: "",
      status: Status.initial,
    );
  }
}
