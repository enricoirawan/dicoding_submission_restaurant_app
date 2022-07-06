import 'package:flutter/material.dart';
import 'package:submission_dicoding_app/common/constant.dart';
import 'package:submission_dicoding_app/data/model/restaurant.dart';
import 'package:submission_dicoding_app/route.dart';

class RecommendedRestaurantItem extends StatelessWidget {
  final int index;
  final Restaurant restaurant;
  final int total;

  const RecommendedRestaurantItem({
    Key? key,
    required this.index,
    required this.restaurant,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          RouteGenerator.detailScreenRoute,
          arguments: restaurant.id,
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          left: 16,
          right: index == total - 1 ? 16 : 0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            SizedBox(
              width: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  baseMediumImageUrl + restaurant.pictureId,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              left: 10,
              bottom: 10,
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Text(
                        restaurant.name,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.white,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    Row(
                      children: [
                        Text(
                          restaurant.rating.toString(),
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.white,
                                    letterSpacing: 1.2,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
