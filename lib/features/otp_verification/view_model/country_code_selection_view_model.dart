import 'package:flutter/material.dart';
import 'package:yuktidea/features/otp_verification/model/country_code_model.dart';
import 'package:yuktidea/features/otp_verification/repository/country_code_selection_repository.dart';

import '../../../data/response/api_response.dart';

class CountryCodeSelectionViewModel extends ChangeNotifier {
  final CountryCodeSelectionRepository _myRepo =
      CountryCodeSelectionRepository();
  late List<CountryData> filteredCountryCodeList = [];
  late List<CountryData> countryCodeList = [];
  final TextEditingController controller = TextEditingController();
  ApiResponse<CountryCode> countryCode = ApiResponse.loading();

  void setTermCondition(ApiResponse<CountryCode> response) =>
      countryCode = response;
  void setCountryList() {
    filteredCountryCodeList = countryCodeList;
    notifyListeners();
  }

  Future<void> fetchCountriesCode() async {
    setTermCondition(ApiResponse.loading());
    var response = await _myRepo.fetchCountriesCode();
    response
        .fold((failure) => setTermCondition(ApiResponse.error(failure.message)),
            (data) async {
      setTermCondition(ApiResponse.completed(data));
      countryCodeList = data!.data;
      filteredCountryCodeList = data!.data;
    });
    notifyListeners();
  }

  void searchCountry(String query) {
    filteredCountryCodeList = countryCodeList
        .where((item) => item.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
