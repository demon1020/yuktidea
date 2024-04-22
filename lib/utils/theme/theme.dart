import '../../core.dart';

class AppTheme {
  static NeumorphicThemeData getLightTheme() {
    return NeumorphicThemeData(
      baseColor: AppColor.primaryLight,
      lightSource: LightSource.topLeft,
      depth: 10,
      textTheme: TextTheme(
        bodyLarge: TextStyle(
          color: Colors.black,
        ),
        bodySmall: TextStyle(
          color: Colors.black,
        ),
        bodyMedium: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  static NeumorphicThemeData getDarkTheme() {
    return NeumorphicThemeData(
      baseColor: AppColor.primaryDark,
      lightSource: LightSource.bottom,
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
