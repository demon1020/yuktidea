import 'package:yuktidea/core.dart';
import 'package:yuktidea/features/otp_verification/model/verify_otp_model.dart';
import 'package:yuktidea/features/otp_verification/repository/otp_verification_repository.dart';

import '../../../data/service/shared_preference_service.dart';
import '../../../utils/helper/timer_helper.dart';
import '../model/get_otp_model.dart';

class VerifyOtpViewModel with ChangeNotifier {
  final _myRepo = OtpVerificationRepository();
  ApiResponse<VerifyOtp> verifyOtp = ApiResponse.loading();
  ApiResponse<GetOtp> resendOtpResponse = ApiResponse.loading();
  final TimerHelper _timerService = TimerHelper();

  String phone = "";
  String message = "";
  int timerDuration = 0;
  late bool timerActive = false;

  setMessage(String value) {
    message = value;
    notifyListeners();
  }

  setVerifyOtpResponse(ApiResponse<VerifyOtp> response) {
    verifyOtp = response;
  }

  setResendOtpResponse(ApiResponse<GetOtp> response) {
    resendOtpResponse = response;
  }

  Future<void> verifyOtpFromServer(Map<String, String> formData) async {
    message = "";
    setVerifyOtpResponse(ApiResponse.loading());
    var response = await _myRepo.verifyOtp(formData);
    response.fold((failure) {
      setVerifyOtpResponse(ApiResponse.error(failure.message));
      message = failure.message;
      notifyListeners();
    }, (data) async {
      message = "";
      setVerifyOtpResponse(ApiResponse.completed(data));
      stopTimer();
      await saveToken(data.data.accessToken);
      Navigator.pushNamed(
          navigatorKey.currentContext!, RoutesName.countrySelectionView);
      Utils.flushBar(
        message: data.message,
        title: MessageStatus.Success.name,
        status: MessageStatus.Success,
      );
    });
    notifyListeners();
  }

  Future<void> resendOtpFromServer(Map<String, String> formData) async {
    setResendOtpResponse(ApiResponse.loading());
    var response = await _myRepo.resendOtp(formData);
    response.fold((failure) {
      setResendOtpResponse(ApiResponse.error(failure.message));
      Utils.flushBar(
        title: failure.title,
        message: failure.message,
        status: MessageStatus.Failure,
      );
    }, (data) async {
      setResendOtpResponse(ApiResponse.completed(data));
      startTimer();
      Utils.flushBar(
        title: MessageStatus.Success.name,
        message: data.message,
        status: MessageStatus.Success,
      );
    });
    notifyListeners();
  }

  startTimer() {
    timerActive = true;
    _timerService.startTimer(Duration(seconds: 30), (time) {
      timerDuration = time;
      notifyListeners();
    });
  }

  stopTimer() {
    if (timerActive) {
      _timerService.cancelTimer();
    }
    timerDuration = 0;
    notifyListeners();
  }

  saveToken(String token) async {
    final SharedPreferencesService prefs = SharedPreferencesService();
    await prefs.saveToken(token);
  }
}
