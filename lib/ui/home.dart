import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:submission_dicoding_app/bloc/connected_bloc/connected_bloc.dart';
import 'package:submission_dicoding_app/bloc/restaurant/restaurant_bloc.dart';
import 'package:submission_dicoding_app/common/status.dart';
import 'package:submission_dicoding_app/data/model/restaurant.dart';
import 'package:submission_dicoding_app/common/constant.dart';
import 'package:submission_dicoding_app/injection.dart';
import 'package:submission_dicoding_app/route.dart';
import 'package:submission_dicoding_app/widgets/custom_error_widget.dart';
import 'package:submission_dicoding_app/widgets/loading_widget.dart';
import 'package:submission_dicoding_app/widgets/no_connection.dart';
import 'package:submission_dicoding_app/widgets/recommended_restaurant_item.dart';
import 'package:submission_dicoding_app/widgets/popular_restaurant_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final RestaurantBloc _restaurantBloc = getIt<RestaurantBloc>();
    final responsiveHeight = MediaQuery.of(context).size.height;

    Widget _searchWidget() {
      return GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(RouteGenerator.searchScreenRoute)
              .then((_) {
            _restaurantBloc.add(GetListRestaurant());
          });

          _restaurantBloc.add(ClearRestaurant());
        },
        child: Container(
          height: responsiveHeight < 540 ? 50 : 60,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.search,
                color: Colors.grey,
                size: 25,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "Search...",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.grey,
                    ),
              ),
            ],
          ),
        ),
      );
    }

    Widget _recommendedRestaurantHeaderText() {
      return Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
        child: Text(
          "Rekomendasi Restaurant",
          style: Theme.of(context).textTheme.headline6!.copyWith(
                letterSpacing: 2,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
        ),
      );
    }

    Widget _renderRecommendedRestaurants() {
      final responsiveHeight = MediaQuery.of(context).size.width / 3;

      return SizedBox(
        height: responsiveHeight,
        child: BlocBuilder<RestaurantBloc, RestaurantState>(
          builder: (BuildContext context, RestaurantState state) {
            if (state.status == Status.success) {
              final List<Restaurant> restaurants = state.restaurants;

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: restaurants.length,
                itemBuilder: (context, index) {
                  final Restaurant restaurant = restaurants[index];
                  return RecommendedRestaurantItem(
                    index: index,
                    restaurant: restaurant,
                    total: restaurants.length,
                  );
                },
              );
            } else if (state.status == Status.error) {
              return CustomErrorWidget(
                errorMessage: state.errorMessage,
              );
            }

            return const LoadingWidget();
          },
        ),
      );
    }

    Widget _popularRestaurantHeaderText() {
      return Container(
        margin: const EdgeInsets.only(top: 6),
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 20,
        ),
        child: Text(
          "Paling Populer",
          style: Theme.of(context).textTheme.headline6!.copyWith(
                letterSpacing: 2,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
        ),
      );
    }

    Widget _renderPopularRestaurant() {
      return BlocBuilder<RestaurantBloc, RestaurantState>(
        builder: (BuildContext context, RestaurantState state) {
          if (state.status == Status.success) {
            final List<Restaurant> restaurants = state.restaurants;

            return Column(
              children: restaurants.map((Restaurant restaurant) {
                return PopularRestaurantItem(
                  restaurant: restaurant,
                  callback: () {
                    Navigator.of(context).pushNamed(
                      RouteGenerator.detailScreenRoute,
                      arguments: restaurant.id,
                    );
                  },
                );
              }).toList(),
            );
          } else if (state.status == Status.error) {
            return CustomErrorWidget(
              errorMessage: state.errorMessage,
            );
          }

          return const LoadingWidget();
        },
      );
    }

    return BlocBuilder<ConnectedBloc, ConnectedState>(
      builder: (BuildContext context, state) {
        if (state is ConnectedFailureState) {
          return const NoConnectionWidget();
        }

        return SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              _restaurantBloc.add(GetListRestaurant());
            },
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary),
                ),
                Positioned(
                  right: 16,
                  top: 16,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        RouteGenerator.settingScreenRoute,
                      );
                    },
                    child: const CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage(
                        "assets/photo.png",
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  left: 0,
                  right: 0,
                  top: 25,
                  child: Hero(
                    tag: splashTag,
                    child: Icon(
                      Icons.restaurant_menu,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  right: 0,
                  top: 80,
                  child: Text(
                    "Mau makan apa hari ini?",
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: Colors.white,
                          fontSize: responsiveHeight < 540 ? 20 : 27,
                        ),
                  ),
                ),
                Positioned(
                  left: 16,
                  right: 0,
                  top: 115,
                  child: Text(
                    "Yuk cari makanan enak di restaurant!",
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: Colors.white,
                          fontSize: responsiveHeight < 540 ? 18 : 20,
                        ),
                  ),
                ),
                Positioned(
                  left: 16,
                  right: 16,
                  top: 160,
                  child: Hero(
                    tag: searchTag,
                    child: _searchWidget(),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 235,
                  bottom: 0,
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _recommendedRestaurantHeaderText(),
                          _renderRecommendedRestaurants(),
                          _popularRestaurantHeaderText(),
                          _renderPopularRestaurant(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
