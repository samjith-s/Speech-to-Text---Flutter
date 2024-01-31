import 'package:cloud_firestore/cloud_firestore.dart';

const _kId = "id";
const _kData = "data";
const _kCreatedAt = "created_at";

class TermsAndCondition {
  final String? id;
  final String data;
  final Timestamp createdAt;

  TermsAndCondition({
    this.id,
    required this.data,
    required this.createdAt,
  });

  factory TermsAndCondition.fromJson(Map<String, dynamic> json) => TermsAndCondition(
        id: json[_kId],
        data: json[_kData],
        createdAt: json[_kCreatedAt],
      );

  Map<String, dynamic> toJson() => {
        _kId: id,
        _kData: data,
        _kCreatedAt: createdAt,
      };
}
