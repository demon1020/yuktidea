import '../../core.dart';

class AppTheme {
  static NeumorphicThemeData getLightTheme() {
    return NeumorphicThemeData(
      baseColor: AppColor.primaryLight,
      lightSource: LightSource.bottom,
      depth: 1,
      intensity: 0.85,
    );
  }

  static NeumorphicThemeData getDarkTheme() {
    return NeumorphicThemeData(
      baseColor: AppColor.primaryDark,
      lightSource: LightSource.topLeft,
      depth: 1,
      intensity: 0.85,
      shadowLightColor: Colors.grey.withOpacity(0.5),
      appBarTheme: NeumorphicAppBarThemeData(
        iconTheme: IconThemeData(
          color: AppColor.white,
        ),
      ),
    );
  }
}
