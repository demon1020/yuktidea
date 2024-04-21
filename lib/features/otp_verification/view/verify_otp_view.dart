import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:pinput/pinput.dart';
import 'package:yuktidea/utils/config/size_config.dart';

import '../../../core.dart';
import '../view_model/verify_otp_view_model.dart';

class VerifyOtpView extends StatefulWidget {
  const VerifyOtpView({super.key});

  @override
  State<VerifyOtpView> createState() => _VerifyOtpViewState();
}

class _VerifyOtpViewState extends State<VerifyOtpView> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Colors.white;
    const fillColor = AppColor.primaryDark;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Colors.white,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
    );
    return Consumer<VerifyOtpViewModel>(
      builder:
          (BuildContext context, VerifyOtpViewModel viewModel, Widget? child) {
        return Scaffold(
          appBar: NeumorphicAppBar(
            leading: FractionallySizedBox(
              heightFactor: 0.6,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Neumorphic(
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.convex,
                    boxShape: NeumorphicBoxShape.circle(),
                    depth: 4,
                    intensity: 0.8,
                  ),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 25.h,
                  ),
                ),
              ),
            ),
          ),
          body: Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            // margin: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Verify number',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Please enter the received OTP to verify your number',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColor.primary,
                    ),
                  ),
                  SizedBox(height: 100.h),
                  Directionality(
                    // Specify direction if desired
                    textDirection: TextDirection.ltr,
                    child: Pinput(
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      length: 4,
                      controller: pinController,
                      focusNode: focusNode,
                      androidSmsAutofillMethod:
                          AndroidSmsAutofillMethod.smsUserConsentApi,
                      listenForMultipleSmsOnAndroid: true,
                      defaultPinTheme: defaultPinTheme,
                      // validator: (value) => provider.validateOtp(value),
                      onClipboardFound: (value) {
                        debugPrint('onClipboardFound: $value');
                        // pinController.setText(value);
                      },
                      hapticFeedbackType: HapticFeedbackType.heavyImpact,
                      onCompleted: (pin) {
                        // log('onCompleted: $pin');
                        // if (pin == provider.smsCode) {
                        //   provider.isVerified = true;
                        // } else {
                        //   log('Wrong otp: $pin');
                        // }
                      },
                      onChanged: (value) {
                        // log('onChanged: $value');
                      },
                      cursor: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 9),
                            width: 22,
                            height: 1,
                            color: focusedBorderColor,
                          ),
                        ],
                      ),
                      // focusedPinTheme: defaultPinTheme.copyWith(
                      //   decoration: defaultPinTheme.decoration!.copyWith(
                      //     borderRadius: BorderRadius.circular(8),
                      //     // border: Border.all(color: focusedBorderColor),
                      //   ),
                      // ),
                      // submittedPinTheme: defaultPinTheme.copyWith(
                      //   decoration: defaultPinTheme.decoration!.copyWith(
                      //     color: fillColor,
                      //     borderRadius: BorderRadius.circular(19),
                      //     // border: Border.all(color: focusedBorderColor),
                      //   ),
                      // ),
                      errorPinTheme: defaultPinTheme.copyBorderWith(
                        border: Border.all(color: Colors.redAccent),
                      ),
                    ),
                  ),
                  SizedBox(height: 50.h),
                  Text(
                    "Didn't receive OTP?",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Resend OTP",
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColor.primary),
                    ),
                  ),
                  SizedBox(height: 200.h),
                  NeumorphicButton(
                    onPressed: () async {
                      if (viewModel.message.isEmpty) {
                        await viewModel.verifyOtpFromServer(
                          {
                            "code": pinController.text,
                            "phone": "+918805066532",
                          },
                        );
                      } else {
                        Utils.toastMessage(viewModel.message);
                      }
                    },
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.flat,
                      boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(50),
                      ),
                    ),
                    child: Text(
                      'Verify',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
