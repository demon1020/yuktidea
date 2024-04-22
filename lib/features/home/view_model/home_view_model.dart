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
    response.fold((failure) {
      setResponse(ApiResponse.error(failure.message));
      Utils.flushBar(
        status: MessageStatus.Failure,
        title: MessageStatus.Failure.name,
        message: failure.message,
      );
    }, (data) async {
      setResponse(ApiResponse.completed(data));
      await removeData();
      Navigator.pushNamedAndRemoveUntil(
        navigatorKey.currentContext!,
        RoutesName.startupView,
        (route) => false, // Removes all the previous routes
      );
      Utils.flushBar(
        status: MessageStatus.Success,
        title: MessageStatus.Success.name,
        message: data.message,
      );
    });
    notifyListeners();
  }

  Future<void> delete() async {
    setResponse(ApiResponse.loading());
    var response = await _myRepo.logout();
    response.fold((failure) {
      setResponse(ApiResponse.error(failure.message));
      Utils.flushBar(
        status: MessageStatus.Failure,
        title: MessageStatus.Failure.name,
        message: failure.message,
      );
    }, (data) async {
      setResponse(ApiResponse.completed(data));
      await removeData(deleteUser: true);
      Navigator.pushNamedAndRemoveUntil(
        navigatorKey.currentContext!,
        RoutesName.startupView,
        (route) => false, // Removes all the previous routes
      );
      Utils.flushBar(
        status: MessageStatus.Success,
        title: MessageStatus.Success.name,
        message: data.message,
      );
    });
    notifyListeners();
  }

  Future<void> removeData({bool deleteUser = false}) async {
    final SharedPreferencesService prefs = SharedPreferencesService();
    await prefs.clearLogin();
    if (deleteUser) {
      await prefs.clearUser();
      await prefs.clearToken();
    }
  }
}
