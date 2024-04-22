import 'package:flutter/material.dart';
import 'package:yuktidea/utils/config/size_config.dart';

class AppErrorWidget extends StatelessWidget {
  final String message;

  const AppErrorWidget({super.key, this.message = "No Data"});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.h),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                height: 50.h,
                width: 50.w,
                "assets/images/placeholder/error.png",
              ),
              SizedBox(height: 10.h),
              Text(
                textAlign: TextAlign.center,
                message,
                style: TextStyle(fontSize: 18.h, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
