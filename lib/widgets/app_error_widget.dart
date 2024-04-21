import 'package:flutter/material.dart';
import 'package:yuktidea/utils/config/size_config.dart';

class AppErrorWidget extends StatelessWidget {
  final String message;

  const AppErrorWidget({super.key, this.message = "No Data"});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          message,
          style: TextStyle(fontSize: 18.h),
        ),
      ),
    );
  }
}
