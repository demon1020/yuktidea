import 'package:flutter/material.dart';

import '../../../data/response/api_response.dart';
import '../model/term_condition_model.dart';
import '../repository/term_condition_repository.dart';

class TermConditionViewModel with ChangeNotifier {
  final _myRepo = TermConditionRepository();
  ApiResponse<TermCondition> termCondition = ApiResponse.loading();

  setTermCondition(ApiResponse<TermCondition> response) {
    termCondition = response;
  }

  Future<void> fetchTermCondition() async {
    setTermCondition(ApiResponse.loading());
    var response = await _myRepo.fetchTermCondition();
    response
        .fold((failure) => setTermCondition(ApiResponse.error(failure.message)),
            (data) async {
      setTermCondition(ApiResponse.completed(data));
    });
    notifyListeners();
  }
}
