import 'package:flutter/services.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yuktidea/features/otp_verification/model/country_code_model.dart';
import 'package:yuktidea/features/otp_verification/view_model/auth_view_model.dart';
import 'package:yuktidea/utils/config/size_config.dart';

import '../../../core.dart';
import '../../../widgets/app_neumorphic_back_button.dart';
import '../../../widgets/app_neumorphic_button.dart';

class AuthView extends StatefulWidget {
  final CountryData country;

  const AuthView({super.key, required this.country});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    phoneController.text = "";
    phoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    AuthViewModel viewModel =
        Provider.of<AuthViewModel>(context, listen: false);
    viewModel.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (BuildContext context, AuthViewModel viewModel, Widget? child) {
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
                    'Enter phone number',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Please enter your 10 digit mobile number to receive OTP',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColor.primary,
                    ),
                  ),
                  SizedBox(height: 100.h),
                  Row(
                    children: [
                      SvgPicture.network(
                        height: 30.h,
                        width: 30.h,
                        widget.country.flag,
                      ),
                      SizedBox(width: 15.h),
                      Text(
                        widget.country.telCode,
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 15.h),
                      Expanded(
                        child: TextField(
                          controller: phoneController,
                          autofocus: true,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          style: TextStyle(fontSize: 17.sp),
                          decoration: InputDecoration(
                            hintText: "9999999999",
                            fillColor: AppColor.primaryLight.withOpacity(0.2),
                            border: InputBorder.none,
                            errorBorder: InputBorder.none,
                            errorText: null,
                            error: null,
                            errorStyle: null,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(color: AppColor.lightGrey),
                  SizedBox(height: 10.h),
                  Visibility(
                    visible: viewModel.message.isNotEmpty,
                    child: Text(
                      viewModel.message,
                      style: TextStyle(color: Colors.red, fontSize: 18.sp),
                    ),
                  ),
                  SizedBox(height: 200.h),
                  AppNeumorphicButton(
                    text: "Get OTP",
                    onPressed: () async {
                      if (viewModel.validateLogin(phoneController.text)) {
                        await viewModel.getOtpFromServer(
                          {
                            "tel_code": "+91", //widget.country.telCode,
                            "phone": "8805066532" //phoneController.text,
                          },
                        );
                      }
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
