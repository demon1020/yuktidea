import '../../../core.dart';

class AuthRepository extends ChangeNotifier {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> getOtp(Map<String, String> formData) async {
    return await _apiServices.callPostAPIForm(
      AppUrl.studentLogin,
      {},
      Parser.parseGetOtpResponse,
      body: formData,
    );
  }
}
