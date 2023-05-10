
import 'package:json_annotation/json_annotation.dart';


@JsonSerializable()
class User {
  final String address;
  final String address2;
  final String address3;
  final String contactNumber;
  final String contactPersonName;
  final String department;
  final String dob;
  final List documents;
  final String ename;
  final String firstName;
  final String gender;
  final int hasDependants;
  final int headOfHouseHold;
  final String income;
  final bool isSuspiciousApplication;
  final int maritalStatus;
  final String observation;
  final String phoneNumber;
  final String phoneNumber2;
  final String phoneNumber3;
  final String postalcode;
  final String professionType;
  final String relation;
  final String secondName;
  final String standType;
  final String suburbs;
  final String surname;
  final String town;
  final String userId;
  final String wardNo;
  final String workNumber;
  final String workNumber2;
  final String workNumber3;

  User({
    required this.address,
    required this.address2,
    required this.address3,
    required this.contactNumber,
    required this.contactPersonName,
    required this.department,
    required this.dob,
    required this.documents,
    required this.ename,
    required this.firstName,
    required this.gender,
    required this.hasDependants,
    required this.headOfHouseHold,
    required this.income,
    required this.isSuspiciousApplication,
    required this.maritalStatus,
    required this.observation,
    required this.phoneNumber,
    required this.phoneNumber2,
    required this.phoneNumber3,
    required this.postalcode,
    required this.professionType,
    required this.relation,
    required this.secondName,
    required this.standType,
    required this.suburbs,
    required this.surname,
    required this.town,
    required this.userId,
    required this.wardNo,
    required this.workNumber,
    required this.workNumber2,
    required this.workNumber3,
  });

  // factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);


  // GENERATED CODE - DO NOT MODIFY BY HAND

// GENERATED CODE - DO NOT MODIFY BY HAND



// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    address: json['address'] as String,
    address2: json['address2'] as String,
    address3: json['address3'] as String,
    contactNumber: json['contactNumber'] as String,
    contactPersonName: json['contactPersonName'] as String,
    department: json['department'] as String,
    dob: json['dob'] as String,
    documents: json['documents'] as List,
    ename: json['ename'] as String,
    firstName: json['firstName'] as String,
    gender: json['gender'] as String,
    hasDependants: json['hasDependants'] as int,
    headOfHouseHold: json['headOfHouseHold'] as int,
    income: json['income'] as String,
    isSuspiciousApplication: json['isSuspiciousApplication'] as bool,
    maritalStatus: json['maritalStatus'] as int,
    observation: json['observation'] as String,
    phoneNumber: json['phoneNumber'] as String,
    phoneNumber2: json['phoneNumber2'] as String,
    phoneNumber3: json['phoneNumber3'] as String,
    postalcode: json['postalcode'] as String,
    professionType: json['professionType'] as String,
    relation: json['relation'] as String,
    secondName: json['secondName'] as String,
    standType: json['standType'] as String,
    suburbs: json['suburbs'] as String,
    surname: json['surname'] as String,
    town: json['town'] as String,
    userId: json['userId'] as String,
    wardNo: json['wardNo'] as String,
    workNumber: json['workNumber'] as String,
    workNumber2: json['workNumber2'] as String,
    workNumber3: json['workNumber3'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'address': instance.address,
      'address2': instance.address2,
      'address3': instance.address3,
      'contactNumber': instance.contactNumber,
      'contactPersonName': instance.contactPersonName,
      'department': instance.department,
      'dob': instance.dob,
      'documents': instance.documents,
      'ename': instance.ename,
      'firstName': instance.firstName,
      'gender': instance.gender,
      'hasDependants': instance.hasDependants,
      'headOfHouseHold': instance.headOfHouseHold,
      'income': instance.income,
      'isSuspiciousApplication': instance.isSuspiciousApplication,
      'maritalStatus': instance.maritalStatus,
      'observation': instance.observation,
      'phoneNumber': instance.phoneNumber,
      'phoneNumber2': instance.phoneNumber2,
      'phoneNumber3': instance.phoneNumber3,
      'postalcode': instance.postalcode,
      'professionType': instance.professionType,
      'relation': instance.relation,
      'secondName': instance.secondName,
      'standType': instance.standType,
      'suburbs': instance.suburbs,
      'surname': instance.surname,
      'town': instance.town,
      'userId': instance.userId,
      'wardNo': instance.wardNo,
      'workNumber': instance.workNumber,
      'workNumber2': instance.workNumber2,
      'workNumber3': instance.workNumber3,
};
}

