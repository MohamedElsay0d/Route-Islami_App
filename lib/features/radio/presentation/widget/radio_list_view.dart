import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/theme/app_colors.dart';
import 'package:islami_app/features/radio/presentation/radio_controller.dart';
import 'package:islami_app/features/radio/presentation/widget/radio_card.dart';
import 'package:islami_app/features/radio/presentation/widget/radio_message_view.dart';
import 'package:provider/provider.dart';

class RadioListView extends StatelessWidget {
  const RadioListView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<RadioController>();
    if (controller.isLoadingRadios) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }
    if (controller.radiosError != null) {
      return RadioMessageView(
        icon: Icons.error_outline,
        message: controller.radiosError!,
        actionLabel: 'Retry',
        onAction: controller.loadRadios,
      );
    }
    if (controller.radios.isEmpty) {
      return const RadioMessageView(
        icon: Icons.radio,
        message: 'No radios found',
      );
    }
    return ListView.separated(
      padding: EdgeInsets.only(bottom: 16.h),
      itemCount: controller.radios.length,
      separatorBuilder: (context, index) => SizedBox(height: 10.h),
      itemBuilder: (context, index) {
        final radio = controller.radios[index];
        final isActive = controller.activeRadioId == radio.id;

        return RadioCard(
          title: radio.name,
          isPlaying: isActive && controller.isPlaying,
          isMuted: isActive && controller.isMuted,
          onPlayPause: () async {
            final error = await controller.toggleRadio(radio);

            if (error != null && context.mounted) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(error)));
            }
          },
          onMute: controller.toggleMute,
        );
      },
    );
  }
}
