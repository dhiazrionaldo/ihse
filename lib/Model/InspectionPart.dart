class InspectionPartModel {
  MItem1? mItem1;
  List<MItem2>? mItem2;

  InspectionPartModel({this.mItem1, this.mItem2});

  InspectionPartModel.fromJson(Map<String, dynamic> json) {
    mItem1 =
        json['m_Item1'] != null ? new MItem1.fromJson(json['m_Item1']) : null;
    if (json['m_Item2'] != null) {
      mItem2 = <MItem2>[];
      json['m_Item2'].forEach((v) {
        mItem2!.add(new MItem2.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mItem1 != null) {
      data['m_Item1'] = this.mItem1!.toJson();
    }
    if (this.mItem2 != null) {
      data['m_Item2'] = this.mItem2!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MItem1 {
  int? id;
  String? equipmentCode;
  String? equipmentName;
  int? weight;
  int? categoryId;
  String? categoryName;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  String? validateAt;
  String? validateBy;
  String? tagNumber;
  int? score;
  int? listCount;
  double? percentage;
  List? inspectionParts;

  MItem1(
      {this.id,
      this.equipmentCode,
      this.equipmentName,
      this.weight,
      this.categoryId,
      this.categoryName,
      this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.validateAt,
      this.validateBy,
      this.tagNumber,
      this.score,
      this.listCount,
      this.percentage,
      this.inspectionParts});

  MItem1.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    equipmentCode = json['EquipmentCode'];
    equipmentName = json['EquipmentName'];
    weight = json['Weight'];
    categoryId = json['CategoryId'];
    categoryName = json['CategoryName'];
    createdDate = json['CreatedDate'];
    createdBy = json['CreatedBy'];
    modifiedDate = json['ModifiedDate'];
    modifiedBy = json['ModifiedBy'];
    validateAt = json['ValidateAt'];
    validateBy = json['ValidateBy'];
    tagNumber = json['TagNumber'];
    score = json['Score'];
    listCount = json['ListCount'];
    percentage = json['Percentage'];
    inspectionParts = json['InspectionParts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['EquipmentCode'] = this.equipmentCode;
    data['EquipmentName'] = this.equipmentName;
    data['Weight'] = this.weight;
    data['CategoryId'] = this.categoryId;
    data['CategoryName'] = this.categoryName;
    data['CreatedDate'] = this.createdDate;
    data['CreatedBy'] = this.createdBy;
    data['ModifiedDate'] = this.modifiedDate;
    data['ModifiedBy'] = this.modifiedBy;
    data['ValidateAt'] = this.validateAt;
    data['ValidateBy'] = this.validateBy;
    data['TagNumber'] = this.tagNumber;
    data['Score'] = this.score;
    data['ListCount'] = this.listCount;
    data['Percentage'] = this.percentage;
    data['InspectionParts'] = this.inspectionParts;
    return data;
  }
}

class MItem2 {
  int? id;
  int? eqlistId;
  int? partId;
  String? partName;
  int? weight;
  int? score;
  int? totalScore;
  String? remark;
  bool? isDaily;
  bool? isWeekly;
  bool? isMonthly;
  bool? isYearly;
  String? createdDate;
  String? createdBy;
  String? modifiedDate;
  String? modifiedBy;
  String? equipmentName;
  int? locationID;
  String? locationName;
  String? subLocation;
  String? tagNumber;
  String? fileName;
  String? contentType;
  int? size;
  String? data;

  MItem2(
      {this.id,
      this.eqlistId,
      this.partId,
      this.partName,
      this.weight,
      this.score,
      this.totalScore,
      this.remark,
      this.isDaily,
      this.isWeekly,
      this.isMonthly,
      this.isYearly,
      this.createdDate,
      this.createdBy,
      this.modifiedDate,
      this.modifiedBy,
      this.equipmentName,
      this.locationID,
      this.locationName,
      this.subLocation,
      this.tagNumber,
      this.fileName,
      this.contentType,
      this.size,
      this.data});

  MItem2.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    eqlistId = json['EqlistId'];
    partId = json['PartId'];
    partName = json['PartName'];
    weight = json['Weight'];
    score = json['Score'];
    totalScore = json['TotalScore'];
    remark = json['Remark'];
    isDaily = json['IsDaily'];
    isWeekly = json['IsWeekly'];
    isMonthly = json['IsMonthly'];
    isYearly = json['IsYearly'];
    createdDate = json['CreatedDate'];
    createdBy = json['CreatedBy'];
    modifiedDate = json['ModifiedDate'];
    modifiedBy = json['ModifiedBy'];
    equipmentName = json['EquipmentName'];
    locationID = json['LocationID'];
    locationName = json['LocationName'];
    subLocation = json['SubLocation'];
    tagNumber = json['TagNumber'];
    fileName = json['FileName'];
    contentType = json['ContentType'];
    size = json['Size'];
    data = json['Data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['EqlistId'] = this.eqlistId;
    data['PartId'] = this.partId;
    data['PartName'] = this.partName;
    data['Weight'] = this.weight;
    data['Score'] = this.score;
    data['TotalScore'] = this.totalScore;
    data['Remark'] = this.remark;
    data['IsDaily'] = this.isDaily;
    data['IsWeekly'] = this.isWeekly;
    data['IsMonthly'] = this.isMonthly;
    data['IsYearly'] = this.isYearly;
    data['CreatedDate'] = this.createdDate;
    data['CreatedBy'] = this.createdBy;
    data['ModifiedDate'] = this.modifiedDate;
    data['ModifiedBy'] = this.modifiedBy;
    data['EquipmentName'] = this.equipmentName;
    data['LocationID'] = this.locationID;
    data['LocationName'] = this.locationName;
    data['SubLocation'] = this.subLocation;
    data['TagNumber'] = this.tagNumber;
    data['FileName'] = this.fileName;
    data['ContentType'] = this.contentType;
    data['Size'] = this.size;
    data['Data'] = this.data;
    return data;
  }
}
