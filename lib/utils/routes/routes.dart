import 'package:yuktidea/features/home/view/home_view.dart';
import 'package:yuktidea/features/otp_verification/model/country_code_model.dart';
import 'package:yuktidea/features/otp_verification/view/country_code_selection_view.dart';
import 'package:yuktidea/features/otp_verification/view/verify_otp_view.dart';
import 'package:yuktidea/features/startup/view/startup_view.dart';

import '../../features/country_selection/view/country_selection_view.dart';
import '../../features/otp_verification/view/auth_view.dart';
import '../../features/startup/view/terms_condition.dart';
import '/core.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.startupView:
        return MaterialPageRoute(
          builder: (BuildContext context) => StartupView(),
        );

      case RoutesName.termsConditionView:
        return MaterialPageRoute(
          builder: (BuildContext context) => const TermsConditionView(),
        );

      case RoutesName.countryCodeSelectionView:
        return MaterialPageRoute(
          builder: (BuildContext context) => CountryCodeSelectionView(),
        );

      case RoutesName.authView:
        return MaterialPageRoute(
          builder: (BuildContext context) =>
              AuthView(country: settings.arguments as CountryData),
        );

      case RoutesName.verifyOtpView:
        return MaterialPageRoute(
          builder: (BuildContext context) =>
              VerifyOtpView(phone: settings.arguments as String),
        );

      case RoutesName.countrySelectionView:
        return MaterialPageRoute(
          builder: (BuildContext context) => CountrySelectionView(),
        );

      case RoutesName.homeView:
        return MaterialPageRoute(
          builder: (BuildContext context) => HomeView(),
        );

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}
