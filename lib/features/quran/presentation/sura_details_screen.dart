import 'package:flutter/material.dart';

class SuraDetailsScreen extends StatelessWidget {
  const SuraDetailsScreen({super.key, required this.suraNumber});
  final int suraNumber;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('$suraNumber')));
  }
}
