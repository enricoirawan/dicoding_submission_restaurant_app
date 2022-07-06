import 'package:flutter/material.dart';
import 'package:submission_dicoding_app/route.dart';
import 'package:submission_dicoding_app/common/constant.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void moveToHomeScreen() async {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context)
            .pushReplacementNamed(RouteGenerator.baseScreenRoute);
      });
    }

    moveToHomeScreen();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Hero(
              tag: splashTag,
              child: Icon(
                Icons.restaurant_menu,
                size: 50,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "RESTAURANT APP",
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    letterSpacing: 5,
                    color: Colors.white,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
