// import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vhembe_gov/common/app/app_methods.dart';
import 'package:vhembe_gov/common/constant/color_constant.dart';
import 'package:vhembe_gov/common/constant/string_constant.dart';
import 'package:vhembe_gov/common/widgets/common_checkbox.dart';
import 'package:vhembe_gov/common/widgets/common_elevated_button.dart';
import 'package:vhembe_gov/common/widgets/text_form_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "../../../model/user_model.dart";
import 'package:firebase_storage/firebase_storage.dart';

class ApplicationScreen extends StatefulWidget {
  const ApplicationScreen({Key? key}) : super(key: key);

  @override
  State<ApplicationScreen> createState() => ApplicationScreenState();
}

class ApplicationScreenState extends State<ApplicationScreen> {
  final TextEditingController idNumberController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController birthController = TextEditingController();
  final TextEditingController cellNoController = TextEditingController();
  final TextEditingController cellNo2Controller = TextEditingController();
  final TextEditingController cellNo3Controller = TextEditingController();
  final TextEditingController workCellNoController = TextEditingController();
  final TextEditingController workCellNo2Controller = TextEditingController();
  final TextEditingController workCellNo3Controller = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController address2Controller = TextEditingController();
  final TextEditingController address3Controller = TextEditingController();
  final TextEditingController wardNoController = TextEditingController();
  final TextEditingController suburbsController = TextEditingController();
  final TextEditingController townController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController incomeController = TextEditingController();
  final TextEditingController employerController = TextEditingController();
  final TextEditingController deptNameController = TextEditingController();
  final TextEditingController contactPersonController = TextEditingController();
  final TextEditingController contactNoController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  final ImagePicker imagePicker = ImagePicker();
  List<File> documentImage = <File>[];
  List<String> imageDocumentUrl = <String>[];
  String? nameTitle;
  String? gender;
  String? standType;
  String? jobType;
  DateTime selectedDate = DateTime.now();
  int headOfHousehold = 1;
  int householdDependant = 2;
  int maritalStatus = 1;
  bool isSuspiciousApplication = false;
  bool showResult = false;
  bool isProfileExpand = false;
  bool isContactExpand = false;
  bool isAddressExpand = false;
  bool isEmploymentExpand = false;
  bool isObservationsExpand = false;
  bool isDocsUploadExpand = false;
  final _personalDetailKey = GlobalKey<FormState>();
  final _contactDetailKey = GlobalKey<FormState>();
  final _addressDetailKey = GlobalKey<FormState>();
  final _incomeDetailKey = GlobalKey<FormState>();
  final _observationDetailKey = GlobalKey<FormState>();
  final _documentsDetailKey = GlobalKey<FormState>();
  @override
  void dispose() {
    print("ondispose");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    logs('Current screen --> $runtimeType');
    return Column(
      children: [
        if (!showResult)
          Container(
            padding: const EdgeInsets.all(14),
            margin: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: const Color(0XFFDDDDDD)),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              children: [
                numberTextFormField(idNumberController, StringConstant.idNumber,
                    prefixIcon: Icons.badge_outlined, numLimit: 8),
                const SizedBox(height: 20),
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (idNumberController.text.trim().length < 8) {
                        showMessage(context, StringConstant.idNumberErrorText);
                      } else {
                        showResult = true;
                        setState(() {});
                      }
                    },
                    icon: const Icon(Icons.search, size: 18),
                    label: const Text(
                      StringConstant.newSearchBtn,
                      style: TextStyle(
                        fontSize: 14,
                        color: ColorConstant.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (idNumberController.text.trim().length < 8) {
                        showMessage(context, StringConstant.idNumberErrorText);
                      } else {
                        showResult = true;
                        setState(() {});
                      }
                    },
                    icon: const Icon(Icons.search, size: 18),
                    label: const Text(
                      StringConstant.modifySearchBtn,
                      style: TextStyle(
                        fontSize: 14,
                        color: ColorConstant.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        if (showResult)
          Column(
            children: [
              ExpansionTile(
                title: Text(
                  StringConstant.personalDetails.toTitleCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    fontSize: 14,
                  ),
                ),
                textColor: isProfileExpand
                    ? ColorConstant.darkBlue
                    : ColorConstant.black,
                iconColor: isProfileExpand
                    ? ColorConstant.darkBlue
                    : ColorConstant.black,
                trailing: Icon(
                  isProfileExpand ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                ),
                onExpansionChanged: (bool expanded) {
                  setState(() => isProfileExpand = expanded);
                },
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    margin: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: const Color(0XFFDDDDDD)),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Form(
                      key: _personalDetailKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            StringConstant.personalDetails.toTitleCase(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.8,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 48,
                                  child: DropdownButtonFormField<String>(
                                    hint: Text(
                                      StringConstant.relation.toTitleCase(),
                                      style: const TextStyle(
                                        color: ColorConstant.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    value: nameTitle,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    iconSize: 14,
                                    elevation: 16,
                                    isExpanded: true,
                                    onChanged: (String? newValue) async {
                                      nameTitle = newValue!;
                                      logs('Title --> $nameTitle');
                                      setState(() {});
                                    },
                                    items: nameTitleList
                                        .map<DropdownMenuItem<String>>((item) {
                                      return DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                flex: 3,
                                child: nameTextFormField(firstNameController,
                                    StringConstant.firstName,
                                //     textValidator: (value) {
                                //   if (value!.isEmpty) {
                                //     print("please enter first name");
                                //     return "kjdsa";
                                //   }
                                //   return "ok it is fine ";
                                // }
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          nameTextFormField(
                              secondNameController, StringConstant.secondName),
                          const SizedBox(height: 20),
                          nameTextFormField(
                              surnameController, StringConstant.surname),
                          const SizedBox(height: 20),
                          numberTextFormField(
                              idNumberController, StringConstant.idNumber,
                              prefixIcon: Icons.badge_outlined, numLimit: 8),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: calenderTextFormField(birthController,
                                    StringConstant.dateOfBirth, selectDate),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: SizedBox(
                                  height: 48,
                                  child: DropdownButtonFormField<String>(
                                    hint: Text(
                                      StringConstant.gender.toTitleCase(),
                                      style: const TextStyle(
                                        color: ColorConstant.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    value: gender,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    iconSize: 14,
                                    elevation: 16,
                                    isExpanded: true,
                                    onChanged: (String? newValue) async {
                                      gender = newValue!;
                                      logs('Title --> $gender');
                                      setState(() {});
                                    },
                                    items: genderList
                                        .map<DropdownMenuItem<String>>((item) {
                                      return DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  StringConstant.headOfHousehold,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.zero,
                                  itemCount: optionsList.length,
                                  itemBuilder: (context, index) => Row(
                                    children: [
                                      Radio(
                                        value: index + 1,
                                        groupValue: headOfHousehold,
                                        activeColor: ColorConstant.grey,
                                        onChanged: (int? value) {
                                          headOfHousehold = value!;
                                          logs('message --> $headOfHousehold');
                                          setState(() {});
                                        },
                                      ),
                                      Text(
                                        optionsList[index],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: ColorConstant.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w200,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  StringConstant.householdDependant,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.zero,
                                  itemCount: optionsList.length,
                                  itemBuilder: (context, index) => Row(
                                    children: [
                                      Radio(
                                        value: index + 1,
                                        groupValue: householdDependant,
                                        activeColor: ColorConstant.grey,
                                        onChanged: (int? value) {
                                          householdDependant = value!;
                                          logs(
                                              'message --> $householdDependant');
                                          setState(() {});
                                        },
                                      ),
                                      Text(
                                        optionsList[index],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: ColorConstant.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w200,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  StringConstant.maritalStatus,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.zero,
                                  itemCount: optionsList.length,
                                  itemBuilder: (context, index) => Row(
                                    children: [
                                      Radio(
                                        value: index + 1,
                                        groupValue: maritalStatus,
                                        activeColor: ColorConstant.grey,
                                        onChanged: (int? value) {
                                          maritalStatus = value!;
                                          logs('message --> $maritalStatus');

                                          setState(() {});
                                        },
                                      ),
                                      Text(
                                        maritalList[index],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: ColorConstant.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w200,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text(
                  StringConstant.contactDetails.toTitleCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                    fontSize: 14,
                  ),
                ),
                textColor: isContactExpand
                    ? ColorConstant.darkBlue
                    : ColorConstant.black,
                iconColor: isContactExpand
                    ? ColorConstant.darkBlue
                    : ColorConstant.black,
                trailing: Icon(
                  isContactExpand ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                ),
                onExpansionChanged: (bool expanded) {
                  setState(() => isContactExpand = expanded);
                },
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    margin: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: const Color(0XFFDDDDDD)),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Form(
                      key: _contactDetailKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            StringConstant.contactDetails.toTitleCase(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.8,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 14),
                          numberTextFormField(
                              cellNoController, StringConstant.cellNo),
                          const SizedBox(height: 20),
                          numberTextFormField(
                              cellNo2Controller, StringConstant.cellNo2),
                          const SizedBox(height: 20),
                          numberTextFormField(
                              cellNo3Controller, StringConstant.cellNo3),
                          const SizedBox(height: 20),
                          numberTextFormField(
                              workCellNoController, StringConstant.workCellNo),
                          const SizedBox(height: 20),
                          numberTextFormField(workCellNo2Controller,
                              StringConstant.workCellNo2),
                          const SizedBox(height: 20),
                          numberTextFormField(workCellNo3Controller,
                              StringConstant.workCellNo3),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text(
                  StringConstant.addressDetails.toTitleCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                    fontSize: 14,
                  ),
                ),
                textColor: isAddressExpand
                    ? ColorConstant.darkBlue
                    : ColorConstant.black,
                iconColor: isAddressExpand
                    ? ColorConstant.darkBlue
                    : ColorConstant.black,
                trailing: Icon(
                  isAddressExpand ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                ),
                onExpansionChanged: (bool expanded) {
                  setState(() => isAddressExpand = expanded);
                },
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    margin: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: const Color(0XFFDDDDDD)),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Form(
                      key: _addressDetailKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            StringConstant.addressDetails.toTitleCase(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.8,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 14),
                          SizedBox(
                            height: 48,
                            child: DropdownButtonFormField<String>(
                              hint: Text(
                                StringConstant.standType.toTitleCase(),
                                style: const TextStyle(
                                  color: ColorConstant.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              value: standType,
                              icon: const Icon(Icons.arrow_drop_down),
                              iconSize: 14,
                              elevation: 16,
                              isExpanded: true,
                              onChanged: (String? newValue) async {
                                standType = newValue!;
                                logs('Title --> $standType');
                                setState(() {});
                              },
                              items: standTypeList
                                  .map<DropdownMenuItem<String>>((item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          nameTextFormField(
                              addressController, StringConstant.address,
                              prefixIcon: Icons.home),
                          const SizedBox(height: 20),
                          nameTextFormField(
                              address2Controller, StringConstant.address2,
                              prefixIcon: Icons.home),
                          const SizedBox(height: 20),
                          nameTextFormField(
                              address3Controller, StringConstant.address3,
                              prefixIcon: Icons.home),
                          const SizedBox(height: 20),
                          numberTextFormField(
                              wardNoController, StringConstant.wardNo,
                              prefixIcon: Icons.streetview),
                          const SizedBox(height: 20),
                          nameTextFormField(
                              suburbsController, StringConstant.suburbs,
                              prefixIcon: Icons.apartment),
                          const SizedBox(height: 20),
                          nameTextFormField(townController, StringConstant.town,
                              prefixIcon: Icons.gite),
                          const SizedBox(height: 20),
                          numberTextFormField(
                              postalCodeController, StringConstant.postalCode,
                              prefixIcon: Icons.markunread_mailbox,
                              numLimit: 6),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text(
                  StringConstant.employment.toCapitalized(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                    fontSize: 14,
                  ),
                ),
                textColor: isEmploymentExpand
                    ? ColorConstant.darkBlue
                    : ColorConstant.black,
                iconColor: isEmploymentExpand
                    ? ColorConstant.darkBlue
                    : ColorConstant.black,
                trailing: Icon(
                  isEmploymentExpand
                      ? Icons.arrow_drop_up
                      : Icons.arrow_drop_down,
                ),
                onExpansionChanged: (bool expanded) {
                  setState(() => isEmploymentExpand = expanded);
                },
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    margin: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: const Color(0XFFDDDDDD)),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Form(
                      key: _incomeDetailKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            StringConstant.employment.toCapitalized(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.8,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 14),
                          numberTextFormField(
                              incomeController, StringConstant.income,
                              prefixIcon: Icons.money),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 48,
                            child: DropdownButtonFormField<String>(
                              hint: Text(
                                'Please select'.toTitleCase(),
                                style: const TextStyle(
                                  color: ColorConstant.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              value: jobType,
                              icon: const Icon(Icons.arrow_drop_down),
                              iconSize: 14,
                              elevation: 16,
                              isExpanded: true,
                              onChanged: (String? newValue) async {
                                jobType = newValue!;
                                logs('Title --> $jobType');
                                setState(() {});
                              },
                              items: jobTypeList
                                  .map<DropdownMenuItem<String>>((item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          nameTextFormField(
                              employerController, StringConstant.employer,
                              prefixIcon: Icons.person),
                          const SizedBox(height: 20),
                          nameTextFormField(
                              deptNameController, StringConstant.dept,
                              prefixIcon: Icons.apartment),
                          const SizedBox(height: 20),
                          nameTextFormField(contactPersonController,
                              StringConstant.contactPerson,
                              prefixIcon: Icons.person),
                          const SizedBox(height: 20),
                          numberTextFormField(
                              contactNoController, StringConstant.contactNo,
                              prefixIcon: Icons.call),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text(
                  StringConstant.observation.toCapitalized(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                    fontSize: 14,
                  ),
                ),
                textColor: isObservationsExpand
                    ? ColorConstant.darkBlue
                    : ColorConstant.black,
                iconColor: isObservationsExpand
                    ? ColorConstant.darkBlue
                    : ColorConstant.black,
                trailing: Icon(
                  isObservationsExpand
                      ? Icons.arrow_drop_up
                      : Icons.arrow_drop_down,
                ),
                onExpansionChanged: (bool expanded) {
                  setState(() => isObservationsExpand = expanded);
                },
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    margin: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: const Color(0XFFDDDDDD)),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Form(
                      key: _observationDetailKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            StringConstant.observation.toCapitalized(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.8,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 14),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSuspiciousApplication =
                                    !isSuspiciousApplication;
                              });
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonCheckBox(
                                    checkBox: isSuspiciousApplication),
                                const SizedBox(width: 14),
                                const Text(
                                    StringConstant.suspiciousApplication),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          nameTextFormField(
                              commentController, StringConstant.comments,
                              maxLines: 5,
                              keyboardType: TextInputType.multiline,
                              prefixIcon: Icons.chat)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text(
                  StringConstant.uploadDocs.toCapitalized(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                    fontSize: 14,
                  ),
                ),
                textColor: isDocsUploadExpand
                    ? ColorConstant.darkBlue
                    : ColorConstant.black,
                iconColor: isDocsUploadExpand
                    ? ColorConstant.darkBlue
                    : ColorConstant.black,
                trailing: Icon(
                  isDocsUploadExpand
                      ? Icons.arrow_drop_up
                      : Icons.arrow_drop_down,
                ),
                onExpansionChanged: (bool expanded) {
                  setState(() => isDocsUploadExpand = expanded);
                },
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    margin: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: const Color(0XFFDDDDDD)),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Form(
                      key: _documentsDetailKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            StringConstant.uploadDocs.toCapitalized(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.8,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Container(
                            height: MediaQuery.of(context).size.width * 0.3,
                            alignment: Alignment.centerLeft,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemCount: documentImage.isEmpty
                                  ? 1
                                  : documentImage.length + 1,
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  return GestureDetector(
                                    onTap: documentImages,
                                    child: Container(
                                      width: 110,
                                      margin: const EdgeInsets.only(right: 14),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: ColorConstant.grey100),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(Icons.add,
                                              color: ColorConstant.grey100),
                                          Text(
                                            StringConstant.selectImages,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: ColorConstant.grey100,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                return Stack(
                                  children: [
                                    Container(
                                      width: 110,
                                      padding: const EdgeInsets.all(1),
                                      margin: EdgeInsets.only(
                                          right: index == documentImage.length
                                              ? 0
                                              : 14),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: ColorConstant.grey100),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          documentImage[index - 1],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 7,
                                      child: GestureDetector(
                                        onTap: () {
                                          documentImage.removeAt(index - 1);
                                          setState(() {});
                                        },
                                        child: CircleAvatar(
                                          radius: 12,
                                          backgroundColor: ColorConstant
                                              .darkBlue
                                              .withOpacity(0.5),
                                          child: const Icon(Icons.close,
                                              size: 14,
                                              color: ColorConstant.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CommonElevatedButton(
                horizontalMargin: 14,
                buttonName: StringConstant.submitApplication,
                onPressed: () => submitApplication(),
              ),
              const SizedBox(height: 20),
            ],
          ),
      ],
    );
  }

  void selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000, 1),
      lastDate: DateTime.now(),
      builder: (BuildContext? context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            dialogBackgroundColor: ColorConstant.white,
            colorScheme: const ColorScheme.light(
              primary: ColorConstant.darkBlue,
              onSurface: ColorConstant.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      selectedDate = picked;
      birthController.text = picked.toIso8601String().split('T')[0].trim();
      setState(() {});
    }
  }

  void documentImages() async {
    List<XFile>? galleryImage =
        await imagePicker.pickMultiImage(imageQuality: 100);
    if (galleryImage != null && galleryImage.isNotEmpty) {
      for (var element in galleryImage) {
        documentImage.add(File(element.path));
      }
      logs('Document Image from Gallery --> $documentImage');
      setState(() {});
    }
  }

  void submitApplication() async{
    print("nsome+${_personalDetailKey.currentState}");
      var id = idNumberController.text;

     await _uploadImages(id);
     await uploadingData(id);
     
    

    // if (_personalDetailKey.currentState?.validate() == true) {
      setState(() {
        showResult = false;
      });
      disposeControllers();
    // }
  }

  Future<void> uploadingData(String id) async {
 await FirebaseFirestore.instance.collection('users_data').doc(id+"_"+firstNameController.text).set(User(
            address: addressController.text,
            address2: address2Controller.text,
            address3: address3Controller.text,
            contactNumber: contactNoController.text,
            contactPersonName: contactPersonController.text,
            department: deptNameController.text,
            dob: birthController.text,
            documents: imageDocumentUrl,
            ename: employerController.text,
            firstName: firstNameController.text,
            gender: gender??"",
            hasDependants: householdDependant,
            headOfHouseHold: headOfHousehold,
            income: incomeController.text,
            isSuspiciousApplication: isSuspiciousApplication,
            maritalStatus: maritalStatus,
            observation: commentController.text,
            phoneNumber: cellNoController.text,
            phoneNumber2: cellNo2Controller.text,
            phoneNumber3: cellNo3Controller.text,
            postalcode: postalCodeController.text,
            professionType: jobType??"",
            relation: nameTitle??"",  
            secondName: secondNameController.text,
            standType: standType??"",
            suburbs: suburbsController.text,
            surname: surnameController.text,
            town: townController.text,
            userId: idNumberController.text,
            wardNo: wardNoController.text,
            workNumber: workCellNoController.text,
            workNumber2: workCellNo2Controller.text,
            workNumber3: workCellNo3Controller.text)
        .toJson());
        

  }

  // Future<void> _uploadImage() async {
  //   // Get a reference to the Firebase storage bucket
  //   final storage = FirebaseStorage.instance;

  //   // Upload the file to the Firebase storage bucket
  //   var item = documentImage[0];
  //   var name = item.path.split('/').last;

  //   print("name $name");
  //   var id = idNumberController.text;
  //   final ref = storage.ref().child('images/id/$name');

  //   final task = ref.putFile(item);

  //   // Listen for upload progress even
  //   task.whenComplete(() async {
  //     final downloadUrl = await ref.getDownloadURL();
  //     print('Download URL: $downloadUrl');
  //   });
 
Future<void> _uploadImages(String id) async {
  final storage = FirebaseStorage.instance;

  // Create a list to hold all the tasks
  final tasks = <Future>[];

  // Loop over the list of images and upload each one
  for (final image in documentImage) {
    final reference = storage.ref().child('images/$id/${image.path.split('/').last}');
    final task = reference.putFile(image);
    // Listen for upload progress events
    task.whenComplete(() async {
      final downloadUrl = await reference.getDownloadURL();
      imageDocumentUrl.add(downloadUrl);
    });
    // Add the task to the list
    tasks.add(task);
  }

  // Wait for all the tasks to complete before returning
  await Future.wait(tasks);
  }
  
  void disposeControllers() {
      [
        idNumberController, 
        firstNameController,
        secondNameController,
        surnameController, 
        birthController, 
        cellNoController, 
        cellNo2Controller, 
        cellNo3Controller, 
        workCellNoController, 
        workCellNo2Controller, 
        workCellNo3Controller, 
        addressController, 
        address2Controller, 
        address3Controller, 
        wardNoController, 
        suburbsController, 
        townController, 
        postalCodeController, 
        incomeController, 
        employerController, 
        deptNameController, 
        contactPersonController, 
        contactNoController, 
        commentController 
      ]
    .forEach((controller) => controller.clear());
  }

}