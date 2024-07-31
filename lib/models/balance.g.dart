// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BalanseResponse _$BalanseResponseFromJson(Map<String, dynamic> json) =>
    BalanseResponse(
      (json['current'] as num).toDouble(),
      (json['withdrawn'] as num).toDouble(),
    );

Map<String, dynamic> _$BalanseResponseToJson(BalanseResponse instance) =>
    <String, dynamic>{
      'current': instance.current,
      'withdrawn': instance.withdrawn,
    };
