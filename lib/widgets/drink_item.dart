import 'package:flutter/material.dart';

class DrinkItem extends StatelessWidget {
  final double rightMargin;
  final String name;

  const DrinkItem({Key? key, required this.rightMargin, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: EdgeInsets.only(
        bottom: 16,
        left: 16,
        right: rightMargin,
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset("assets/drink.png"),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Container(
              width: 130,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                name,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
