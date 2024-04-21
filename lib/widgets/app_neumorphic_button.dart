import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:yuktidea/utils/config/size_config.dart';

import '../resources/color.dart';

class AppNeumorphicButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;

  const AppNeumorphicButton({
    super.key,
    this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: SizedBox(
        height: 60.h,
        child: NeumorphicButton(
          onPressed: onPressed,
          style: NeumorphicStyle(
            shape: NeumorphicShape.flat,
            boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.circular(50),
            ),
          ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w400,
                color: AppColor.primary.withGreen(400),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
