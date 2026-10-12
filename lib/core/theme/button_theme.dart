part of 'main_theme.dart';

final _elevatedButtonThemeData = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: AppColors.mainColor,
    disabledBackgroundColor: AppColors.charcoal200,
    disabledForegroundColor: AppColors.charcoal500,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    textStyle: _textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
  ),
);

final _filledButtonThemeData = FilledButtonThemeData(
  style: FilledButton.styleFrom(
    backgroundColor: AppColors.mainColor,
    foregroundColor: Colors.white,
    disabledBackgroundColor: AppColors.charcoal200,
    disabledForegroundColor: AppColors.charcoal500,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    textStyle: _textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
  ),
);

final _textButtonThemeData = TextButtonThemeData(
  style: TextButton.styleFrom(
    backgroundColor: Colors.transparent,
    foregroundColor: AppColors.mainColor,
    disabledForegroundColor: AppColors.charcoal500,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    textStyle: _textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
  ),
);

final _outlineButtonThemeData = OutlinedButtonThemeData(
  style: OutlinedButton.styleFrom(
    backgroundColor: Colors.transparent,
    foregroundColor: AppColors.mainColor,
    disabledForegroundColor: AppColors.charcoal500,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    side: const BorderSide(width: 1, color: AppColors.mainColor),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    textStyle: _textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
  ),
);
