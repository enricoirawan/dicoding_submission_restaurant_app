part of 'restaurant_bloc.dart';

@immutable
abstract class RestaurantEvent extends Equatable {}

class GetListRestaurant extends RestaurantEvent {
  @override
  List<Object?> get props => [];
}

class SearchRestaurant extends RestaurantEvent {
  final String query;

  SearchRestaurant({
    required this.query,
  });

  @override
  List<Object?> get props => [query];
}

class ClearRestaurant extends RestaurantEvent {
  @override
  List<Object?> get props => [];
}
