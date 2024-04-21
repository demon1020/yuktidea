import 'package:yuktidea/features/home/model/logout_model.dart';
import 'package:yuktidea/features/home/repository/home_repository.dart';

import '../../../core.dart';

class HomeViewModel extends ChangeNotifier {
  final _myRepo = HomeRepository();
  ApiResponse<UserDeleteLogout> userDeleteLogout = ApiResponse.loading();

  setResponse(ApiResponse<UserDeleteLogout> response) {
    userDeleteLogout = response;
  }

  Future<void> logout() async {
    setResponse(ApiResponse.loading());
    var response = await _myRepo.logout();
    response.fold((failure) => setResponse(ApiResponse.error(failure.message)),
        (data) async {
      setResponse(ApiResponse.completed(data));
      Utils.toastMessage(data.message);
      Navigator.pushNamedAndRemoveUntil(
        navigatorKey.currentContext!,
        RoutesName.startupView,
        (route) => false, // Removes all the previous routes
      );
    });
    notifyListeners();
  }

  Future<void> delete() async {
    setResponse(ApiResponse.loading());
    var response = await _myRepo.logout();
    response.fold((failure) => setResponse(ApiResponse.error(failure.message)),
        (data) async {
      setResponse(ApiResponse.completed(data));
      Utils.toastMessage(data.message);
      Navigator.pushNamedAndRemoveUntil(
        navigatorKey.currentContext!,
        RoutesName.startupView,
        (route) => false, // Removes all the previous routes
      );
    });
    notifyListeners();
  }
}
