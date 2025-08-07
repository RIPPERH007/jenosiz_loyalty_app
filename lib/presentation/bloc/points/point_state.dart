
import 'package:equatable/equatable.dart';
import '../../../data/models/transaction_model.dart';

abstract class PointsState extends Equatable {
  const PointsState();

  @override
  List<Object?> get props => [];
}

class PointsInitial extends PointsState {}

class PointsLoading extends PointsState {}

class PointsLoaded extends PointsState {
  final int totalPoints;
  final List<TransactionModel> transactions;

  const PointsLoaded({
    required this.totalPoints,
    required this.transactions,
  });

  @override
  List<Object?> get props => [totalPoints, transactions];
}

class PointsError extends PointsState {
  final String message;

  const PointsError({required this.message});

  @override
  List<Object?> get props => [message];
}

class TransactionAdded extends PointsState {
  final TransactionModel transaction;
  final int totalPoints;
  final List<TransactionModel> transactions;

  const TransactionAdded({
    required this.transaction,
    required this.totalPoints,
    required this.transactions,
  });

  @override
  List<Object?> get props => [transaction, totalPoints, transactions];
}
