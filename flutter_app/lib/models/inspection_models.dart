class InspectionHeader {
  InspectionHeader({
    required this.productionDate,
    required this.shiftName,
    this.productName = 'Hipoclorito de Sodio',
    this.applicationMethod = 'Inmersión',
    this.weekLabel = '',
  });

  final String productionDate;
  final String shiftName;
  final String productName;
  final String applicationMethod;
  final String weekLabel;

  Map<String, dynamic> toJson() => {
        'production_date': productionDate,
        'shift_name': shiftName,
        'product_name': productName,
        'application_method': applicationMethod,
        'week_label': weekLabel,
      };
}

class InspectionEntry {
  InspectionEntry({
    required this.hourMark,
    required this.lotNumber,
    required this.phValue,
    required this.waterTempC,
    required this.turbidityNtu,
    required this.waterChanged,
    required this.waterLiters,
    required this.disinfectantMl,
    required this.concentrationPpm,
    required this.observations,
    required this.operatorInitials,
    required this.supervisorName,
  });

  final String hourMark;
  final String lotNumber;
  final double phValue;
  final double waterTempC;
  final double turbidityNtu;
  final bool waterChanged;
  final double waterLiters;
  final double disinfectantMl;
  final int concentrationPpm;
  final String observations;
  final String operatorInitials;
  final String supervisorName;

  Map<String, dynamic> toJson() => {
        'hour_mark': hourMark,
        'lot_number': lotNumber,
        'ph_value': phValue,
        'water_temp_c': waterTempC,
        'turbidity_ntu': turbidityNtu,
        'water_changed': waterChanged,
        'water_liters': waterLiters,
        'disinfectant_ml': disinfectantMl,
        'concentration_ppm': concentrationPpm,
        'observations': observations,
        'operator_initials': operatorInitials,
        'supervisor_name': supervisorName,
      };
}
