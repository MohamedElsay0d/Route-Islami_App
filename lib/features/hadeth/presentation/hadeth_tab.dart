import 'package:flutter/material.dart';
import 'package:islami_app/features/hadeth/data/hadeth_repo.dart';
import 'package:islami_app/features/hadeth/model/hadeth_model.dart';
import 'package:islami_app/features/hadeth/presentation/widget/hadeth_card.dart';
import 'package:provider/provider.dart';

class HadethTab extends StatefulWidget {
  const HadethTab({super.key});

  @override
  State<HadethTab> createState() => _HadethTabState();
}

class _HadethTabState extends State<HadethTab> {
  late Future<List<HadethModel>> hadethList;
  late final _pageController;
  @override
  void initState() {
    super.initState();
    hadethList = _loadHadeth();
    _pageController = PageController(viewportFraction: 0.8);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void retry() {
    setState(() {
      hadethList = _loadHadeth();
    });
  }

  Future<List<HadethModel>> _loadHadeth() {
    return context.read<HadethRepo>().getAllHadeth();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<HadethModel>>(
      future: hadethList,
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Something went wrong!'),
                const SizedBox(height: 12),
                ElevatedButton(onPressed: retry, child: const Text('Retry')),
              ],
            ),
          );
        }

        final hadeths = snapshot.data ?? [];
        if (hadeths.isEmpty) {
          return const Center(child: Text('No Hadeth available'));
        }

        return PageView.builder(
          controller: _pageController,
          itemCount: hadeths.length,
          itemBuilder: (context, index) {
            final hadeth = hadeths[index];
            return HadethCard(hadeth: hadeth);
          },
        );
      }),
    );
  }
}
