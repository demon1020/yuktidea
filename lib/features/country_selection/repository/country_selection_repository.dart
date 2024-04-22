import '../../../core.dart';

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
