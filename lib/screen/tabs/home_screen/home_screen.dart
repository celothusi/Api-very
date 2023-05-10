import 'package:flutter/material.dart';
import 'package:vhembe_gov/common/app/app_methods.dart';
import 'package:vhembe_gov/common/constant/color_constant.dart';
import 'package:vhembe_gov/common/constant/string_constant.dart';
import 'package:vhembe_gov/common/widgets/text_form_fields.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController idNumberController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController cellNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    logs('Current screen --> $runtimeType');
    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: const Color(0XFFDDDDDD)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          nameTextFormField(nameController, StringConstant.name),
          const SizedBox(height: 20),
          numberTextFormField(idNumberController, StringConstant.idNumber,
              prefixIcon: Icons.badge_outlined, numLimit: 8),
          const SizedBox(height: 20),
          nameTextFormField(surnameController, StringConstant.surname),
          const SizedBox(height: 20),
          numberTextFormField(cellNoController, StringConstant.cellNo),
          const SizedBox(height: 20),
          SizedBox(
            height: 40,
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                if (nameController.text.trim().length < 3) {
                  showMessage(context, StringConstant.nameErrorText);
                } else if (idNumberController.text.trim().length < 8) {
                  showMessage(context, StringConstant.idNumberErrorText);
                } else if (surnameController.text.trim().length < 3) {
                  showMessage(context, StringConstant.surnameErrorText);
                } else if (cellNoController.text.trim().length < 10) {
                  showMessage(context, StringConstant.cellNoErrorText);
                } else {
                  showMessage(context, StringConstant.searchValidate,
                      isError: false);
                }
              },
              icon: const Icon(Icons.search, size: 18),
              label: const Text(
                StringConstant.searchBtn,
                style: TextStyle(
                  fontSize: 14,
                  color: ColorConstant.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
