import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

import '/core.dart';

enum Result { success, warning, error }

class Utils {
  static double averageRating(List<int> rating) {
    var avgRating = 0;
    for (int i = 0; i < rating.length; i++) {
      avgRating = avgRating + rating[i];
    }
    return double.parse((avgRating / rating.length).toStringAsFixed(1));
  }

  static void fieldFocusChange(FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(navigatorKey.currentContext!).requestFocus(nextFocus);
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        gravity: ToastGravity.SNACKBAR);
  }

  static void flushBar(
      {String? title,
      required String message,
      int duration = 3,
      MessageStatus status = MessageStatus.General}) {
    Color titleColor = _getColorForStatus(status);

    showFlushbar(
      context: navigatorKey.currentContext!,
      flushbar: Flushbar(
        title: title,
        message: message,
        messageColor: AppColor.white,
        titleColor: titleColor,
        backgroundColor: Colors.transparent,
        borderRadius: BorderRadius.circular(8.0),
        margin: EdgeInsets.all(8.0),
        duration: Duration(seconds: 2),
        flushbarStyle: FlushbarStyle.FLOATING,
        boxShadows: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 1,
            spreadRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
        backgroundGradient: LinearGradient(
          colors: [
            NeumorphicTheme.baseColor(navigatorKey.currentContext!),
            NeumorphicTheme.variantColor(navigatorKey.currentContext!),
          ],
        ),
        isDismissible: true,
        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
        forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
        reverseAnimationCurve: Curves.easeOut,
      )..show(navigatorKey.currentContext!),
    );
  }

  static Color _getColorForStatus(MessageStatus status) {
    Map<MessageStatus, Color> colorMap = {
      MessageStatus.General: AppColor.general,
      MessageStatus.Success: AppColor.success,
      MessageStatus.Failure: AppColor.failure,
    };

    return colorMap[status] ?? Colors.grey; // Default color
  }

  // static void startResendOTPTimer({
  //   required Future<void> onResend,
  //   int duration = 30,
  // }) {
  //   Timer? timer;
  //   int seconds = duration;
  //   bool isTimerRunning = true;
  //
  //   void startTimer() {
  //     timer = Timer.periodic(Duration(seconds: 1), (timer) {
  //       if (seconds > 0) {
  //         seconds--;
  //       } else {
  //         isTimerRunning = false;
  //         timer!.cancel();
  //       }
  //       if (!isTimerRunning) {
  //         ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
  //           SnackBar(content: Text('Resend OTP')),
  //         );
  //         onResend;
  //       }
  //     });
  //   }
  //
  //   startTimer();
  // }
}
