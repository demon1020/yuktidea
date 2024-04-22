import '../../../core.dart';

class TermConditionRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> fetchTermCondition() async {
    return await _apiServices.callGetAPI(
      AppUrl.termCondition,
      {},
      Parser.parseTermConditionResponse,
    );
  }
}
