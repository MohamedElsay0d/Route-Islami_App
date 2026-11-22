import 'package:flutter/material.dart';
import 'package:islami_app/features/hadeth/data/hadeth_repo.dart';
import 'package:islami_app/features/hadeth/model/hadeth_model.dart';
import 'package:provider/provider.dart';

class HadethTab extends StatefulWidget {
  const HadethTab({super.key});

  @override
  State<HadethTab> createState() => _HadethTabState();
}

class _HadethTabState extends State<HadethTab> {
  late Future<List<HadethModel>> hadethList;
  @override
  void initState() {
    super.initState();
    hadethList = _loadHadeth();
  }

  Future<List<HadethModel>> _loadHadeth() {
    return context.read<HadethRepo>().getAllHadeth();
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Hadeth Tab"));
  }
}
