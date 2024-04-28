import 'package:flutter_html/flutter_html.dart';
import 'package:yuktidea/features/startup/model/term_condition_model.dart';
import 'package:yuktidea/features/startup/view_model/term_condition_view_model.dart';

import '../../../core.dart';

class TermsConditionView extends StatefulWidget {
  const TermsConditionView({super.key});

  @override
  State<TermsConditionView> createState() => _TermsConditionViewState();
}

class _TermsConditionViewState extends State<TermsConditionView> {
  @override
  void initState() {
    super.initState();
    TermConditionViewModel viewModel =
        Provider.of<TermConditionViewModel>(context, listen: false);
    viewModel.fetchTermCondition();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TermConditionViewModel>(
      builder: (BuildContext context, TermConditionViewModel viewModel,
          Widget? child) {
        switch (viewModel.termCondition.status) {
          case Status.loading:
            return AppLoadingWidget();
          case Status.error:
            return AppErrorWidget(message: viewModel.termCondition.message!);
          case Status.completed:
            return buildTermConditionView(viewModel.termCondition.data!.data);
          default:
            return AppErrorWidget();
        }
      },
    );
  }

  buildTermConditionView(Data data) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        automaticallyImplyLeading: false,
        actions: [
          FractionallySizedBox(
            heightFactor: 0.6,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Neumorphic(
                style: NeumorphicStyle(
                  shape: NeumorphicShape.convex,
                  boxShape: NeumorphicBoxShape.circle(),
                  depth: 4,
                  intensity: 0.6,
                  shadowLightColor: AppColor.white,
                ),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 25.h,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        margin: EdgeInsets.all(20.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SvgPicture.asset(
                    "assets/icons/terms.svg",
                    height: 70.h,
                    width: 70.w,
                    semanticsLabel: 'terms Logo',
                  ),
                  SizedBox(width: 20.h),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        data.title,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColor.primary,
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        DateTimeHelper.convertDateFormatToString(
                                data.updatedAt.toString())
                            .toString(),
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Html(
                data: data.content,
                style: {
                  "h1": Style(
                    color: AppColor.primary,
                    fontSize: FontSize.large,
                    fontFamily: 'Metropolis',
                  ),
                  "p": Style(
                    color: Colors.white,
                    fontSize: FontSize.medium,
                    fontFamily: 'Metropolis',
                  ),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
