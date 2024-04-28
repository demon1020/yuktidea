import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:yuktidea/core.dart';

class StartupView extends StatefulWidget {
  StartupView({super.key});

  @override
  State<StartupView> createState() => _StartupViewState();
}

class _StartupViewState extends State<StartupView> {
  bool isLogin = false;

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    final SharedPreferencesService prefs = SharedPreferencesService();
    isLogin = await prefs.getLogin() ?? false;
    if (isLogin) {
      Navigator.pushReplacementNamed(
          navigatorKey.currentContext!, RoutesName.homeView);
    }
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [
      Image(
        width: SizeConfig.screenWidth,
        fit: BoxFit.cover,
        image: AssetImage(AssetConstant.startupImg1),
      ),
      Image(
        width: SizeConfig.screenWidth,
        fit: BoxFit.cover,
        image: AssetImage(AssetConstant.startupImg2),
      ),
      Image(
        width: SizeConfig.screenWidth,
        fit: BoxFit.cover,
        image: AssetImage(AssetConstant.startupImg3),
      ),
      Image(
        width: SizeConfig.screenWidth,
        fit: BoxFit.cover,
        image: AssetImage(AssetConstant.startupImg4),
      ),
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: SizeConfig.screenHeight,
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              CarouselSlider(
                items: items,
                options: CarouselOptions(
                  height: SizeConfig.screenHeight,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.ease,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Neumorphic(
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.flat,
                      boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      depth: 8,
                      intensity: 0.7,
                    ),
                    child: SizedBox(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.screenHeight / 2.2,
                      child: Padding(
                        padding: EdgeInsets.all(10.h),
                        child: Column(
                          children: [
                            Text(
                              "Welcome To Study Lancer",
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              "Please select your role to get registered",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 20.w),
                            FittedBox(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.h),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        final SharedPreferencesService prefs =
                                            SharedPreferencesService();
                                        await prefs
                                            .saveUser(UserType.student.index);
                                        Navigator.pushNamed(
                                            context,
                                            RoutesName
                                                .countryCodeSelectionView);
                                      },
                                      child: Column(
                                        children: [
                                          buildNeumorphicTile(
                                              AssetConstant.student),
                                          SizedBox(height: 20.h),
                                          Text(
                                            'Student',
                                            style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 25.w),
                                    GestureDetector(
                                      onTap: () async {
                                        final SharedPreferencesService prefs =
                                            SharedPreferencesService();
                                        await prefs.saveUser(
                                            UserType.counsellor.index);
                                        Navigator.pushNamed(
                                            context,
                                            RoutesName
                                                .countryCodeSelectionView);
                                      },
                                      child: Column(
                                        children: [
                                          buildNeumorphicTile(
                                              AssetConstant.agent),
                                          SizedBox(height: 20.h),
                                          Text(
                                            'Agent',
                                            style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20.w),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RoutesName.termsConditionView);
                              },
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "By continuing you agree to our ",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "Terms & Conditions",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.primary,
                                      ),
                                    )
                                  ],
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Neumorphic buildNeumorphicTile(String imagePath) {
    return Neumorphic(
      style: NeumorphicStyle(
        depth: 7,
        intensity: 0.8,
        border: NeumorphicBorder(width: 15.h, isEnabled: true),
      ),
      child: SizedBox(
        width: 200.w,
        height: 180.h,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.h),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
