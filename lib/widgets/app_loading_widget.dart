import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:yuktidea/core.dart';

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: Colors.white,
          size: 50,
        ),
      ),
    );
  }
}
