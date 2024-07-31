// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdrawalList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WithdrawalResponse _$WithdrawalResponseFromJson(Map<String, dynamic> json) =>
    WithdrawalResponse(
      json['order'] as String,
      (json['sum'] as num?)?.toDouble(),
      json['processed_at'] as String,
    );

Map<String, dynamic> _$WithdrawalResponseToJson(WithdrawalResponse instance) =>
    <String, dynamic>{
      'order': instance.order,
      'sum': instance.sum,
      'processed_at': instance.processed_at,
    };
