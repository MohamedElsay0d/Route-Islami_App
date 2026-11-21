import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:islami_app/core/constants/app_assets.dart';

class HomeShell extends StatelessWidget {
  const HomeShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              '${AppAssets.homeTapBackground}/home_background${navigationShell.currentIndex + 1}.png',
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            right: 5.w,
            top: 25.h,
            left: 5.w,
            bottom: 2.h,
          ),
          child: Column(
            children: [
              Image.asset(
                AppAssets.header,
                height: MediaQuery.of(context).size.height * 0.18,
              ),
              Expanded(child: navigationShell),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.closedBookSVG,
              width: 27.w,
              height: 27.h,
            ),
            label: 'Quran',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.openBookSVG,
              width: 27.w,
              height: 27.h,
            ),
            label: 'Hadeth',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.sebhaSVG,
              width: 27.w,
              height: 27.h,
            ),
            label: 'Sebha',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.radioSVG,
              width: 27.w,
              height: 27.h,
            ),
            label: 'Radio',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.waveSVG,
              width: 20.w,
              height: 20.h,
            ),
            label: 'Time',
          ),
        ],
      ),
    );
  }
}
