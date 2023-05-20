import 'package:flutter/material.dart';
import 'package:vhembe_gov/common/constant/color_constant.dart';
import 'package:vhembe_gov/common/constant/string_constant.dart';
import 'package:vhembe_gov/common/widgets/common_elevated_button.dart';

class CustomAlertDialog extends StatefulWidget {
  final String title;
  final String? message;
  final bool isAction;
  final GestureTapCallback? onTap;

  const CustomAlertDialog({
    Key? key,
    this.title = 'Message',
    @required this.message,
    this.isAction = false,
    this.onTap,
  }) : super(key: key);

  @override
  CustomAlertDialogState createState() => CustomAlertDialogState();
}

class CustomAlertDialogState extends State<CustomAlertDialog>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    scaleAnimation =
        CurvedAnimation(parent: controller!, curve: Curves.elasticInOut);

    controller!.addListener(() {
      setState(() {});
    });

    controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation!,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              color: ColorConstant.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: ColorConstant.darkBlue,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      color: ColorConstant.white,
                      fontSize: 16,
                      wordSpacing: 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  alignment: Alignment.center,
                  height: 100,
                  width: double.infinity,
                  child: Text(
                    widget.message!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: ColorConstant.black,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                widget.isAction
                    ? Row(
                        children: [
                          const Spacer(),
                          CommonElevatedButton(
                            width: 80,
                            buttonName: StringConstant.yes,
                            onPressed: widget.onTap,
                          ),
                          const Spacer(),
                          CommonElevatedButton(
                            width: 80,
                            buttonName: StringConstant.no,
                            onPressed: () => Navigator.pop(context),
                          ),
                          const Spacer(),
                        ],
                      )
                    : GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          decoration: const BoxDecoration(
                            color: ColorConstant.darkBlue,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                          ),
                          child: const Text(
                            StringConstant.okay,
                            style: TextStyle(
                              color: ColorConstant.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                if (widget.isAction) const SizedBox(height: 8)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
