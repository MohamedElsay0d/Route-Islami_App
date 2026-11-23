import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/constants/app_assets.dart';

class SebhaTab extends StatefulWidget {
  const SebhaTab({super.key});

  @override
  State<SebhaTab> createState() => _SebhaTabState();
}

class _SebhaTabState extends State<SebhaTab> {
  int counter = 0;
  int zekrindex = 0;
  double rotationAngle = 0.0;
  final List<String> azkar = [
    'سُبْحَانَ اللهِ',
    'الحَمْدُ للهِ',
    'اللهُ أَكْبَر',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'سَبِّحِ اسْمَ رَبِّكَ الأعلى ',
          style: TextStyle(
            fontFamily: 'JannaLT',
            fontSize: 36.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        GestureDetector(
          onTap: () {
            counter++;
            if (counter % 33 == 0) {
              zekrindex = (zekrindex + 1) % azkar.length;
              counter = 0;
            }
            rotationAngle += pi / 15;
            setState(() {});
          },
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: -75.h,
                child: Padding(
                  padding: EdgeInsets.only(left: 58.w),
                  child: Image.asset(AppAssets.sebhaHead),
                ),
              ),
              AnimatedRotation(
                turns: rotationAngle / (2 * pi),
                duration: const Duration(milliseconds: 300),
                child: Image.asset(
                  AppAssets.sebhaBody,
                  width: 379.w,
                  height: 381.h,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    azkar[zekrindex],
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontFamily: 'JannaLT',
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    '$counter',
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontFamily: 'JannaLT',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}