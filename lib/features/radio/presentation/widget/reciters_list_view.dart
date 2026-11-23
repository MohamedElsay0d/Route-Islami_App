import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/theme/app_colors.dart';
import 'package:islami_app/features/radio/model/reciter_model.dart';
import 'package:islami_app/features/radio/presentation/radio_controller.dart';
import 'package:islami_app/features/radio/presentation/widget/radio_card.dart';
import 'package:islami_app/features/radio/presentation/widget/radio_message_view.dart';
import 'package:islami_app/features/radio/presentation/widget/surah_picker_sheet.dart';
import 'package:provider/provider.dart';

class RecitersListView extends StatelessWidget {
  const RecitersListView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<RadioController>();

    if (controller.isLoadingReciters) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }

    if (controller.recitersError != null) {
      return RadioMessageView(
        icon: Icons.error_outline,
        message: controller.recitersError!,
        actionLabel: 'Retry',
        onAction: controller.loadReciters,
      );
    }

    if (controller.reciters.isEmpty) {
      return const RadioMessageView(
        icon: Icons.mic_none,
        message: 'No reciters found',
      );
    }

    return ListView.separated(
      padding: EdgeInsets.only(bottom: 16.h),
      itemCount: controller.reciters.length,
      separatorBuilder: (context, index) => SizedBox(height: 10.h),
      itemBuilder: (context, index) {
        final reciter = controller.reciters[index];
        final isActive = controller.activeReciterId == reciter.id;

        return RadioCard(
          title: reciter.name,
          isPlaying: isActive && controller.isPlaying,
          isMuted: isActive && controller.isMuted,
          onPlayPause: () async {
            if (isActive) {
              await controller.togglePlayback();
              return;
            }

            await _pickAndPlay(context, controller, reciter);
          },
          onMute: controller.toggleMute,
        );
      },
    );
  }

  Future<void> _pickAndPlay(
    BuildContext context,
    RadioController controller,
    ReciterModel reciter,
  ) async {
    if (reciter.moshafModel.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No surahs available for this reciter.'),
        ),
      );
      return;
    }

    final selection = await showSurahPicker(
      context,
      reciter: reciter,
      activeMoshafId: controller.activeMoshafId,
      activeSurahNumber: controller.activeSurahNumber,
    );

    if (selection == null || !context.mounted) return;

    final error = await controller.playSurah(
      reciter: reciter,
      moshaf: selection.moshaf,
      surahNumber: selection.surahNumber,
    );

    if (error != null && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
    }
  }
}