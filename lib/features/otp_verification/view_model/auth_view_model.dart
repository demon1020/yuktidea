import 'package:yuktidea/core.dart';
import 'package:yuktidea/features/otp_verification/model/get_otp_model.dart';
import 'package:yuktidea/features/otp_verification/repository/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final _myRepo = AuthRepository();
  ApiResponse<GetOtp> getOtp = ApiResponse.loading();
  String phone = "";
  String message = "";

  setResponse(ApiResponse<GetOtp> response) {
    getOtp = response;
  }

  Future<void> getOtpFromServer(Map<String, String> formData) async {
    setResponse(ApiResponse.loading());
    var response = await _myRepo.getOtp(formData);
    response.fold((failure) {
      setResponse(ApiResponse.error(failure.message));
      Utils.toastMessage(failure.message);
    }, (data) async {
      setResponse(ApiResponse.completed(data));
      Utils.toastMessage(data.message);
      Navigator.pushNamed(
          navigatorKey.currentContext!, RoutesName.verifyOtpView);
    });
    notifyListeners();
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
