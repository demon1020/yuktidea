import '../../../core.dart';

class OtpVerificationRepository extends ChangeNotifier {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> verifyOtp(Map<String, String> formData) async {
    return await _apiServices.callPostAPIForm(
      AppUrl.verifyOtp,
      {},
      Parser.parseVerifyOtpResponse,
      body: formData,
    );
  }

  Future<dynamic> resendOtp(Map<String, String> formData) async {
    return await _apiServices.callPostAPIForm(
      AppUrl.resendOtp,
      {},
      Parser.parseGetOtpResponse,
      body: formData,
    );
  }
}
