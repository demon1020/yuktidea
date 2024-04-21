import 'package:yuktidea/core.dart';
import 'package:yuktidea/features/otp_verification/model/verify_otp_model.dart';
import 'package:yuktidea/features/otp_verification/repository/otp_verification_repository.dart';

import '../../../data/service/shared_preference_service.dart';

class VerifyOtpViewModel extends ChangeNotifier {
  final _myRepo = OtpVerificationRepository();
  ApiResponse<VerifyOtp> verifyOtp = ApiResponse.loading();
  String phone = "";
  String message = "";

  setResponse(ApiResponse<VerifyOtp> response) {
    verifyOtp = response;
  }

  Future<void> verifyOtpFromServer(Map<String, String> formData) async {
    setResponse(ApiResponse.loading());
    var response = await _myRepo.verifyOtp(formData);
    response.fold((failure) {
      setResponse(ApiResponse.error(failure.message));
      Utils.toastMessage(failure.message);
    }, (data) async {
      setResponse(ApiResponse.completed(data));
      Utils.toastMessage(data.message);
      await saveToken(data.data.accessToken);
      Navigator.pushNamed(
          navigatorKey.currentContext!, RoutesName.countrySelectionView);
    });
    notifyListeners();
  }

  saveToken(String token) async {
    final SharedPreferencesService prefs = SharedPreferencesService();
    await prefs.saveToken(token);
  }

  validateLogin(String? value) {
    message = "";

    if (value == null || value.isEmpty) {
      return message = 'Enter mobile number';
    }
    if (value.length < 10) {
      return message = 'Mobile number must have 10 digits';
    }
    if (value.length > 10) {
      return message = 'Mobile number must have 10 digits';
    }
    if (!Validator.validateMobile(value)) {
      return message = 'Enter a valid mobile number';
    }
    notifyListeners();
    return message = "";
  }
}
