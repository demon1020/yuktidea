import '../../../core.dart';

class HomeRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> logout() async {
    return await _apiServices.callPostAPI(
      AppUrl.logout,
      {},
      Parser.parseLogoutResponse,
    );
  }

  Future<dynamic> deleteUser() async {
    return await _apiServices.callGetAPI(
      AppUrl.delete,
      {},
      Parser.parseDeleteUserResponse,
    );
  }
}
