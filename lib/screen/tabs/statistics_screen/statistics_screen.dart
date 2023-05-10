import 'package:flutter/material.dart';
import 'package:vhembe_gov/common/app/app_methods.dart';
import 'package:vhembe_gov/common/constant/color_constant.dart';
import 'package:vhembe_gov/common/constant/string_constant.dart';
import 'package:vhembe_gov/common/widgets/common_elevated_button.dart';
import 'package:vhembe_gov/common/widgets/custom_datatable.dart';
import 'package:vhembe_gov/common/widgets/text_form_fields.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  State<StatisticsScreen> createState() => StatisticsScreenState();
}

class StatisticsScreenState extends State<StatisticsScreen> {
  final TextEditingController birthController = TextEditingController();
  String? statusValue;
  String? wardValue;
  String? commentValue;
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    logs('Current screen --> $runtimeType');
    return Column(
      children: [
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
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 48,
                      child: DropdownButtonFormField<String>(
                        hint: Text(
                          StringConstant.status.toTitleCase(),
                          style: const TextStyle(
                            color: ColorConstant.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        value: statusValue,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 14,
                        elevation: 16,
                        isExpanded: true,
                        onChanged: (String? newValue) async {
                          statusValue = newValue!;
                          logs('Status Value --> $statusValue');
                          setState(() {});
                        },
                        items: statusList.map<DropdownMenuItem<String>>((item) {
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
                  const SizedBox(width: 8),
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: DropdownButtonFormField<String>(
                        hint: Text(
                          StringConstant.ward.toTitleCase(),
                          style: const TextStyle(
                            color: ColorConstant.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        value: wardValue,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 14,
                        elevation: 16,
                        isExpanded: true,
                        onChanged: (String? newValue) async {
                          wardValue = newValue!;
                          logs('Ward value --> $wardValue');
                          setState(() {});
                        },
                        items: wardsList.map<DropdownMenuItem<String>>((item) {
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
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: DropdownButtonFormField<String>(
                        hint: Text(
                          StringConstant.comments.toTitleCase(),
                          style: const TextStyle(
                            color: ColorConstant.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        value: commentValue,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 14,
                        elevation: 16,
                        isExpanded: true,
                        onChanged: (String? newValue) async {
                          commentValue = newValue!;
                          logs('Status Value --> $commentValue');
                          setState(() {});
                        },
                        items:
                            commentsList.map<DropdownMenuItem<String>>((item) {
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
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: calenderTextFormField(birthController,
                        StringConstant.dateOfBirth, selectDate),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: CommonElevatedButton(
                      horizontalMargin: 0,
                      onPressed: () {},
                      buttonName: StringConstant.viewReports,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CommonElevatedButton(
                      horizontalMargin: 0,
                      onPressed: () {},
                      buttonName: StringConstant.clear,
                      textColor: ColorConstant.black,
                      buttonColor: ColorConstant.grey100.withOpacity(0.3),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          StringConstant.overallStats,
          style: TextStyle(
            color: ColorConstant.darkBlue,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Divider(
          color: Colors.blue,
          thickness: 1.6,
          endIndent: 14,
          indent: 14,
          height: 4,
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 14),
          child: MyDataTable(
            showCheckboxColumn: false,
            columnSpacing: 12,
            horizontalMargin: 12,
            headingTextStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorConstant.darkBlue,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: ColorConstant.grey),
            ),
            headingRowColor:
                MaterialStateProperty.all(ColorConstant.lightOrange),
            columns: getColumns(statisticsHeader),
            rows: getRows(),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: double.parse((48 * (agentList.length + 1)).toString()),
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 14, right: 14),
            physics: const BouncingScrollPhysics(),
            children: [
              MyDataTable(
                showCheckboxColumn: false,
                columnSpacing: 12,
                horizontalMargin: 12,
                headingTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.darkBlue,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: ColorConstant.grey),
                ),
                headingRowColor:
                    MaterialStateProperty.all(ColorConstant.lightOrange),
                columns: getColumns(agentsListHeader),
                rows: getAgentRows(),
              ),
            ],
          ),
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

  List<MyDataColumn> getColumns(List<Map<String, String>> getHeader) {
    return getHeader
        .map(
          (e) => MyDataColumn(
            label: Text(
              e['header']!,
              style: const TextStyle(
                fontSize: 14,
                color: ColorConstant.darkBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
        .toList();
  }

  List<MyDataRow> getRows() {
    bool toggle = true;
    return statistics
        .map(
          (e) => MyDataRow(
            color: MaterialStateProperty.resolveWith((states) {
              toggle = !toggle;
              return toggle
                  ? ColorConstant.grey100.withOpacity(0.2)
                  : Colors.transparent;
            }),
            cells: [
              MyDataCell(Text(e['status']!)),
              MyDataCell(Text(e['counts']!))
            ],
          ),
        )
        .toList();
  }

  List<MyDataRow> getAgentRows() {
    bool toggle = true;
    return agentList
        .map(
          (e) => MyDataRow(
            color: MaterialStateProperty.resolveWith((states) {
              toggle = !toggle;
              return toggle
                  ? ColorConstant.grey100.withOpacity(0.2)
                  : Colors.transparent;
            }),
            cells: [
              MyDataCell(Text(e['agentId']!)),
              MyDataCell(Text(e['displayName']!)),
              MyDataCell(Text(e['userName']!)),
              MyDataCell(Text(e['name']!)),
              MyDataCell(Text(e['surname']!)),
              MyDataCell(Text(e['counts']!)),
            ],
          ),
        )
        .toList();
  }
}
