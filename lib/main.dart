// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '/core.dart';

void main() {
  runApp(
    MultiProvider(
      providers: Providers.getAllProviders(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
              darkTheme: AppTheme.getDarkTheme(),
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
