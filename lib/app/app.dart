import 'package:flutter/material.dart';
import 'package:islami_app/core/theme/app_theme.dart';
import 'package:islami_app/themePreviewScreen.dart';

class IslamiApp extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Islami',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark, // TODO: change mode to system
      home: ThemePreviewScreen() ,
    );
  }
}