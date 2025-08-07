import 'package:equatable/equatable.dart';

enum TransactionType {
  joinCampaign,
  referral,
  membership,
  purchase,
}

class TransactionModel extends Equatable {
  final String id;
  final TransactionType type;
  final String description;
  final int points;
  final DateTime date;
  final String? relatedId;

  const TransactionModel({
    required this.id,
    required this.type,
    required this.description,
    required this.points,
    required this.date,
    this.relatedId,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      type: TransactionType.values[json['type']],
      description: json['description'],
      points: json['points'],
      date: DateTime.parse(json['date']),
      relatedId: json['relatedId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.index,
      'description': description,
      'points': points,
      'date': date.toIso8601String(),
      'relatedId': relatedId,
    };
  }

  String get formattedDate {
    return '${date.day}/${date.month}/${date.year}';
  }

  String get typeIcon {
    switch (type) {
      case TransactionType.joinCampaign:
        return '🎯';
      case TransactionType.referral:
        return '👥';
      case TransactionType.membership:
        return '⭐';
      case TransactionType.purchase:
        return '🛒';
    }
  }

  @override
  List<Object?> get props => [
    id,
    type,
    description,
    points,
    date,
    relatedId,
  ];
}
