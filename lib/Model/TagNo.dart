import 'package:flutter/material.dart';

class TagNoModel {
  int? Id;
  String? EquipmentName;
  String? Good;
  String? Warning;
  String? Bad;

  TagNoModel({
    this.Id,
    this.EquipmentName,
    this.Good,
    this.Warning,
    this.Bad,
  });

  TagNoModel.fromJson(Map<String, dynamic> json) {
    Id = json['Id'];
    EquipmentName = json['EquipmentName'];
    Good = json['Good'];
    Warning = json['Warning'];
    Bad = json['Bad'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = Id;
    data['EquipmentName'] = EquipmentName;
    data['Good'] = Good;
    data['Warning'] = Warning;
    data['Bad'] = Bad;

    return data;
  }
}
