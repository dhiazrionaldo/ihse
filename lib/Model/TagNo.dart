import 'package:flutter/material.dart';

class TagNoModel {
  int? Id;
  String? EquipmentName;

  TagNoModel({
    this.Id,
    this.EquipmentName,
  });

  TagNoModel.fromJson(Map<String, dynamic> json) {
    Id = json['Id'];
    EquipmentName = json['EquipmentName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = Id;
    data['EquipmentName'] = EquipmentName;

    return data;
  }
}
