import '../../../core.dart';
import '../../../data/service/shared_preference_service.dart';

class AuthRepository extends ChangeNotifier {
  UserType userType = UserType.student;
  final BaseApiServices _apiServices = NetworkApiService();

  initialiseUser() async {
    final SharedPreferencesService prefs = SharedPreferencesService();
    int? user = await prefs.getUser();
    if (user == 0) {
      userType = UserType.student;
    } else {
      userType = UserType.counsellor;
    }
  }

  Future<dynamic> getOtp(Map<String, String> formData) async {
    return await _apiServices.callPostAPIForm(
      userType == UserType.student
          ? AppUrl.studentLogin
          : AppUrl.counsellorLogin,
      {},
      Parser.parseGetOtpResponse,
      body: formData,
    );
  }
}
