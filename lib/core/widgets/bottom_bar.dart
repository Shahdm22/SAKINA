import 'package:sakina/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina/pages/explore.dart';
import 'package:sakina/pages/favourite.dart';
import 'package:sakina/pages/home.dart';
import 'package:sakina/pages/messages.dart';
import 'package:sakina/features/home/bloc/home_bloc.dart';

class ButtomNavBarScreen extends StatefulWidget {
  final int initialIndex;
  const ButtomNavBarScreen({super.key, this.initialIndex = 0});

  @override
  State<ButtomNavBarScreen> createState() => _ButtomNavBarScreenState();
}

class _ButtomNavBarScreenState extends State<ButtomNavBarScreen> {
  late int activeindex = 0;

  @override
  void initState() {
    super.initState();
    activeindex = widget.initialIndex;
  }

  List<Widget> screens = [
    BlocProvider(
      create: (context) => HomeBloc(),
      child: const HomePage(),
    ),
    const ExplorePage(),
    const FavouritePage(),
    const MessagesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: activeindex,
        onTap: (index) {
          setState(() {
            activeindex = index;
          });
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SafeArea(child: screens[activeindex]),
      ),
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      decoration: const BoxDecoration(
        color: AppColors.bottomNavigationBarColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: BottomNavigationBar(
        backgroundColor: AppColors.bottomNavigationBarColor,
        elevation: 0,
        unselectedItemColor: Colors.grey,
        currentIndex: currentIndex,
        onTap: onTap,
        selectedItemColor: AppColors.themeColor,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
                color: currentIndex == 0 ? AppColors.themeColor : Colors.grey),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.explore,
              color: currentIndex == 1 ? AppColors.themeColor : Colors.grey,
            ),
            label: "Explore",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: currentIndex == 2 ? AppColors.themeColor : Colors.grey,
            ),
            label: "Favourites",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message,
              color: currentIndex == 3 ? AppColors.themeColor : Colors.grey,
            ),
            label: "Messages",
          ),
        ],
      ),
    );
  }
}
