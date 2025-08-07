import 'package:equatable/equatable.dart';

abstract class MembershipEvent extends Equatable {
  const MembershipEvent();

  @override
  List<Object?> get props => [];
}

class CheckMembershipStatus extends MembershipEvent {}

class JoinMembership extends MembershipEvent {}

