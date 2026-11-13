import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/app/router.dart';
import 'package:islami_app/core/theme/app_theme.dart';
import 'package:islami_app/features/quran/data/quran_repo.dart';
import 'package:islami_app/features/quran/data/recent_suras_repo.dart';
import 'package:islami_app/features/quran/presentation/quran_controller.dart';
import 'package:provider/provider.dart';

class IslamiApp extends StatelessWidget {
  const IslamiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => QuranController(QuranRepo(), RecentSurasRepo())..load(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        builder: (context, child) {
          return MaterialApp.router(
            title: "Islami",
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: ThemeMode.system,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
