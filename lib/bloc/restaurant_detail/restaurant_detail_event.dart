part of 'restaurant_detail_bloc.dart';

abstract class RestaurantDetailEvent extends Equatable {}

class GetRestaurantDetail extends RestaurantDetailEvent {
  final String id;

  GetRestaurantDetail({required this.id});

  @override
  List<Object?> get props => [id];
}
