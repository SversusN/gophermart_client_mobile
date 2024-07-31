// {
//     "current": 500.5,
//     "withdrawn": 42
// }

import 'package:json_annotation/json_annotation.dart';

part 'balance.g.dart';

@JsonSerializable()
class BalanseResponse {
  final double current;
  final double withdrawn;

  BalanseResponse(this.current, this.withdrawn);

  factory BalanseResponse.fromJson(Map<String, dynamic> json) =>
      _$BalanseResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BalanseResponseToJson(this);
}
