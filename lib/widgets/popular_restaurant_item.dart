import 'package:flutter/material.dart';
import 'package:submission_dicoding_app/common/constant.dart';
import 'package:submission_dicoding_app/data/model/restaurant.dart';

class PopularRestaurantItem extends StatelessWidget {
  final Restaurant restaurant;
  final VoidCallback callback;

  const PopularRestaurantItem({
    Key? key,
    required this.restaurant,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: callback,
      child: Container(
        padding: EdgeInsets.all(width <= 320 ? 8 : 10),
        margin: EdgeInsets.symmetric(
          horizontal: width <= 320 ? 8 : 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  baseMediumImageUrl + restaurant.pictureId,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 150,
                  child: Text(
                    restaurant.name,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          letterSpacing: 1.2,
                          fontSize: width <= 320 ? 14 : 18,
                          overflow: TextOverflow.ellipsis,
                        ),
                    maxLines: 3,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.pin_drop,
                      size: width <= 320 ? 12 : 16,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(restaurant.city),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      size: 16,
                      color: Colors.yellow,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      restaurant.rating.toString(),
                      style: TextStyle(
                        fontSize: width <= 320 ? 10 : 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
