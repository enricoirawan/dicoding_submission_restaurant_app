import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:submission_dicoding_app/bloc/connected_bloc/connected_bloc.dart';
import 'package:submission_dicoding_app/bloc/favorite/favorite_cubit.dart';
import 'package:submission_dicoding_app/common/status.dart';
import 'package:submission_dicoding_app/data/model/restaurant.dart';
import 'package:submission_dicoding_app/injection.dart';
import 'package:submission_dicoding_app/route.dart';
import 'package:submission_dicoding_app/widgets/custom_error_widget.dart';
import 'package:submission_dicoding_app/widgets/loading_widget.dart';
import 'package:submission_dicoding_app/widgets/no_connection.dart';
import 'package:submission_dicoding_app/widgets/popular_restaurant_item.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FavoriteCubit _favoriteCubit = getIt<FavoriteCubit>();
    _favoriteCubit.getFavoriteRestaurants();

    Widget _renderEmptyState() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset("assets/empty.json", height: 300),
            Text(
              "Masih kosong nih.",
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        _favoriteCubit.getFavoriteRestaurants();
      },
      child: BlocBuilder<ConnectedBloc, ConnectedState>(
        builder: (BuildContext context, ConnectedState state) {
          if (state is ConnectedFailureState) {
            return const NoConnectionWidget();
          }
          return BlocBuilder<FavoriteCubit, FavoriteState>(
            builder: (context, state) {
              final List<Restaurant> favoriteRestaurants =
                  state.favoriteRestaurants;

              if (state.status == Status.success) {
                if (favoriteRestaurants.isEmpty) {
                  return _renderEmptyState();
                }
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: favoriteRestaurants.length,
                    itemBuilder: (context, index) {
                      final Restaurant restaurant = favoriteRestaurants[index];
                      return PopularRestaurantItem(
                        restaurant: restaurant,
                        callback: () {
                          Navigator.of(context)
                              .pushNamed(
                            RouteGenerator.detailScreenRoute,
                            arguments: restaurant.id,
                          )
                              .then((_) {
                            _favoriteCubit.getFavoriteRestaurants();
                          });
                        },
                      );
                    },
                  ),
                );
              } else if (state.status == Status.error) {
                return CustomErrorWidget(
                  errorMessage: state.errorMessage,
                );
              }
              return const LoadingWidget();
            },
          );
        },
      ),
    );
  }
}
