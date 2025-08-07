import 'package:equatable/equatable.dart';

class CampaignModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final int pointsReward;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;

  const CampaignModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.pointsReward,
    required this.startDate,
    required this.endDate,
    required this.isActive,
  });

  factory CampaignModel.fromJson(Map<String, dynamic> json) {
    return CampaignModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      pointsReward: json['pointsReward'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'pointsReward': pointsReward,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'isActive': isActive,
    };
  }

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    imageUrl,
    pointsReward,
    startDate,
    endDate,
    isActive,
  ];
}


