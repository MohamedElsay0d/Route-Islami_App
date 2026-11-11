import 'package:flutter/material.dart';
import 'package:islami_app/app/app.dart';
import 'package:islami_app/core/services/sharedpreferences_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedpreferencesService.inti();
  runApp(const IslamiApp());
}
