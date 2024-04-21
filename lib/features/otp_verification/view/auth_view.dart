import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yuktidea/features/otp_verification/model/country_code_model.dart';
import 'package:yuktidea/features/otp_verification/view_model/auth_view_model.dart';
import 'package:yuktidea/utils/config/size_config.dart';

import '../../../core.dart';

class AuthView extends StatefulWidget {
  final CountryData country;

  const AuthView({super.key, required this.country});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (BuildContext context, AuthViewModel viewModel, Widget? child) {
        return Scaffold(
          appBar: NeumorphicAppBar(
            leading: FractionallySizedBox(
              heightFactor: 0.6,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(navigatorKey.currentContext!).pop();
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
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SvgPicture.network(
                          height: 30.h,
                          width: 30.h,
                          widget.country.flag,
                        ),
                        SizedBox(width: 10.h),
                        Text(
                          widget.country.telCode,
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        SizedBox(width: 10.h),
                        Flexible(
                          child: TextFormField(
                            controller: phoneController,
                            autofocus: true,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "9999999999",
                              fillColor: AppColor.primaryLight.withOpacity(0.2),
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return viewModel.message =
                                    'Enter mobile number';
                              } else if (value.length < 10) {
                                return viewModel.message =
                                    'Mobile number must have 10 digits';
                              } else if (value.length > 10) {
                                return viewModel.message =
                                    'Mobile number must have 10 digits';
                              } else if (!Validator.validateMobile(value)) {
                                return viewModel.message =
                                    'Enter a valid mobile number';
                              } else {}
                              setState(() {});
                            },
                            onSaved: (value) => viewModel.phone = value!,
                          ),
                        ),
                      ],
                    ),
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
                  NeumorphicButton(
                    onPressed: () async {
                      // viewModel.message =
                      //     viewModel.validateLogin(phoneController.text);
                      if (viewModel.message.isEmpty) {
                        await viewModel.getOtpFromServer(
                          {
                            "tel_code": widget.country.code,
                            "phone": phoneController.text,
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
                      'Get OTP',
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
