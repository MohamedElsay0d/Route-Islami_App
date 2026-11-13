import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:islami_app/core/constants/app_assets.dart';

class HomeShell extends StatelessWidget {
  const HomeShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              '${AppAssets.homeTapBackground}/home_background${navigationShell.currentIndex + 1}.png',
              // 'assets/images/PNG/home_taps_background/home_background1.png',
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: navigationShell,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Quran'),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_stories),
            label: 'Hadeth',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.circle_outlined),
            label: 'Sebha',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.radio), label: 'Radio'),
          BottomNavigationBarItem(icon: Icon(Icons.access_time), label: 'Time'),
        ],
      ),
    );
  }
}
