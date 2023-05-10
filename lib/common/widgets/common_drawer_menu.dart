import 'package:flutter/material.dart';
import 'package:vhembe_gov/common/app/app_methods.dart';
import 'package:vhembe_gov/common/constant/color_constant.dart';
import 'package:vhembe_gov/common/constant/image_constant.dart';
import 'package:vhembe_gov/common/constant/string_constant.dart';
import 'package:vhembe_gov/common/widgets/common_alert_dialog.dart';
import 'package:vhembe_gov/common/widgets/common_image_assets.dart';
import 'package:vhembe_gov/screen/dashboard_screen/dashboard_screen.dart';
import 'package:vhembe_gov/screen/login_screen/login_screen.dart';

class CommonDrawerMenu extends StatelessWidget {
  final GlobalKey<ScaffoldState>? drawerKey;
  final int? activeIndex;

  const CommonDrawerMenu({
    Key? key,
    @required this.drawerKey,
    @required this.activeIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: CommonImageAsset(
                      image: ImageConstant.userAvatar,
                      height: 76,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dummy user'.toTitleCase(),
                        style: const TextStyle(
                          color: ColorConstant.black,
                          fontSize: 16,
                          wordSpacing: 1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'dummyuser123@gmail.com',
                        style: TextStyle(
                          color: ColorConstant.black,
                          fontSize: 10,
                          wordSpacing: 1,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Divider(
              color: ColorConstant.grey,
              endIndent: 20,
              indent: 20,
              thickness: 1,
            ),
            Expanded(
              child: ListView(
                primary: true,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    primary: true,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: drawerOptions.length,
                    itemBuilder: (BuildContext context, int? index) {
                      return GestureDetector(
                        onTap: () {
                          drawerKey!.currentState!.openEndDrawer();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DashboardScreen(selectedMenuIndex: index!)),
                            (route) => false,
                          );
                        },
                        child: drawerOption(
                          index: index,
                          optionImage: drawerOptions[index!].drawerImage,
                          optionName: drawerOptions[index].drawerName,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  const Divider(
                    color: ColorConstant.grey,
                    endIndent: 20,
                    indent: 20,
                    thickness: 1,
                  ),
                  GestureDetector(
                    onTap: () {
                      drawerKey!.currentState!.openEndDrawer();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const DashboardScreen(selectedMenuIndex: 4)),
                        (route) => false,
                      );
                    },
                    child: drawerOption(
                      index: 4,
                      optionImage: ImageConstant.drawerMyProfileIcon,
                      optionName: StringConstant.myProfile,
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => CustomAlertDialog(
                          message: StringConstant.logOutConfirm,
                          isAction: true,
                          onTap: () {
                            drawerKey!.currentState!.openEndDrawer();
                            showMessage(context, StringConstant.logoutVerify,
                                isError: false);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LogInScreen()),
                              (route) => false,
                            );
                          },
                        ),
                      );
                    },
                    child: drawerOption(
                      optionImage: ImageConstant.drawerLogOutIcon,
                      optionName: StringConstant.logOut,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container drawerOption({
    int? index,
    @required String? optionImage,
    @required String? optionName,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: index == activeIndex
            ? ColorConstant.darkBlue.withOpacity(0.1)
            : ColorConstant.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(vertical: 14),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          if (index == activeIndex) const SizedBox(width: 14),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ColorConstant.darkBlue.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: CommonImageAsset(
              image: optionImage,
              color: ColorConstant.darkBlue,
              height: 16,
              width: 16,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            optionName!,
            style: TextStyle(
              fontSize: index == activeIndex ? 15 : 13,
              color: ColorConstant.darkBlue,
              wordSpacing: 1,
              fontWeight:
                  index == activeIndex ? FontWeight.bold : FontWeight.w600,
            ),
          ),
          const Spacer(),
          CommonImageAsset(
            image: ImageConstant.forwardIcon,
            color: ColorConstant.darkBlue.withOpacity(0.8),
            height: 12,
            width: 12,
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}
