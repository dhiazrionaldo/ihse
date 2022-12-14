class equipmentChartModel {
  String? ChartId;
  String? EquipmentName;
  int? TotalPart;
  int? TotalEquipment;

  equipmentChartModel({
    this.ChartId,
    this.EquipmentName,
    this.TotalPart,
    this.TotalEquipment,
  });

  equipmentChartModel.fromJson(Map<String, dynamic> json) {
    ChartId = json['ChartID'];
    EquipmentName = json['EquipmentName'];
    TotalPart = json['TotalPart'];
    TotalEquipment = json['TotalEquipment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ChartID'] = ChartId;
    data['EquipmentName'] = EquipmentName;
    data['TotalPart'] = TotalPart;
    data['TotalEquipment'] = TotalEquipment;

    return data;
  }
}
