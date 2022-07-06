import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:submission_dicoding_app/bloc/connected_bloc/connected_bloc.dart';
import 'package:submission_dicoding_app/bloc/restaurant/restaurant_bloc.dart';
import 'package:submission_dicoding_app/common/status.dart';
import 'package:submission_dicoding_app/data/model/restaurant.dart';
import 'package:submission_dicoding_app/injection.dart';
import 'package:submission_dicoding_app/widgets/custom_error_widget.dart';
import 'package:submission_dicoding_app/widgets/loading_widget.dart';
import 'package:submission_dicoding_app/widgets/no_connection.dart';
import 'package:submission_dicoding_app/widgets/popular_restaurant_item.dart';

import '../route.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final RestaurantBloc _restaurantBloc = getIt<RestaurantBloc>();
  final TextEditingController _searchController = TextEditingController();
  late FocusNode _searchNode = FocusNode();

  void _onSubmitted(_) {
    _restaurantBloc.add(SearchRestaurant(query: _searchController.text));
  }

  void _onEditingComplete() {
    _restaurantBloc.add(SearchRestaurant(query: _searchController.text));
  }

  @override
  void initState() {
    _searchNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _searchNode.dispose();
    super.dispose();
  }

  Widget _searchBar() {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            spreadRadius: 0.0,
            blurRadius: 6,
            offset: const Offset(3.0, 3.0),
          ),
          BoxShadow(
            color: Colors.grey.shade400,
            spreadRadius: 0.0,
            blurRadius: 6 / 2.0,
            offset: const Offset(3.0, 3.0),
          ),
          const BoxShadow(
            color: Colors.white,
            spreadRadius: 2.0,
            blurRadius: 6,
            offset: Offset(-3.0, -3.0),
          ),
          const BoxShadow(
            color: Colors.white,
            spreadRadius: 2.0,
            blurRadius: 6 / 2,
            offset: Offset(-3.0, -3.0),
          ),
        ],
      ),
      child: TextField(
        autofocus: true,
        controller: _searchController,
        onSubmitted: _onSubmitted,
        onEditingComplete: _onEditingComplete,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none,
          ),
          hintText: "Search...",
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<ConnectedBloc, ConnectedState>(
          builder: (BuildContext context, ConnectedState state) {
            if (state is ConnectedFailureState) {
              return const NoConnectionWidget();
            }

            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    _searchBar(),
                    BlocBuilder<RestaurantBloc, RestaurantState>(
                      builder: (BuildContext context, RestaurantState state) {
                        if (state.status == Status.success) {
                          final List<Restaurant> restaurants =
                              state.restaurants;

                          return restaurants.isEmpty
                              ? Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  child: const Center(
                                    child: Text(
                                      "Restoran yang kamu cari gak ketemu, coba cari yang lain...",
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height - 100,
                                  child: ListView.builder(
                                    itemCount: restaurants.length,
                                    itemBuilder: (
                                      BuildContext context,
                                      int index,
                                    ) {
                                      return PopularRestaurantItem(
                                        restaurant: restaurants[index],
                                        callback: () {
                                          Navigator.of(context).pushNamed(
                                            RouteGenerator.detailScreenRoute,
                                            arguments: restaurants[index].id,
                                          );
                                        },
                                      );
                                    },
                                  ),
                                );
                        } else if (state.status == Status.error) {
                          return CustomErrorWidget(
                              errorMessage: state.errorMessage);
                        } else if (state.status == Status.initial) {
                          return Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: const Center(
                              child: Text("Yuk mulai cari restaurant..."),
                            ),
                          );
                        }
                        return const LoadingWidget();
                      },
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
