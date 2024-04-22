import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:yuktidea/features/country_selection/model/country.dart';
import 'package:yuktidea/features/country_selection/view_model/country_selection_view_model.dart';
import 'package:yuktidea/utils/config/size_config.dart';
import 'package:yuktidea/widgets/app_neumorphic_button.dart';

import '../../../core.dart';
import '../../../widgets/app_error_widget.dart';
import '../../../widgets/app_loading_widget.dart';
import '../../../widgets/app_neumorphic_back_button.dart';

class CountrySelectionView extends StatefulWidget {
  const CountrySelectionView({super.key});

  @override
  State<CountrySelectionView> createState() => _CountrySelectionViewState();
}

class _CountrySelectionViewState extends State<CountrySelectionView> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    CountrySelectionViewModel viewModel =
        Provider.of<CountrySelectionViewModel>(context, listen: false);
    await viewModel.init();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CountrySelectionViewModel>(
      builder: (BuildContext context, CountrySelectionViewModel viewModel,
          Widget? child) {
        switch (viewModel.selectCountry.status) {
          case Status.loading:
            return AppLoadingWidget();
          case Status.error:
            return AppErrorWidget(
                message: viewModel.selectCountry.message.toString());
          case Status.completed:
            return buildCountrySelectionView(viewModel);
          default:
            return AppErrorWidget();
        }
      },
    );
  }

  Scaffold buildCountrySelectionView(CountrySelectionViewModel viewModel) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        leading: AppNeumorphicBackButton(),
      ),
      body: SizedBox(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'Select country',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Please select the country where you want to study',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColor.primary,
              ),
            ),
            SizedBox(height: 100.h),
            BuildCountries(
              countries: viewModel.selectCountry.data!.data.countries,
            ),
            SizedBox(height: 20.h),
            AppNeumorphicButton(
              text: "Proceed",
              onPressed: () async {
                if (viewModel.country == null) {
                  Utils.flushBar(
                    title: "Select Country",
                    message: 'Please select a country',
                  );
                } else {
                  var res = await viewModel.selectCountryApi(
                    {"country_id": viewModel.country!.id.toString()},
                  );
                }
              },
            ),
            SizedBox(height: 50.h),
            Text(
              "Can’t see the country of your interest?",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10.h),
            TextButton(
              onPressed: () {},
              child: Text(
                "Consult with us",
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildCountries extends StatefulWidget {
  final List<Country> countries;

  const BuildCountries({super.key, required this.countries});

  @override
  _BuildCountriesState createState() => _BuildCountriesState();
}

class _BuildCountriesState extends State<BuildCountries> {
  Country? selectedCountry;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      shrinkWrap: true,
      itemCount: widget.countries.length,
      itemBuilder: (BuildContext context, int index) {
        var item = widget.countries[index];
        return buildCountry(item);
      },
    );
  }

  Widget buildCountry(Country country) {
    var viewModel = Provider.of<CountrySelectionViewModel>(context);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (selectedCountry == country) {
            selectedCountry = null; // Deselect if already selected
          } else {
            selectedCountry = country; // Select the tapped country
          }
          viewModel.country = selectedCountry;
        });
      },
      child: Column(
        children: [
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.h),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.h),
              child: ColorFiltered(
                colorFilter: selectedCountry == country
                    ? ColorFilter.srgbToLinearGamma()
                    : ColorFilter.mode(Colors.grey, BlendMode.saturation),
                child: Image.network(
                  country.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            country.name,
            style: TextStyle(fontSize: 20.sp),
          ),
        ],
      ),
    );
  }
}
