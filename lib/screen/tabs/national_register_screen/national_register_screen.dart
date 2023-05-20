import 'package:flutter/material.dart';
import 'package:vhembe_gov/common/app/app_methods.dart';
import 'package:vhembe_gov/common/app/app_theme.dart';
import 'package:vhembe_gov/common/constant/color_constant.dart';
import 'package:vhembe_gov/common/constant/string_constant.dart';
import 'package:vhembe_gov/common/widgets/custom_datatable.dart';
import 'package:vhembe_gov/common/widgets/custom_expansion_tile.dart';

class NationalRegisterScreen extends StatefulWidget {
  const NationalRegisterScreen({Key? key}) : super(key: key);

  @override
  State<NationalRegisterScreen> createState() => NationalRegisterScreenState();
}

class NationalRegisterScreenState extends State<NationalRegisterScreen> {
  final GlobalKey<CustomExpansionTileState> headerExpansionTileKey =
      GlobalKey<CustomExpansionTileState>();
  final GlobalKey<CustomExpansionTileState> indigentExpansionTileKey =
      GlobalKey<CustomExpansionTileState>();
  String? viewType;
  String? nationalViewType;
  String? provincialViewType;
  String? municipalityType;
  String? municipalityAreaType;
  bool showNational = true;
  bool showResult = false;
  bool isSearchExpand = true;
  bool isIndigentExpand = false;
  bool isWaterExpand = false;
  bool isElectricityExpand = false;
  bool isSewerageExpand = false;
  bool isSolidWasteExpand = false;

  @override
  Widget build(BuildContext context) {
    logs('Current screen --> $runtimeType');
    return Column(
      children: [
        CustomExpansionTile(
          key: headerExpansionTileKey,
          title: Text(
            StringConstant.nationalIndigent.toTitleCase(),
            style: TextStyle(
              color:
                  isSearchExpand ? ColorConstant.darkBlue : ColorConstant.black,
              fontFamily: AppTheme.poppins,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              fontSize: 14,
            ),
          ),
          initiallyExpanded: true,
          trailing: Icon(
            isSearchExpand ? Icons.arrow_drop_up : Icons.arrow_drop_down,
            color:
                isSearchExpand ? ColorConstant.darkBlue : ColorConstant.black,
          ),
          onExpansionChanged: (bool expanded) {
            setState(() => isSearchExpand = expanded);
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
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    hint: Text(
                      StringConstant.selectViewType.toTitleCase(),
                      style: const TextStyle(
                        color: ColorConstant.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    value: viewType,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 16,
                    elevation: 16,
                    isExpanded: true,
                    onChanged: (String? newValue) async {
                      viewType = newValue!;
                      logs('View type --> $viewType');
                      if (viewType == viewTypeList[0]) {
                        showNational = false;
                      } else {
                        showNational = true;
                      }
                      setState(() {});
                    },
                    items: viewTypeList.map<DropdownMenuItem<String>>((item) {
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
                  if (viewType != null) const SizedBox(height: 20),
                  if (viewType != null && !showNational)
                    DropdownButtonFormField<String>(
                      hint: Text(
                        StringConstant.selectOption.toTitleCase(),
                        style: const TextStyle(
                          color: ColorConstant.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      value: nationalViewType,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 16,
                      elevation: 16,
                      isExpanded: true,
                      onChanged: (String? newValue) async {
                        nationalViewType = newValue!;
                        logs('National view type --> $nationalViewType');
                        provincialViewType = null;
                        showResult = true;
                        headerExpansionTileKey.currentState!.handleTap();
                        indigentExpansionTileKey.currentState!.handleTap();
                        setState(() {});
                      },
                      items: nationalViewTypeList
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
                  if (viewType != null && showNational)
                    DropdownButtonFormField<String>(
                      hint: Text(
                        StringConstant.selectOption.toTitleCase(),
                        style: const TextStyle(
                          color: ColorConstant.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      value: provincialViewType,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 16,
                      elevation: 16,
                      isExpanded: true,
                      onChanged: (String? newValue) async {
                        provincialViewType = newValue!;
                        logs('Provisional view type --> $provincialViewType');
                        nationalViewType = null;
                        municipalityType = null;
                        setState(() {});
                      },
                      items: provincialViewTypeList
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
                  if (provincialViewType != null && showNational)
                    const SizedBox(height: 20),
                  if (provincialViewType != null && showNational)
                    DropdownButtonFormField<String>(
                      hint: Text(
                        StringConstant.selectMunicipalityType.toTitleCase(),
                        style: const TextStyle(
                          color: ColorConstant.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      value: municipalityType,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 16,
                      elevation: 16,
                      isExpanded: true,
                      onChanged: (String? newValue) async {
                        municipalityType = newValue!;
                        logs('Municipality view type --> $municipalityType');
                        municipalityAreaType = null;
                        setState(() {});
                      },
                      items: municipalityTypeList
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
                  if (municipalityType != null && showNational)
                    const SizedBox(height: 20),
                  if (municipalityType != null && showNational)
                    DropdownButtonFormField<String>(
                      hint: Text(
                        StringConstant.selectMunicipalityAreaType.toTitleCase(),
                        style: const TextStyle(
                          color: ColorConstant.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      value: municipalityAreaType,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 16,
                      elevation: 16,
                      isExpanded: true,
                      onChanged: (String? newValue) async {
                        municipalityAreaType = newValue!;
                        logs(
                            'Municipality area type --> $municipalityAreaType');
                        showResult = true;
                        headerExpansionTileKey.currentState!.handleTap();
                        indigentExpansionTileKey.currentState!.handleTap();
                        setState(() {});
                      },
                      items: municipalityTypeList
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
                ],
              ),
            ),
          ],
        ),
        if (showResult)
          Column(
            children: [
              CustomExpansionTile(
                key: indigentExpansionTileKey,
                title: Text(
                  StringConstant.indigentHouseHold.toCapitalized(),
                  style: TextStyle(
                    fontFamily: AppTheme.poppins,
                    color: isIndigentExpand
                        ? ColorConstant.darkBlue
                        : ColorConstant.black,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                    fontSize: 14,
                  ),
                ),
                trailing: Icon(
                  isIndigentExpand
                      ? Icons.arrow_drop_up
                      : Icons.arrow_drop_down,
                  color: isIndigentExpand
                      ? ColorConstant.darkBlue
                      : ColorConstant.black,
                ),
                onExpansionChanged: (bool expanded) {
                  setState(() => isIndigentExpand = expanded);
                },
                children: [
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
                      columns: getColumns(),
                      rows: getRows(),
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text(
                  StringConstant.water.toCapitalized(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                    fontSize: 14,
                  ),
                ),
                textColor: isWaterExpand
                    ? ColorConstant.darkBlue
                    : ColorConstant.black,
                iconColor: isWaterExpand
                    ? ColorConstant.darkBlue
                    : ColorConstant.black,
                trailing: Icon(
                  isWaterExpand ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                ),
                onExpansionChanged: (bool expanded) {
                  setState(() => isWaterExpand = expanded);
                },
                children: [
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
                      columns: getColumns(),
                      rows: getRows(),
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text(
                  StringConstant.electricity.toCapitalized(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                    fontSize: 14,
                  ),
                ),
                textColor: isElectricityExpand
                    ? ColorConstant.darkBlue
                    : ColorConstant.black,
                iconColor: isElectricityExpand
                    ? ColorConstant.darkBlue
                    : ColorConstant.black,
                trailing: Icon(
                  isElectricityExpand
                      ? Icons.arrow_drop_up
                      : Icons.arrow_drop_down,
                ),
                onExpansionChanged: (bool expanded) {
                  setState(() => isElectricityExpand = expanded);
                },
                children: [
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
                      columns: getColumns(),
                      rows: getRows(),
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text(
                  StringConstant.sewerage.toCapitalized(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                    fontSize: 14,
                  ),
                ),
                textColor: isSewerageExpand
                    ? ColorConstant.darkBlue
                    : ColorConstant.black,
                iconColor: isSewerageExpand
                    ? ColorConstant.darkBlue
                    : ColorConstant.black,
                trailing: Icon(
                  isSewerageExpand
                      ? Icons.arrow_drop_up
                      : Icons.arrow_drop_down,
                ),
                onExpansionChanged: (bool expanded) {
                  setState(() => isSewerageExpand = expanded);
                },
                children: [
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
                      columns: getColumns(),
                      rows: getRows(),
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text(
                  StringConstant.solidWaste.toCapitalized(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                    fontSize: 14,
                  ),
                ),
                textColor: isSolidWasteExpand
                    ? ColorConstant.darkBlue
                    : ColorConstant.black,
                iconColor: isSolidWasteExpand
                    ? ColorConstant.darkBlue
                    : ColorConstant.black,
                trailing: Icon(
                  isSolidWasteExpand
                      ? Icons.arrow_drop_up
                      : Icons.arrow_drop_down,
                ),
                onExpansionChanged: (bool expanded) {
                  setState(() => isSolidWasteExpand = expanded);
                },
                children: [
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
                      columns: getColumns(),
                      rows: getRows(),
                    ),
                  ),
                ],
              ),
            ],
          ),
      ],
    );
  }

  List<MyDataColumn> getColumns() {
    return indigentHouseholdsHeader
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
    return indigentHouseholds
        .map(
          (e) => MyDataRow(
            color: MaterialStateProperty.resolveWith((states) {
              toggle = !toggle;
              return toggle
                  ? ColorConstant.grey100.withOpacity(0.2)
                  : Colors.transparent;
            }),
            cells: [
              MyDataCell(Text(e['province']!)),
              MyDataCell(Text(e['2017']!)),
              MyDataCell(Text(e['2018']!))
            ],
          ),
        )
        .toList();
  }
}
