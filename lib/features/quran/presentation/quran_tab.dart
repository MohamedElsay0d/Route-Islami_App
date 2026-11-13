import 'package:flutter/material.dart';
import 'package:islami_app/core/widgets/search_field.dart';
import 'package:islami_app/features/quran/presentation/quran_controller.dart';
import 'package:islami_app/features/quran/presentation/widgets/most_recent_section.dart';
import 'package:islami_app/features/quran/presentation/widgets/sura_item.dart';
import 'package:provider/provider.dart';

class QuranTab extends StatelessWidget {
  const QuranTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<QuranController>();
    final suras = controller.filteredSuras;

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: SearchField(onChange: controller.search),
          ),
          if (controller.isLoading)
            const Expanded(child: Center(child: CircularProgressIndicator()))
          else if (controller.error != null)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(controller.error!),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: controller.load,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            )
          else ...[
            if (controller.recentSuras.isNotEmpty)
              MostRecentSection(
                suras: controller.recentSuras,
                onTap: controller.addToRecent,
                onLongPress: controller.removeRecent,
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  'Sura List',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            Expanded(
              child: suras.isEmpty
                  ? const Center(child: Text('No Sura found'))
                  : ListView.separated(
                      padding: const EdgeInsets.only(bottom: 16),
                      itemCount: suras.length,
                      separatorBuilder: (context, index) =>
                          const Divider(indent: 84, endIndent: 16),
                      itemBuilder: (context, index) {
                        final sura = suras[index];

                        return SuraItem(
                          sura: sura,
                          onTap: () => controller.addToRecent(sura),
                        );
                      },
                    ),
            ),
          ],
        ],
      ),
    );
  }
}
