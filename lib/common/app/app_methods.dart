import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vhembe_gov/common/app/app_theme.dart';
import 'package:vhembe_gov/common/constant/color_constant.dart';
import 'package:vhembe_gov/common/constant/image_constant.dart';
import 'package:vhembe_gov/common/constant/string_constant.dart';
import 'package:vhembe_gov/common/widgets/common_alert_dialog.dart';
import 'package:vhembe_gov/model/drawer_options_model.dart';

List<DrawerOptionModel> drawerOptions = [
  DrawerOptionModel(
      drawerImage: ImageConstant.drawerHomeIcon,
      drawerName: StringConstant.home),
  DrawerOptionModel(
      drawerImage: ImageConstant.drawerApplicationIcon,
      drawerName: StringConstant.application),
  DrawerOptionModel(
      drawerImage: ImageConstant.drawerNationalRegisterIcon,
      drawerName: StringConstant.nationalRegister),
  DrawerOptionModel(
      drawerImage: ImageConstant.drawerStatisticsIcon,
      drawerName: StringConstant.statistics),
];
List<String> nameTitleList = ['Mr', 'Mrs', 'Miss', 'Dr', 'Prof'];
List<String> genderList = ['Male', 'Female'];
List<String> optionsList = ['Yes', 'No'];
List<String> maritalList = ['Single', 'Married'];
List<String> standTypeList = ['Residential', 'Commercial', 'Both'];
List<String> jobTypeList = [
  'Employed',
  'Self Employed',
  'SASSA Beneficiary',
  'Other'
];
List<String> viewTypeList = ['National', 'Provincial'];
List<String> nationalViewTypeList = ['South Africa'];
List<String> provincialViewTypeList = [
  'Eastern Cape',
  'Free State',
  'Gauteng',
  'KwaZulu-Natal',
  'Limpopo',
  'Mpumalanga',
  'Northern Cape',
  'North West',
  'Western Cape'
];
List<String> municipalityTypeList = [
  'All',
  'Metropolitan municipalities',
  'District municipalities'
];
List<Map<String, String>> indigentHouseholdsHeader = [
  {'header': 'Province'},
  {'header': '2017'},
  {'header': '2018'},
];
List<Map<String, String>> indigentHouseholds = [
  {'province': 'Western cape', '2017': '349 484', '2018': '370 639'},
  {'province': 'Eastern Cape', '2017': '349 484', '2018': '370 639'},
  {'province': 'Northern cape', '2017': '349 484', '2018': '370 639'},
  {'province': 'Free State', '2017': '349 484', '2018': '370 639'},
  {'province': 'Kwazulu Natal', '2017': '349 484', '2018': '370 639'},
  {'province': 'Gauteng', '2017': '349 484', '2018': '370 639'},
  {'province': 'Mpumalanga', '2017': '349 484', '2018': '370 639'},
  {'province': 'Limpopo', '2017': '349 484', '2018': '370 639'},
  {'province': 'South Africa', '2017': '3 511 741', '2018': '2 647 979'},
];
List<String> statusList = ['All Statuses', 'Approved', 'Declined'];
List<String> wardsList = ['All Wards', '5', '6', '10', '14', '25', '33', '167'];
List<String> commentsList = ['All Selections', 'Yes', 'No'];
List<Map<String, String>> statisticsHeader = [
  {'header': 'Status'},
  {'header': 'Counts'},
];
List<Map<String, String>> statistics = [
  {'status': 'Applications', 'counts': '10'},
  {'status': 'Approved', 'counts': '3'},
  {'status': 'Declined', 'counts': '7'},
];
List<Map<String, String>> agentsListHeader = [
  {'header': 'AgentId'},
  {'header': 'Display Name'},
  {'header': 'Username'},
  {'header': 'Name'},
  {'header': 'Surname'},
  {'header': 'Count'},
];
List<Map<String, String>> agentList = [
  {
    'agentId': '2',
    'displayName': 'Rofhiwa Mudau',
    'userName': 'rofhiwa@mibureau.co.za',
    'name': 'Rofhiwa',
    'surname': 'Mudau',
    'counts': '7'
  },
  {
    'agentId': '1',
    'displayName': 'Thabo Modjadji',
    'userName': 'modjadjitg@gmail.com',
    'name': 'Thabo',
    'surname': 'Modjadji',
    'counts': '3'
  }
];

void logs(String message) {
  if (kDebugMode) {
    print(message);
  }
}

showMessage(BuildContext context, String message,
    {Color textColor = ColorConstant.themeScaffold,
    Color? backgroundColor,
    bool isError = true}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor:
          isError ? ColorConstant.red.withOpacity(0.6) : backgroundColor,
      content: Text(
        message,
        style: TextStyle(
          fontFamily: AppTheme.poppins,
          color: textColor,
          fontWeight: FontWeight.w400,
          wordSpacing: 1,
          fontSize: 14,
        ),
      ),
    ),
  );
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

Connectivity connectivity = Connectivity();

Future<bool> isConnectNetworkWithMessage(BuildContext context,
    {bool showToast = true}) async {
  ConnectivityResult connectivityResult =
      await connectivity.checkConnectivity();
  bool isConnect = getConnectionValue(connectivityResult);
  if (!isConnect && showToast) {
    showDialog(
      context: context,
      builder: (_) =>
          const CustomAlertDialog(message: StringConstant.noInternet),
    );
  }
  return isConnect;
}

bool getConnectionValue(ConnectivityResult connectivityResult) {
  bool status = false;
  switch (connectivityResult) {
    case ConnectivityResult.mobile:
      status = true;
      break;
    case ConnectivityResult.wifi:
      status = true;
      break;
    case ConnectivityResult.ethernet:
      status = true;
      break;
    case ConnectivityResult.none:
      status = false;
      break;
    default:
      status = false;
      break;
  }
  return status;
}
