import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yuktidea/core.dart';
import 'package:yuktidea/features/otp_verification/view_model/country_code_selection_view_model.dart';
import 'package:yuktidea/utils/config/size_config.dart';

import '../../../widgets/app_error_widget.dart';
import '../../../widgets/app_loading_widget.dart';

class CountryCodeSelectionView extends StatefulWidget {
  CountryCodeSelectionView({super.key});

  @override
  State<CountryCodeSelectionView> createState() =>
      _CountryCodeSelectionViewState();
}

class _CountryCodeSelectionViewState extends State<CountryCodeSelectionView> {
  @override
  void initState() {
    super.initState();
    CountryCodeSelectionViewModel viewModel =
        Provider.of<CountryCodeSelectionViewModel>(context, listen: false);
    viewModel.fetchCountriesCode();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CountryCodeSelectionViewModel>(
      builder: (BuildContext context, CountryCodeSelectionViewModel viewModel,
          Widget? child) {
        switch (viewModel.countryCode.status) {
          case Status.loading:
            return AppLoadingWidget();
          case Status.error:
            return AppErrorWidget(message: viewModel.countryCode.message!);
          case Status.completed:
            return buildCountryCodeView(viewModel);
          default:
            return AppErrorWidget();
        }
      },
    );
  }

  Scaffold buildCountryCodeView(CountryCodeSelectionViewModel viewModel) {
    var data = viewModel.countryCode.data!.data;
    return Scaffold(
      appBar: NeumorphicAppBar(
        leading: FractionallySizedBox(
          heightFactor: 0.6,
          child: GestureDetector(
            onTap: () {
              Navigator.of(navigatorKey.currentContext!).pop();
            },
            child: Neumorphic(
              style: NeumorphicStyle(
                shape: NeumorphicShape.convex,
                boxShape: NeumorphicBoxShape.circle(),
                depth: 4,
                intensity: 0.8,
              ),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 25.h,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Select your country',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20.h),
              TextFormField(
                onChanged: (query) => viewModel.searchCountry(query),
                decoration: InputDecoration(
                  filled: true,
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search",
                  fillColor: AppColor.primaryLight.withOpacity(0.2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              ListView.separated(
                itemCount: viewModel.filteredCountryCodeList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemBuilder: (context, index) {
                  var item = viewModel.filteredCountryCodeList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.authView,
                          arguments: item);
                    },
                    child: ListTile(
                      leading: SizedBox(
                        height: 30.h,
                        width: 30.w,
                        child: SvgPicture.network(
                          item.flag,
                        ),
                      ),
                      title: Text(item.name),
                      trailing: Text(item.telCode),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
