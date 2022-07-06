import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:submission_dicoding_app/bloc/connected_bloc/connected_bloc.dart';
import 'package:submission_dicoding_app/bloc/favorite/favorite_cubit.dart';
import 'package:submission_dicoding_app/bloc/restaurant_detail/restaurant_detail_bloc.dart';
import 'package:submission_dicoding_app/common/constant.dart';
import 'package:submission_dicoding_app/common/status.dart';
import 'package:submission_dicoding_app/data/model/customer_review.dart';
import 'package:submission_dicoding_app/data/model/dynamic_object.dart';
import 'package:submission_dicoding_app/data/model/restaurant_detail.dart';
import 'package:submission_dicoding_app/injection.dart';
import 'package:submission_dicoding_app/route.dart';
import 'package:submission_dicoding_app/widgets/drink_item.dart';
import 'package:submission_dicoding_app/widgets/food_item.dart';
import 'package:submission_dicoding_app/widgets/loading_widget.dart';
import 'package:submission_dicoding_app/widgets/no_connection.dart';

class DetailScreen extends StatelessWidget {
  final String restaurantId;

  const DetailScreen({
    Key? key,
    required this.restaurantId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RestaurantDetailBloc _restaurantDetailBloc =
        getIt<RestaurantDetailBloc>();
    final FavoriteCubit _favoriteCubit = getIt<FavoriteCubit>();

    _restaurantDetailBloc.add(GetRestaurantDetail(id: restaurantId));

    Widget _heroImage(String pictureId) {
      return ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        child: Image.network(
          baseLargeImageUrl + pictureId,
          fit: BoxFit.cover,
        ),
      );
    }

    Widget _rating(String rating) {
      return Positioned(
        right: 10,
        top: 10,
        child: Container(
          height: 40,
          width: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                rating,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
              const SizedBox(
                width: 6,
              ),
              const Icon(
                Icons.star,
                color: Colors.yellow,
                size: 25,
              ),
            ],
          ),
        ),
      );
    }

    Widget _favoriteButton(RestaurantDetail restaurantDetail) {
      return Positioned(
        right: 10,
        bottom: 10,
        child: BlocConsumer<FavoriteCubit, FavoriteState>(
          listener: (context, state) {
            if (state.status == Status.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(
                    state.errorMessage,
                  ),
                ),
              );
            }
          },
          builder: (BuildContext context, state) {
            if (state.status == Status.success) {
              return GestureDetector(
                onTap: () {
                  if (state.isFavorite) {
                    _favoriteCubit.deleteFavoriteRestaurant(id: restaurantId);
                    _favoriteCubit.isFavoriteRestaurant(id: restaurantId);
                  } else {
                    _favoriteCubit.insertFavoriteRestaurant(
                      restaurantDetail: restaurantDetail,
                    );
                    _favoriteCubit.isFavoriteRestaurant(id: restaurantId);
                  }
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Icon(
                    state.isFavorite ? Icons.favorite : Icons.favorite_outline,
                    color: state.isFavorite ? Colors.pink : Colors.black,
                  ),
                ),
              );
            }

            return const SizedBox(
              height: 100,
              width: 100,
              child: LoadingWidget(),
            );
          },
        ),
      );
    }

    Widget _metaData(String name, String city) {
      return Container(
        margin: const EdgeInsets.only(
          left: 16,
          top: 25,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Icon(
                  Icons.pin_drop,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  city,
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        letterSpacing: 1.2,
                      ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget _restaurantDescription(String description) {
      return Container(
        margin: const EdgeInsets.only(left: 16, bottom: 16),
        child: Text(description),
      );
    }

    Widget _renderCategories(String name) {
      return Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            name,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
      );
    }

    Widget _renderReviews(CustomerReview customerReview) {
      return Container(
        width: 200,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tanggal",
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              customerReview.date,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: Colors.white,
                  ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Nama",
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              customerReview.name,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: Colors.white,
                  ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Isi Review",
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              customerReview.review,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: Colors.white,
                  ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );
    }

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          _restaurantDetailBloc.add(GetRestaurantDetail(id: restaurantId));
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: BlocBuilder<ConnectedBloc, ConnectedState>(
            builder: (BuildContext context, state) {
              if (state is ConnectedFailureState) {
                return Container();
              }

              return BlocBuilder<RestaurantDetailBloc, RestaurantDetailState>(
                builder: (BuildContext context, RestaurantDetailState state) {
                  if (state.status == Status.success) {
                    return FloatingActionButton(
                      onPressed: () {
                        // Navigation.intentWithDataAndCallback(
                        //     RouteGenerator.addReviewScreenRoute, restaurantId,
                        //     () {
                        //   _restaurantDetailBloc
                        //       .add(GetRestaurantDetail(id: restaurantId));
                        // });

                        Navigator.of(context)
                            .pushNamed(
                          RouteGenerator.addReviewScreenRoute,
                          arguments: restaurantId,
                        )
                            .then((_) {
                          _restaurantDetailBloc
                              .add(GetRestaurantDetail(id: restaurantId));
                        });
                      },
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    );
                  }

                  return Container();
                },
              );
            },
          ),
          body: BlocBuilder<ConnectedBloc, ConnectedState>(
            builder: (BuildContext context, ConnectedState state) {
              if (state is ConnectedFailureState) {
                return const NoConnectionWidget();
              }

              return BlocConsumer<RestaurantDetailBloc, RestaurantDetailState>(
                listener: (BuildContext context, state) {
                  if (state.status == Status.success) {
                    _favoriteCubit.isFavoriteRestaurant(id: restaurantId);
                  }
                },
                builder: (BuildContext context, state) {
                  if (state.status == Status.success) {
                    final RestaurantDetail restaurantDetail =
                        state.restaurantDetail;

                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              _heroImage(restaurantDetail.pictureId),
                              _rating(restaurantDetail.rating.toString()),
                              _favoriteButton(restaurantDetail),
                            ],
                          ),
                          _metaData(
                              restaurantDetail.name, restaurantDetail.city),
                          SizedBox(
                            height: 50,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: restaurantDetail.categories.length,
                              itemBuilder: (BuildContext context, int index) {
                                final DynamicObject category =
                                    restaurantDetail.categories[index];

                                return _renderCategories(category.name);
                              },
                            ),
                          ),
                          _restaurantDescription(restaurantDetail.description),
                          Container(
                            margin: const EdgeInsets.only(left: 16, bottom: 16),
                            child: Text(
                              "Kata Mereka",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.4,
                                  ),
                            ),
                          ),
                          SizedBox(
                            height: 160,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  restaurantDetail.customerReviews.length,
                              itemBuilder: (BuildContext context, int index) {
                                final CustomerReview review =
                                    restaurantDetail.customerReviews[index];

                                return _renderReviews(review);
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 16, bottom: 16, top: 16),
                            child: Text(
                              "Menu Makanan",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.4,
                                  ),
                            ),
                          ),
                          SizedBox(
                            height: 120,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: restaurantDetail.menus.foods.length,
                              itemBuilder: (context, index) {
                                final DynamicObject food =
                                    restaurantDetail.menus.foods[index];
                                return FoodItem(
                                  rightMargin: index ==
                                          restaurantDetail.menus.foods.length -
                                              1
                                      ? 16
                                      : 0,
                                  name: food.name,
                                );
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 16, bottom: 16),
                            child: Column(
                              children: [
                                Text(
                                  "Menu Minuman",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.4,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 120,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: restaurantDetail.menus.drinks.length,
                              itemBuilder: (context, index) {
                                final DynamicObject drinks =
                                    restaurantDetail.menus.drinks[index];
                                return DrinkItem(
                                  rightMargin: index ==
                                          restaurantDetail.menus.drinks.length -
                                              1
                                      ? 16
                                      : 0,
                                  name: drinks.name,
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    );
                  } else if (state.status == Status.error) {
                    return Center(
                      child: Column(
                        children: [
                          Lottie.asset('assets/error.json'),
                          Text(state.errorMessage),
                        ],
                      ),
                    );
                  }

                  return const LoadingWidget();
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
