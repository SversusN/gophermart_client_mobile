// {
//           "number": "9278923470",
//           "status": "PROCESSED",
//           "accrual": 500,
//           "uploaded_at": "2020-12-10T15:15:45+03:00"
//       },

import 'package:json_annotation/json_annotation.dart';
part 'accrualsList.g.dart';

@JsonSerializable()
class AccrualResponce {
  final String number;
  final String status;
  final double? accrual;
  final String uploaded_at;

  AccrualResponce(this.number, this.status, this.accrual, this.uploaded_at);

  factory AccrualResponce.fromJson(Map<String, dynamic> json) =>
      _$AccrualResponceFromJson(json);
  Map<String, dynamic> toJson() => _$AccrualResponceToJson(this);
}
