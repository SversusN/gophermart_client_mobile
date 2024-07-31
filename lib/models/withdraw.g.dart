// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdraw.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WithdrawRequest _$WithdrawRequestFromJson(Map<String, dynamic> json) =>
    WithdrawRequest(
      json['order'] as String,
      (json['sum'] as num).toDouble(),
    );

Map<String, dynamic> _$WithdrawRequestToJson(WithdrawRequest instance) =>
    <String, dynamic>{
      'order': instance.order,
      'sum': instance.sum,
    };
