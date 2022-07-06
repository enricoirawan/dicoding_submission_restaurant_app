import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoConnectionWidget extends StatelessWidget {
  const NoConnectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LottieBuilder.asset('assets/no-connection.json'),
    );
  }
}
