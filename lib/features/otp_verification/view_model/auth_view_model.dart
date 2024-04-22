import 'package:yuktidea/core.dart';
import 'package:yuktidea/features/otp_verification/model/get_otp_model.dart';
import 'package:yuktidea/features/otp_verification/repository/auth_repository.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();
  ApiResponse<GetOtp> getOtp = ApiResponse.loading();
  String phone = "";
  String message = "";

  init() async {
    await _myRepo.initialiseUser();
  }

  setResponse(ApiResponse<GetOtp> response) {
    getOtp = response;
  }

  Future<void> getOtpFromServer(Map<String, String> formData) async {
    setResponse(ApiResponse.loading());
    var response = await _myRepo.getOtp(formData);
    response.fold((failure) {
      setResponse(ApiResponse.error(failure.message));
      Utils.flushBar(
        title: failure.title,
        message: failure.message,
        status: MessageStatus.Failure,
      );
    }, (data) async {
      setResponse(ApiResponse.completed(data));

      Navigator.pushNamed(
          navigatorKey.currentContext!, RoutesName.verifyOtpView,
          arguments: phone);
      Utils.flushBar(
        title: MessageStatus.Success.name,
        message: data.message,
        status: MessageStatus.Success,
      );
    });
    notifyListeners();
  }

  validateLogin(String? value) {
    message = "";

    if (value == null || value.isEmpty) {
      message = 'Enter mobile number';
    } else if (value.length < 10) {
      message = 'Mobile number must have 10 digits';
    } else if (value.length > 10) {
      message = 'Mobile number must have 10 digits';
    } else if (!Validator.validateMobile(value)) {
      message = 'Enter a valid mobile number';
    }
    if (message.isEmpty) {
      notifyListeners();
      return true;
    } else {
      notifyListeners();
      return false;
    }
  }
}
