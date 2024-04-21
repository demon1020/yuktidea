import '../../../data/network/base_api_services.dart';
import '../../../data/network/network_api_service.dart';
import '../../../data/response/api_response.dart';
import '../../../data/service/shared_preference_service.dart';
import '../../../resources/app_url.dart';

class CountrySelectionRepository {
  String? token;
  final BaseApiServices _apiServices = NetworkApiService();

  initialiseToken() async {
    final SharedPreferencesService prefs = SharedPreferencesService();
    token = (await prefs.getToken())!;
  }

  Future<dynamic> fetchCountries() async {
    return await _apiServices.callGetAPI(
      AppUrl.selectCountry,
      {"Authorization": "Bearer $token"},
      Parser.parseSelectCountryResponse,
    );
  }

  Future<dynamic> selectCountry(Map<String, String> formData) async {
    return await _apiServices.callPostAPI(
      AppUrl.selectCountry,
      {"Authorization": "Bearer $token"},
      Parser.parseSelectedCountryResponse,
      body: formData,
    );
  }
}
