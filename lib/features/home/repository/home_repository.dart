import '../../../core.dart';

class HomeRepository {
  final BaseApiServices _apiServices = NetworkApiService();
  String? token;
  initialiseToken() async {
    final SharedPreferencesService prefs = SharedPreferencesService();
    token = (await prefs.getToken())!;
  }

  Future<dynamic> logout() async {
    return await _apiServices.callPostAPI(
      AppUrl.logout,
      {"Authorization": "Bearer $token"},
      Parser.parseLogoutResponse,
    );
  }

  Future<dynamic> deleteUser() async {
    return await _apiServices.callPostAPI(
      AppUrl.delete,
      {"Authorization": "Bearer $token"},
      Parser.parseDeleteUserResponse,
    );
  }
}
