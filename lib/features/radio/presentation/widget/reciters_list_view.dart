import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/theme/app_colors.dart';
import 'package:islami_app/features/radio/presentation/radio_controller.dart';
import 'package:islami_app/features/radio/presentation/widget/radio_list_item.dart';
import 'package:islami_app/features/radio/presentation/widget/radio_message_view.dart';
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

        return RadioListItem(
          title: reciter.name,
          subtitle: reciter.moshafModel.isEmpty ? null : reciter.moshafModel.first.name,
        );
      },
    );
  }
}