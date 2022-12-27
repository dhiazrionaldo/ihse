import 'package:flutter/material.dart';

class TagNoDetailModel {
  int? Id;
  int? EqListId;
  int? PartId;
  String? PartName;
  int? Weight;
  int? Score;
  int? TotalScore;
  String? Remark;
  bool? IsDaily;
  bool? IsWeekly;
  bool? IsMonthly;
  bool? IsYearly;
  String? CreatedDate;
  String? CreatedBy;
  String? ModifiedDate;
  String? ModifiedBy;
  String? EquipmentName;
  int? LocationID;
  String? LocationName;
  String? SubLocation;
  String? TagNumber;
  String? FileName;
  String? ContentType;
  int? Size;
  String? Data;
  String? Good;
  String? Warning;
  String? Bad;

  TagNoDetailModel({
    this.Id,
    this.EqListId,
    this.PartId,
    this.PartName,
    this.Weight,
    this.Score,
    this.TotalScore,
    this.Remark,
    this.IsDaily,
    this.IsWeekly,
    this.IsMonthly,
    this.IsYearly,
    this.CreatedBy,
    this.CreatedDate,
    this.ModifiedBy,
    this.ModifiedDate,
    this.EquipmentName,
    this.LocationID,
    this.LocationName,
    this.SubLocation,
    this.TagNumber,
    this.FileName,
    this.ContentType,
    this.Size,
    this.Data,
    this.Good,
    this.Warning,
    this.Bad,
  });

  TagNoDetailModel.fromJson(Map<String, dynamic> json) {
    Id = json['Id'];
    EqListId = json['EqListId'];
    PartId = json['PartId'];
    PartName = json['PartName'];
    Weight = json['Weight'];
    Score = json['Score'];
    TotalScore = json['TotalScore'];
    Remark = json['Remark'];
    IsDaily = json['IsDaily'];
    IsWeekly = json['IsWeekly'];
    IsMonthly = json['IsMonthly'];
    IsYearly = json['IsYearly'];
    CreatedDate = json['CreatedDate'];
    CreatedBy = json['CreatedBy'];
    ModifiedDate = json['ModifiedDate'];
    ModifiedBy = json['ModifiedBy'];
    EquipmentName = json['EquipmentName'];
    LocationID = json['LocationID'];
    LocationName = json['LocationName'];
    SubLocation = json['SubLocation'];
    TagNumber = json['TagNumber'];
    FileName = json['FileName'];
    ContentType = json['ContentType'];
    Size = json['Size'];
    Data = json['Data'];
    Good = json['Good'];
    Warning = json['Warning'];
    Bad = json['Bad'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = Id;
    data['EqListId'] = EqListId;
    data['PartId'] = PartId;
    data['PartName'] = PartName;
    data['Weight'] = Weight;
    data['Score'] = Score;
    data['TotalScore'] = TotalScore;
    data['Remark'] = Remark;
    data['IsDaily'] = IsDaily;
    data['IsWeekly'] = IsWeekly;
    data['IsMonthly'] = IsMonthly;
    data['IsYearly'] = IsYearly;
    data['CreatedDate'] = CreatedDate;
    data['CreatedBy'] = CreatedBy;
    data['ModifiedDate'] = ModifiedDate;
    data['ModifiedBy'] = ModifiedBy;
    data['EquipmentName'] = EquipmentName;
    data['LocationID'] = LocationID;
    data['LocationName'] = LocationName;
    data['SubLocation'] = SubLocation;
    data['TagNumber'] = TagNumber;
    data['FileName'] = FileName;
    data['ContentType'] = ContentType;
    data['Size'] = Size;
    data['Data'] = Data;
    data['Good'] = Good;
    data['Warning'] = Warning;
    data['Bad'] = Bad;

    return data;
  }
}
