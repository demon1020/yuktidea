// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '/core.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

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
    var style = SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: AppColor.primaryDark,
      statusBarColor: AppColor.primaryDark,
    );
    SystemChrome.setSystemUIOverlayStyle(style);

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
