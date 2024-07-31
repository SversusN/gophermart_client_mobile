// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accrualsList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccrualResponce _$AccrualResponceFromJson(Map<String, dynamic> json) =>
    AccrualResponce(
      json['number'] as String,
      json['status'] as String,
      (json['accrual'] as num?)?.toDouble(),
      json['uploaded_at'] as String,
    );

Map<String, dynamic> _$AccrualResponceToJson(AccrualResponce instance) =>
    <String, dynamic>{
      'number': instance.number,
      'status': instance.status,
      'accrual': instance.accrual,
      'uploaded_at': instance.uploaded_at,
    };
