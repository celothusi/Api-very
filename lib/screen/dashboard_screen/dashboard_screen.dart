import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:vhembe_gov/common/app/app_methods.dart';
import 'package:vhembe_gov/common/constant/color_constant.dart';
import 'package:vhembe_gov/common/constant/image_constant.dart';
import 'package:vhembe_gov/common/constant/string_constant.dart';
import 'package:vhembe_gov/common/widgets/common_drawer_menu.dart';
import 'package:vhembe_gov/common/widgets/common_image_assets.dart';
import 'package:vhembe_gov/common/widgets/text_form_fields.dart';
import 'package:vhembe_gov/screen/tabs/application_screen/application_screen.dart';
import 'package:vhembe_gov/screen/tabs/home_screen/home_screen.dart';
import 'package:vhembe_gov/screen/tabs/national_register_screen/national_register_screen.dart';
import 'package:vhembe_gov/screen/tabs/statistics_screen/statistics_screen.dart';

class DashboardScreen extends StatefulWidget {
  final int selectedMenuIndex;

  const DashboardScreen({Key? key, this.selectedMenuIndex = 0})
      : super(key: key);

  @override
  State<DashboardScreen> createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> homeDrawerKey = GlobalKey<ScaffoldState>();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController iDNumberController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController cellNoController = TextEditingController();
  int? selectedIndex;

  List<Widget> tabScreens = [
    const HomeScreen(),
    const ApplicationScreen(),
    const NationalRegisterScreen(),
    const StatisticsScreen(),
    const HomeScreen(),
  ];

  @override
  void initState() {
    selectedIndex = widget.selectedMenuIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    logs('Current screen --> $runtimeType');
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: homeDrawerKey,
        appBar: AppBar(
          title: const Text(StringConstant.dashboard),
          leading: GestureDetector(
            onTap: () => homeDrawerKey.currentState!.openDrawer(),
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: const CommonImageAsset(image: ImageConstant.drawerIcon),
            ),
          ),
          // actions: [
          //   Hero(
          //     tag: 'profileTag',
          //     transitionOnUserGestures: true,
          //     child: GestureDetector(
          //       onTap: () => Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => const MyProfileScreen()),
          //       ),
          //       child: Container(
          //         height: 10,
          //         width: 40,
          //         margin: const EdgeInsets.only(right: 12, top: 8, bottom: 8),
          //         decoration: const BoxDecoration(
          //           color: ColorConstant.transparent,
          //           shape: BoxShape.circle,
          //         ),
          //         child: ClipRRect(
          //           borderRadius: BorderRadius.circular(50),
          //           child: const CommonImageAsset(
          //             image: ImageConstant.userAvatar,
          //             fit: BoxFit.cover,
          //           ),
          //         ),
          //       ),
          //     ),
          //   )
          // ],
        ),
        drawer: CommonDrawerMenu(
            drawerKey: homeDrawerKey, activeIndex: selectedIndex),
        drawerEnableOpenDragGesture: false,
        body: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: ColorConstant.darkBlue,
              child: searchTextFormField(
                searchController,
                StringConstant.search,
                (String value) => logs('Onchanged --> $value'),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                children: [tabScreens.elementAt(selectedIndex!)],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
          child: GNav(
            duration: const Duration(milliseconds: 800),
            tabBackgroundColor: ColorConstant.darkBlue.withOpacity(0.1),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: StringConstant.home,
                gap: 4,
                padding: EdgeInsets.all(10),
                leading: CommonImageAsset(
                  image: ImageConstant.drawerHomeIcon,
                  color: ColorConstant.darkBlue,
                  width: 20,
                ),
              ),
              GButton(
                icon: Icons.home,
                text: StringConstant.application,
                gap: 4,
                padding: EdgeInsets.all(10),
                leading: CommonImageAsset(
                  image: ImageConstant.drawerApplicationIcon,
                  color: ColorConstant.darkBlue,
                  width: 20,
                ),
              ),
              GButton(
                icon: Icons.home,
                text: StringConstant.nationalRegister,
                gap: 4,
                padding: EdgeInsets.all(10),
                leading: CommonImageAsset(
                  image: ImageConstant.drawerNationalRegisterIcon,
                  color: ColorConstant.darkBlue,
                  width: 20,
                ),
              ),
              GButton(
                icon: Icons.home,
                text: StringConstant.statistics,
                gap: 4,
                padding: EdgeInsets.all(10),
                leading: CommonImageAsset(
                  image: ImageConstant.drawerStatisticsIcon,
                  color: ColorConstant.darkBlue,
                  width: 20,
                ),
              ),
              GButton(
                icon: Icons.home,
                text: StringConstant.myProfile,
                gap: 4,
                padding: EdgeInsets.all(10),
                leading: CommonImageAsset(
                  image: ImageConstant.userAvatar,
                  // color: ColorConstant.darkBlue,
                  width: 20,
                ),
              ),
            ],
            selectedIndex: selectedIndex!,
            onTabChange: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
