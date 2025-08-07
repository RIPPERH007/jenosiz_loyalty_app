import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final bool isMember;
  final DateTime? membershipDate;
  final String referralCode;
  final int totalPoints;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.isMember,
    this.membershipDate,
    required this.referralCode,
    required this.totalPoints,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      isMember: json['isMember'],
      membershipDate: json['membershipDate'] != null
          ? DateTime.parse(json['membershipDate'])
          : null,
      referralCode: json['referralCode'],
      totalPoints: json['totalPoints'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'isMember': isMember,
      'membershipDate': membershipDate?.toIso8601String(),
      'referralCode': referralCode,
      'totalPoints': totalPoints,
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    bool? isMember,
    DateTime? membershipDate,
    String? referralCode,
    int? totalPoints,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      isMember: isMember ?? this.isMember,
      membershipDate: membershipDate ?? this.membershipDate,
      referralCode: referralCode ?? this.referralCode,
      totalPoints: totalPoints ?? this.totalPoints,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    isMember,
    membershipDate,
    referralCode,
    totalPoints,
  ];
}
