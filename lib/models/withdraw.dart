// {
//     "order": "2377225624",
//     "sum": 751
// }

import 'package:json_annotation/json_annotation.dart';

part 'withdraw.g.dart';

@JsonSerializable()
class WithdrawRequest {
  final String order;
  final double sum;

  WithdrawRequest(this.order, this.sum);

  factory WithdrawRequest.fromJson(Map<String, dynamic> json) =>
      _$WithdrawRequestFromJson(json);
  Map<String, dynamic> toJson() => _$WithdrawRequestToJson(this);
}
