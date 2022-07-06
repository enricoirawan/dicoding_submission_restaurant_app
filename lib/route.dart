import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:submission_dicoding_app/ui/add_review.dart';
import 'package:submission_dicoding_app/ui/base.dart';
import 'package:submission_dicoding_app/ui/detail.dart';
import 'package:submission_dicoding_app/ui/search.dart';
import 'package:submission_dicoding_app/ui/setting.dart';
import 'package:submission_dicoding_app/ui/splash.dart';

class RouteGenerator {
  static const String splashScreenRoute = "/";
  static const String baseScreenRoute = "/base";
  static const String homeScreenRoute = "/home";
  static const String detailScreenRoute = "/detail";
  static const String favoriteScreenRoute = "/favorite";
  static const String searchScreenRoute = "/search";
  static const String addReviewScreenRoute = "/addReview";
  static const String settingScreenRoute = "/setting";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case splashScreenRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case baseScreenRoute:
        return MaterialPageRoute(
          builder: (_) => const BaseScreen(),
        );
      case detailScreenRoute:
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => DetailScreen(
              restaurantId: args,
            ),
          );
        }
        return _errorRoute();
      case searchScreenRoute:
        return MaterialPageRoute(
          builder: (_) => const SearchScreen(),
        );
      case addReviewScreenRoute:
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => AddReview(
              id: args,
            ),
          );
        }
        return _errorRoute();
      case settingScreenRoute:
        return MaterialPageRoute(
          builder: (_) => const SettingScreen(),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/404-not-found.json', fit: BoxFit.contain),
              const Text(
                'Oops, tidak ada apa-apa disini...',
                style: TextStyle(
                  fontSize: 21,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
