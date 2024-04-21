import 'package:flutter/material.dart';
import 'package:yuktidea/features/otp_verification/model/country_code_model.dart';
import 'package:yuktidea/features/otp_verification/repository/country_code_selection_repository.dart';

import '../../../data/response/api_response.dart';

class CountryCodeSelectionViewModel extends ChangeNotifier {
  final _myRepo = CountryCodeSelectionRepository();
  ApiResponse<CountryCode> countryCode = ApiResponse.loading();

  setTermCondition(ApiResponse<CountryCode> response) {
    countryCode = response;
  }

  Future<void> fetchCountriesCode() async {
    setTermCondition(ApiResponse.loading());
    var response = await _myRepo.fetchCountriesCode();
    response
        .fold((failure) => setTermCondition(ApiResponse.error(failure.message)),
            (data) async {
      setTermCondition(ApiResponse.completed(data));
    });
    notifyListeners();
  }
}
