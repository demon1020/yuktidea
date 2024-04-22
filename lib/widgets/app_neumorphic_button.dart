import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:yuktidea/utils/config/size_config.dart';

import '../resources/color.dart';

class AppNeumorphicButton extends StatefulWidget {
  final Function()? onPressed;
  final String text;

  const AppNeumorphicButton({
    Key? key,
    this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  _AppNeumorphicButtonState createState() => _AppNeumorphicButtonState();
}

class _AppNeumorphicButtonState extends State<AppNeumorphicButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: SizedBox(
        height: 60.h,
        child: GestureDetector(
          onTapDown: (_) {
            setState(() {
              _isPressed = true;
              widget.onPressed?.call();
            });
          },
          onTapUp: (_) {
            setState(() {
              _isPressed = false;
            });
          },
          onTapCancel: () {
            setState(() {
              _isPressed = false;
            });
          },
          child: Neumorphic(
            style: NeumorphicStyle(
              shape: NeumorphicShape.flat,
              boxShape: NeumorphicBoxShape.roundRect(
                BorderRadius.circular(50),
              ),
              intensity: _isPressed ? 1 : 0.5,
            ),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              alignment: Alignment.center,
              child: Text(
                widget.text,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w400,
                  color: _isPressed
                      ? AppColor.primary.withOpacity(0.7)
                      : AppColor.primary.withGreen(400),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
