import 'package:flutter/material.dart';
import 'package:vhembe_gov/common/app/app_methods.dart';
import 'package:vhembe_gov/common/constant/color_constant.dart';
import 'package:vhembe_gov/common/constant/image_constant.dart';
import 'package:vhembe_gov/common/constant/string_constant.dart';
import 'package:vhembe_gov/common/widgets/common_alert_dialog.dart';
import 'package:vhembe_gov/common/widgets/common_elevated_button.dart';
import 'package:vhembe_gov/common/widgets/common_image_assets.dart';
import 'package:vhembe_gov/common/widgets/text_form_fields.dart';
import 'package:vhembe_gov/screen/dashboard_screen/dashboard_screen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => LogInScreenState();
}

class LogInScreenState extends State<LogInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    logs('Current screen --> $runtimeType');
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
          context: context,
          builder: (_) => CustomAlertDialog(
            message: StringConstant.exitAppConfirm,
            isAction: true,
            onTap: () => Navigator.of(context).pop(true),
          ),
        );
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: 250,
              color: ColorConstant.darkBlue.withOpacity(0.8),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CommonImageAsset(image: ImageConstant.appBanner),
                  SizedBox(height: 16),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 190, left: 20, right: 20),
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: ColorConstant.white.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(34),
                  topRight: Radius.circular(34),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 210),
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: ColorConstant.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(34),
                  topRight: Radius.circular(34),
                ),
              ),
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                primary: true,
                physics: const BouncingScrollPhysics(),
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height >= 600 ? 46 : 20,
                  ),
                  const Text(
                    StringConstant.logIn,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorConstant.darkBlue,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height >= 650 ? 46 : 20,
                  ),
                  emailTextFormField(
                      emailController, StringConstant.emailAddress),
                  const SizedBox(height: 18),
                  passwordTextFormField(passwordController,
                      StringConstant.password, obscureText, passwordVisibility),
                  const SizedBox(height: 40),
                  CommonElevatedButton(
                    horizontalMargin: 0,
                    buttonName: StringConstant.logIn,
                    onPressed: () => logIn(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void logIn() {
    if (!RegExp(StringConstant.emailRegExp).hasMatch(emailController.text)) {
      showMessage(context, StringConstant.emailErrorText);
    } else if (passwordController.text.length < 8) {
      showMessage(context, StringConstant.passwordErrorText);
    } else {
      showMessage(context, StringConstant.loginVerify, isError: false);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
        (route) => false,
      );
    }
  }

  void passwordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}
