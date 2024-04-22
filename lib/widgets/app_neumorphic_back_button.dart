import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class AppNeumorphicBackButton extends StatelessWidget {
  const AppNeumorphicBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.8,
      child: NeumorphicBackButton(
        style: NeumorphicStyle(
          shape: NeumorphicShape.flat,
          boxShape: NeumorphicBoxShape.circle(),
          depth: 10,
          intensity: 0.9,
          lightSource: LightSource.topLeft,
        ),
      ),
    );
  }
}
