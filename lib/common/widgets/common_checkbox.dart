import 'package:flutter/material.dart';
import 'package:vhembe_gov/common/constant/color_constant.dart';

class CommonCheckBox extends StatelessWidget {
  final bool checkBox;

  const CommonCheckBox({Key? key, this.checkBox = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        color: ColorConstant.darkBlue.withOpacity(0.7),
        borderRadius: BorderRadius.circular(4),
      ),
      child: checkBox
          ? const Icon(
              Icons.check,
              size: 20,
              color: ColorConstant.white,
            )
          : Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: ColorConstant.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: ColorConstant.darkBlue.withOpacity(0.7),
                  width: 2,
                ),
              ),
            ),
    );
  }
}
