import 'package:flutter/material.dart';
import 'package:submission_dicoding_app/ui/favorite.dart';
import 'package:submission_dicoding_app/ui/home.dart';
import 'package:submission_dicoding_app/common/styles.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedPage = 0;

  Widget _customBottomNav() {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 10,
            blurRadius: 5,
            offset: const Offset(0, 7), // changes position of shadow
          ),
        ],
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                _selectedPage = 0;
              });
            },
            icon: _selectedPage == 0
                ? const Icon(
                    Icons.home_filled,
                    color: primaryColor,
                    size: 30,
                  )
                : const Icon(
                    Icons.home_outlined,
                    color: Colors.grey,
                    size: 30,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                _selectedPage = 1;
              });
            },
            icon: _selectedPage == 1
                ? const Icon(
                    Icons.favorite,
                    color: primaryColor,
                    size: 30,
                  )
                : const Icon(
                    Icons.favorite_outline,
                    color: Colors.grey,
                    size: 30,
                  ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: _selectedPage == 0 ? const HomeScreen() : const FavoriteScreen(),
      bottomNavigationBar: _customBottomNav(),
    );
  }
}
