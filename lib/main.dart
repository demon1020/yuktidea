// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart'; //add this
import 'package:yuktidea/utils/config/size_config.dart';

import '/core.dart';

void main() {
  runApp(
    MultiProvider(
      providers: Providers.getAllProviders(),
      child: MyApp(),
    ),
  );
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'MVVM',
//       theme: AppTheme.lightTheme,
//       darkTheme: AppTheme.darkTheme,
//       themeMode: ThemeMode.system,
//       initialRoute: RoutesName.wrapper,
//       onGenerateRoute: Routes.generateRoute,
//       navigatorKey: navigatorKey,
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig.init(constraints, orientation);
            return NeumorphicApp(
              debugShowCheckedModeBanner: false,
              title: 'Yuktidea',
              themeMode: ThemeMode.dark,
              theme: NeumorphicThemeData(
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
              ),
              darkTheme: NeumorphicThemeData(
                baseColor: AppColor.primaryDark,
                lightSource: LightSource.topLeft,
                depth: 6,
              ),
              initialRoute: RoutesName.startupView,
              onGenerateRoute: Routes.generateRoute,
              navigatorKey: navigatorKey,
            );
          },
        );
      },
    );
  }
}
