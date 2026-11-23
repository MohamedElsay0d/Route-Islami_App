import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami_app/core/theme/app_colors.dart';
import 'package:islami_app/core/theme/app_text_styles.dart';
import 'package:islami_app/features/quran/model/sura_model.dart';
import 'package:islami_app/features/quran/presentation/quran_controller.dart';
import 'package:islami_app/features/radio/model/moshaf_model.dart';
import 'package:islami_app/features/radio/model/reciter_model.dart';
import 'package:provider/provider.dart';

typedef SurahSelection = ({MoshafModel moshaf, int surahNumber});

Future<SurahSelection?> showSurahPicker(
  BuildContext context, {
  required ReciterModel reciter,
  int? activeMoshafId,
  int? activeSurahNumber,
}) {
  return showModalBottomSheet<SurahSelection>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withValues(alpha: 0.6),
    builder: (context) => SurahPickerSheet(
      reciter: reciter,
      activeMoshafId: activeMoshafId,
      activeSurahNumber: activeSurahNumber,
    ),
  );
}

class SurahPickerSheet extends StatefulWidget {
  const SurahPickerSheet({
    super.key,
    required this.reciter,
    this.activeMoshafId,
    this.activeSurahNumber,
  });

  final ReciterModel reciter;
  final int? activeMoshafId;
  final int? activeSurahNumber;

  @override
  State<SurahPickerSheet> createState() => _SurahPickerSheetState();
}

class _SurahPickerSheetState extends State<SurahPickerSheet> {
  late MoshafModel _moshaf;

  List<MoshafModel> get _moshafs => widget.reciter.moshafModel;

  @override
  void initState() {
    super.initState();

    _moshaf = _moshafs.firstWhere(
      (moshaf) => moshaf.id == widget.activeMoshafId,
      orElse: () => _moshafs.first,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final surasByNumber = {
      for (final sura in context.watch<QuranController>().suras)
        sura.number: sura,
    };
    final isCurrentMoshaf = _moshaf.id == widget.activeMoshafId;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: mediaQuery.size.height * 0.78),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.darkSurface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10.h),
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.24),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 14.h, 8.w, 10.h),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.reciter.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.titleLarge.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'Choose a surah',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.white.withValues(alpha: 0.55),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close_rounded,
                      color: AppColors.white.withValues(alpha: 0.55),
                    ),
                  ),
                ],
              ),
            ),
            if (_moshafs.length > 1)
              SizedBox(
                height: 42.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  itemCount: _moshafs.length,
                  separatorBuilder: (context, index) => SizedBox(width: 8.w),
                  itemBuilder: (context, index) {
                    final moshaf = _moshafs[index];
                    final isSelected = moshaf.id == _moshaf.id;

                    return ChoiceChip(
                      label: Text(
                        moshaf.name,
                        maxLines: 1,
                        style: AppTextStyles.labelMedium.copyWith(
                          color: isSelected
                              ? AppColors.black
                              : AppColors.white.withValues(alpha: 0.75),
                        ),
                      ),
                      selected: isSelected,
                      onSelected: (_) => setState(() => _moshaf = moshaf),
                      showCheckmark: false,
                      backgroundColor:
                          AppColors.white.withValues(alpha: 0.06),
                      selectedColor: AppColors.primary,
                      side: BorderSide(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.white.withValues(alpha: 0.12),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      materialTapTargetSize:
                          MaterialTapTargetSize.shrinkWrap,
                    );
                  },
                ),
              ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              child: Divider(
                height: 1,
                color: AppColors.white.withValues(alpha: 0.08),
              ),
            ),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.only(
                  bottom: mediaQuery.padding.bottom + 10.h,
                ),
                itemCount: _moshaf.surahList.length,
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                  indent: 20.w,
                  endIndent: 20.w,
                  color: AppColors.white.withValues(alpha: 0.05),
                ),
                itemBuilder: (context, index) {
                  final surahNumber = _moshaf.surahList[index];
                  final sura = surasByNumber[surahNumber];
                  final isCurrent = isCurrentMoshaf &&
                      widget.activeSurahNumber == surahNumber;

                  return _SurahTile(
                    number: surahNumber,
                    sura: sura,
                    isCurrent: isCurrent,
                    onTap: () => Navigator.of(context).pop<SurahSelection>(
                      (moshaf: _moshaf, surahNumber: surahNumber),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SurahTile extends StatelessWidget {
  const _SurahTile({
    required this.number,
    required this.sura,
    required this.isCurrent,
    required this.onTap,
  });

  final int number;
  final SuraModel? sura;
  final bool isCurrent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final titleColor = isCurrent ? AppColors.primary : AppColors.white;

    return Material(
      color: isCurrent
          ? AppColors.primary.withValues(alpha: 0.10)
          : Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Row(
            children: [
              SizedBox(
                width: 34.w,
                child: Text(
                  number.toString().padLeft(2, '0'),
                  style: AppTextStyles.labelMedium.copyWith(
                    color: isCurrent
                        ? AppColors.primary
                        : AppColors.white.withValues(alpha: 0.35),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  sura?.englishName ?? 'Surah $number',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.titleSmall.copyWith(color: titleColor),
                ),
              ),
              if (sura != null) ...[
                SizedBox(width: 12.w),
                Text(
                  sura!.arabicName,
                  style: AppTextStyles.titleMedium.copyWith(
                    color: titleColor,
                  ),
                ),
              ],
              SizedBox(width: 10.w),
              Icon(
                isCurrent
                    ? Icons.graphic_eq_rounded
                    : Icons.play_arrow_rounded,
                color: isCurrent
                    ? AppColors.primary
                    : AppColors.white.withValues(alpha: 0.25),
                size: 20.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}