import 'package:yuktidea/core.dart';

import '../../../data/service/shared_preference_service.dart';
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
    response.fold(
        (failure) =>
            setSelectCountryResponse(ApiResponse.error(failure.message)),
        (data) async {
      setSelectCountryResponse(ApiResponse.completed(data));
      Utils.snackBar("Country selected : ${data.data.selectedCountry}");
      Utils.toastMessage(data.message);

      Navigator.pushNamedAndRemoveUntil(
        navigatorKey.currentContext!,
        RoutesName.homeView,
        (route) => false,
      );
    });
    notifyListeners();
  }
}
