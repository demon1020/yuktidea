import 'package:yuktidea/core.dart';

import '../model/country.dart';
import '../model/selected_country.dart';
import '../repository/country_selection_repository.dart';

class CountrySelectionViewModel with ChangeNotifier {
  late final _myRepo = CountrySelectionRepository();
  ApiResponse<SelectCountry> selectCountry = ApiResponse.loading();
  ApiResponse<SelectedCountry> selectedCountry = ApiResponse.loading();
  Country? country;

  init() async {
    await _myRepo.initialiseToken();
    await fetchCountries();
  }

  getToken() async {
    final SharedPreferencesService prefs = SharedPreferencesService();
    return await prefs.getToken();
  }

  setResponse(ApiResponse<SelectCountry> response) {
    selectCountry = response;
  }

  setSelectCountryResponse(ApiResponse<SelectedCountry> response) {
    selectedCountry = response;
  }

  Future<void> fetchCountries() async {
    setResponse(ApiResponse.loading());
    var response = await _myRepo.fetchCountries();
    response.fold((failure) => setResponse(ApiResponse.error(failure.message)),
        (data) async {
      setResponse(ApiResponse.completed(data));
    });
    notifyListeners();
  }

  Future selectCountryApi(Map<String, String> formData) async {
    setSelectCountryResponse(ApiResponse.loading());
    var response = await _myRepo.selectCountry(formData);
    response.fold((failure) {
      setSelectCountryResponse(ApiResponse.error(failure.message));
      Utils.flushBar(
        title: MessageStatus.Failure.name,
        message: failure.message,
        status: MessageStatus.Failure,
      );
    }, (data) async {
      setSelectCountryResponse(ApiResponse.completed(data));
      await saveLogin();
      Navigator.pushNamedAndRemoveUntil(
        navigatorKey.currentContext!,
        RoutesName.homeView,
        (route) => false,
      );
      Utils.flushBar(
        title: MessageStatus.Success.name,
        message: data.message,
        status: MessageStatus.Success,
      );
    });

    notifyListeners();
  }

  saveLogin() async {
    final SharedPreferencesService prefs = SharedPreferencesService();
    await prefs.saveLogin(true);
  }
}
