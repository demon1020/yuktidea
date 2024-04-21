import '../../../core.dart';

class CountryCodeSelectionRepository extends ChangeNotifier {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> fetchCountriesCode() async {
    return await _apiServices.callGetAPI(
      AppUrl.countriesCode,
      {},
      Parser.parseCountriesCodeResponse,
    );
  }
}
