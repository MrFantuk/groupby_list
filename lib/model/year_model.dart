// import 'dart:convert';
//
import 'dart:convert';

YearModel yearsFromJson(String str) => YearModel.fromJson(json.decode(str));
//
// String yearsToJson(Years data1) => json.encode(data1.toJson());

class YearModel {
  late String status;
  late String message;
  late int totalSize;
  late List<Data> data;
  late List<Data1> data1;

  YearModel(
      {required this.status,
      required this.message,
      required this.totalSize,
      required this.data,
      required this.data1});

  YearModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] as String;
    message = json['message'] as String;
    totalSize = json['totalSize'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    if (json['data1'] != null) {
      data1 = <Data1>[];
      json['data1'].forEach((v) {
        data1.add(new Data1.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['totalSize'] = this.totalSize;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (this.data1 != null) {
      data['data1'] = this.data1.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  late int awardID;
  late String awardName;
  late String awardDescription;
  late String awardImage;
  late Null awardIcon;
  late Null semList;

  Data(
      {required this.awardID,
      required this.awardName,
      required this.awardDescription,
      required this.awardImage,
      this.awardIcon,
      this.semList});

  Data.fromJson(Map<String, dynamic> json) {
    awardID = json['awardID'];
    awardName = json['awardName'];
    awardDescription = json['awardDescription'];
    awardImage = json['awardImage'];
    awardIcon = json['awardIcon'];
    semList = json['SemList'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['awardID'] = this.awardID;
    data['awardName'] = this.awardName;
    data['awardDescription'] = this.awardDescription;
    data['awardImage'] = this.awardImage;
    data['awardIcon'] = this.awardIcon;
    data['SemList'] = this.semList;
    return data;
  }
}

class Data1 {
  late int iD;
  late int awardId;
  late int semesterYear;
  late SemesterDetails semesterDetails;

  Data1(
      {required this.iD,
      required this.awardId,
      required this.semesterYear,
      required this.semesterDetails});

  Data1.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    awardId = json['AwardId'];
    semesterYear = json['SemesterYear'];
    semesterDetails = (json['SemesterDetails'] != null
        ? new SemesterDetails.fromJson(json['SemesterDetails'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['AwardId'] = this.awardId;
    data['SemesterYear'] = this.semesterYear;
    if (this.semesterDetails != null) {
      data['SemesterDetails'] = this.semesterDetails.toJson();
    }
    return data;
  }
}

class SemesterDetails {
  late List<Details> details;

  SemesterDetails({required this.details});

  SemesterDetails.fromJson(Map<String, dynamic> json) {
    if (json['Details'] != null) {
      details = <Details>[];
      json['Details'].forEach((v) {
        details.add(new Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.details != null) {
      data['Details'] = this.details.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  late String semesterID;
  late String semesterName;
  late String status;

  Details(
      {required this.semesterID,
      required this.semesterName,
      required this.status});

  Details.fromJson(Map<String, dynamic> json) {
    semesterID = json['SemesterID'];
    semesterName = json['SemesterName'];
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SemesterID'] = this.semesterID;
    data['SemesterName'] = this.semesterName;
    data['Status'] = this.status;
    return data;
  }
}
