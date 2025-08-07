
import 'package:equatable/equatable.dart';
import '../../../data/models/user_model.dart';

abstract class MembershipState extends Equatable {
  const MembershipState();

  @override
  List<Object?> get props => [];
}

class MembershipInitial extends MembershipState {}

class MembershipLoading extends MembershipState {}

class MembershipLoaded extends MembershipState {
  final UserModel user;

  const MembershipLoaded({required this.user});

  @override
  List<Object?> get props => [user];
}

class MembershipJoining extends MembershipState {}

class MembershipJoined extends MembershipState {
  final UserModel user;

  const MembershipJoined({required this.user});

  @override
  List<Object?> get props => [user];
}

class MembershipError extends MembershipState {
  final String message;

  const MembershipError({required this.message});

  @override
  List<Object?> get props => [message];
}
