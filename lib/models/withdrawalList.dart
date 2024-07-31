// [
//     {
//         "order": "2377225624",
//         "sum": 500,
//         "processed_at": "2020-12-09T16:09:57+03:00"
//     }
// ]

import 'package:json_annotation/json_annotation.dart';
part 'withdrawalList.g.dart';

@JsonSerializable()
class WithdrawalResponse {
  final String? order;
  final double? sum;
  final String processed_at;

  WithdrawalResponse(this.order, this.sum, this.processed_at);

  factory WithdrawalResponse.fromJson(Map<String, dynamic> json) =>
      _$WithdrawalResponseFromJson(json);
  Map<String, dynamic> toJson() => _$WithdrawalResponseToJson(this);
}
