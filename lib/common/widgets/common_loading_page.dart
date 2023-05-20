import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vhembe_gov/common/constant/color_constant.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: ColorConstant.themeScaffold.withOpacity(0.8),
        child: const SpinKitFadingCube(
          color: ColorConstant.darkBlue,
          size: 42,
        ),
      ),
    );
  }
}
