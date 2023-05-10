import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vhembe_gov/common/app/app_methods.dart';
import 'package:vhembe_gov/common/app/app_theme.dart';
import 'package:vhembe_gov/common/constant/color_constant.dart';
import 'package:vhembe_gov/common/constant/string_constant.dart';
import 'package:vhembe_gov/screen/login_screen/login_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logs('Current screen --> $runtimeType');
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: StringConstant.appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: ColorConstant.themeScaffold,
        fontFamily: AppTheme.poppins,
        dividerColor: ColorConstant.transparent,
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(
            color: ColorConstant.black.withOpacity(0.5),
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          errorStyle: TextStyle(
            color: ColorConstant.red.withOpacity(0.8),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          alignLabelWithHint: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: ColorConstant.grey100),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: ColorConstant.grey100),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: ColorConstant.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: ColorConstant.red),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: ColorConstant.grey100),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: ColorConstant.grey100),
          ),
          isDense: true,
          iconColor: ColorConstant.white,
          prefixIconColor: ColorConstant.darkBlue,
          filled: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(ColorConstant.darkBlue),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 26, vertical: 10)),
            elevation: MaterialStateProperty.all(0),
          ),
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          color: ColorConstant.darkBlue,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontFamily: AppTheme.poppins,
            fontSize: 18,
            color: ColorConstant.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      home: const LogInScreen(),
    );
  }
}
