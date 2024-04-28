import 'package:cached_svg_image/cached_svg_image.dart';
import 'package:yuktidea/core.dart';
import 'package:yuktidea/features/otp_verification/view_model/country_code_selection_view_model.dart';

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
        leading: AppNeumorphicBackButton(),
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
                controller: viewModel.controller,
                onChanged: (query) => viewModel.searchCountry(query),
                decoration: InputDecoration(
                  filled: true,
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColor.primary,
                  ),
                  hintText: "Search",
                  fillColor: AppColor.primaryLight.withOpacity(0.2),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              viewModel.filteredCountryCodeList.isEmpty
                  ? Center(
                      child: Text('Country Not Found'),
                    )
                  : ListView.separated(
                      itemCount: viewModel.filteredCountryCodeList.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemBuilder: (context, index) {
                        var item = viewModel.filteredCountryCodeList[index];
                        return GestureDetector(
                          onTap: () async {
                            viewModel.controller.clear();
                            Navigator.pushNamed(context, RoutesName.authView,
                                arguments: item);
                            viewModel.setCountryList();
                          },
                          child: ListTile(
                            leading: SizedBox(
                              height: 30.h,
                              width: 30.w,
                              child: CachedNetworkSvgImage(
                                url: item.flag,
                                loadinggif:
                                    'assets/images/placeholder/no-image.png',
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
