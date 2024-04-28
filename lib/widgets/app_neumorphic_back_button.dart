import 'package:yuktidea/core.dart';

class AppNeumorphicBackButton extends StatelessWidget {
  const AppNeumorphicBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.65,
      child: NeumorphicBackButtonWidget(
        padding: EdgeInsets.only(left: 7),
        style: NeumorphicStyle(
          shape: NeumorphicShape.flat,
          boxShape: NeumorphicBoxShape.circle(),
          depth: 4,
          intensity: 0.5,
          shadowLightColor: AppColor.white,
          lightSource: LightSource.topLeft,
        ),
        child: Icon(
          Icons.arrow_back_ios,
          size: 20.h,
          weight: 10,
        ),
      ),
    );
  }
}

class NeumorphicBackButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final NeumorphicStyle? style;
  final EdgeInsets? padding;
  final Widget child;

  const NeumorphicBackButtonWidget({
    super.key,
    this.onPressed,
    this.style,
    this.padding,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final nThemeIcons = NeumorphicTheme.of(context)!.current!.appBarTheme.icons;
    return NeumorphicButton(
      style: style,
      padding: padding,
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      onPressed: onPressed ?? () => Navigator.maybePop(context),
      child: child,
    );
  }
}
