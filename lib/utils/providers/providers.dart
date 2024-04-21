import 'package:yuktidea/features/country_selection/view_model/country_selection_view_model.dart';
import 'package:yuktidea/features/home/view_model/home_view_model.dart';
import 'package:yuktidea/features/otp_verification/view_model/auth_view_model.dart';
import 'package:yuktidea/features/otp_verification/view_model/country_code_selection_view_model.dart';
import 'package:yuktidea/features/otp_verification/view_model/verify_otp_view_model.dart';
import 'package:yuktidea/features/startup/view_model/term_condition_view_model.dart';

import '/core.dart';

class Providers {
  static List<SingleChildWidget> getAllProviders() {
    List<SingleChildWidget> _providers = [
      ChangeNotifierProvider(create: (context) => TermConditionViewModel()),
      ChangeNotifierProvider(
          create: (context) => CountryCodeSelectionViewModel()),
      ChangeNotifierProvider(create: (context) => AuthViewModel()),
      ChangeNotifierProvider(create: (context) => CountrySelectionViewModel()),
      ChangeNotifierProvider(create: (context) => HomeViewModel()),
      ChangeNotifierProvider(create: (context) => VerifyOtpViewModel()),
    ];
    return _providers;
  }
}
