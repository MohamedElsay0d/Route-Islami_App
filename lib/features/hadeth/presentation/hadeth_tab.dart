
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
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

  @override
  void initState() {
    super.initState();
    hadethList = _loadHadeth();
  }

  Future<List<HadethModel>> _loadHadeth() {
    return context.read<HadethRepo>().getAllHadeth();
  }

  void retry() {
    setState(() {
      hadethList = _loadHadeth();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<HadethModel>>(
      future: hadethList,
      builder: (context, snapshot) {

        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // Error
        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Something went wrong!'),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: retry,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final hadeths = snapshot.data ?? [];

        // Empty
        if (hadeths.isEmpty) {
          return const Center(
            child: Text('No Hadeth available'),
          );
        }

        // Data
        return CarouselSlider.builder(
          itemCount: hadeths.length,
          itemBuilder: (context, index, realIndex) {
            return HadethCard(
              hadeth: hadeths[index],
            );
          },
          options: CarouselOptions(
            height: MediaQuery.sizeOf(context).height * 0.8,
            viewportFraction: 0.8,
            enlargeCenterPage: true,
            enlargeFactor: 0.15,
            enableInfiniteScroll: true,
            autoPlay: false,
            initialPage: 0,
            scrollDirection: Axis.horizontal,
          ),
        );
      },
    );
  }
}
