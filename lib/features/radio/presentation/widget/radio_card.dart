import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/constants/app_assets.dart';
import 'package:islami_app/core/theme/app_colors.dart';
import 'package:islami_app/core/theme/app_text_styles.dart';
import 'package:islami_app/features/radio/presentation/widget/card_button.dart';

class RadioCard extends StatelessWidget {
  const RadioCard({
    super.key,
    required this.title,
    required this.isPlaying,
    required this.isMuted,
    this.onPlayPause,
    this.onMute,
  });

  final String title;
  final bool isPlaying;
  final bool isMuted;
  final VoidCallback? onPlayPause;
  final VoidCallback? onMute;

  static const double _mosqueAspectRatio = 1080 / 279;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 390 / 140,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(20.r),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 6.h, left: 12.w, right: 12.w),
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: AppTextStyles.titleLarge.copyWith(
                  color: AppColors.black,
                  height: 1.2,
                ),
              ),
            ),
            const Spacer(),
            LayoutBuilder(
              builder: (context, constraints) {
                final imageHeight = constraints.maxWidth / _mosqueAspectRatio;

                return SizedBox(
                  width: double.infinity,
                  height: imageHeight,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Image.asset(
                          isPlaying
                              ? AppAssets.radioBars
                              : AppAssets.radioMosque,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CardButton(
                            icon: isPlaying ? Icons.pause : Icons.play_arrow,
                            color: AppColors.black.withValues(alpha: 0.87),
                            onTap: onPlayPause,
                          ),
                          SizedBox(width: 14.w),
                          CardButton(
                            icon: isMuted ? Icons.volume_off : Icons.volume_up,
                            color: AppColors.black.withValues(alpha: 0.54),
                            onTap: onMute,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
