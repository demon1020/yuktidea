import 'package:yuktidea/features/home/view_model/home_view_model.dart';
import 'package:yuktidea/widgets/app_neumorphic_button.dart';

import '../../../core.dart';
import '../../../utils/config/size_config.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (BuildContext context, HomeViewModel viewModel, Widget? child) {
        return Scaffold(
          body: Container(
            alignment: Alignment.center,
            height: SizeConfig.screenHeight,
            margin: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 50.h),
                AppNeumorphicButton(
                  text: "Logout",
                  onPressed: () => viewModel.logout(),
                ),
                SizedBox(height: 30.h),
                AppNeumorphicButton(
                  text: "Delete User",
                  onPressed: () => viewModel.delete(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
