import 'package:flutter/services.dart';

import '../../../core.dart';
import '../view_model/verify_otp_view_model.dart';

class VerifyOtpView extends StatefulWidget {
  final String phone;

  const VerifyOtpView({super.key, required this.phone});

  @override
  State<VerifyOtpView> createState() => _VerifyOtpViewState();
}

class _VerifyOtpViewState extends State<VerifyOtpView> {
  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Colors.white;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Colors.white,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColor.white),
        ),
      ),
    );
    return Consumer<VerifyOtpViewModel>(
      builder:
          (BuildContext context, VerifyOtpViewModel viewModel, Widget? child) {
        return Scaffold(
          appBar: NeumorphicAppBar(
            leading: AppNeumorphicBackButton(),
          ),
          body: Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            margin: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
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
                  Pinput(
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    length: 4,
                    controller: viewModel.pinController,
                    focusNode: viewModel.focusNode,
                    androidSmsAutofillMethod:
                        AndroidSmsAutofillMethod.smsUserConsentApi,
                    listenForMultipleSmsOnAndroid: true,
                    defaultPinTheme: defaultPinTheme,
                    hapticFeedbackType: HapticFeedbackType.heavyImpact,
                    onChanged: (v) => viewModel.setMessage(""),
                  ),
                  SizedBox(height: 10.h),
                  Visibility(
                    visible: viewModel.message.isNotEmpty,
                    child: Text(
                      viewModel.message,
                      style: TextStyle(color: AppColor.failure, fontSize: 15.h),
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
                  Visibility(
                    visible: viewModel.timerDuration == 0 ? true : false,
                    replacement: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Resending OPT in ",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          TextSpan(
                            text: "${viewModel.timerDuration} seconds",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColor.primary,
                            ),
                          )
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                    child: TextButton(
                      onPressed: () async {
                        await viewModel
                            .resendOtpFromServer({"phone": widget.phone});
                      },
                      child: Text(
                        "Resend OTP",
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColor.primary),
                      ),
                    ),
                  ),
                  SizedBox(height: 150.h),
                  AppNeumorphicButton(
                    text: "Verify",
                    onPressed: () async {
                      await viewModel.verifyOtpFromServer(
                        {
                          "code": viewModel.pinController.text,
                          "phone": widget.phone,
                        },
                      );
                    },
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
