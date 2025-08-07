import 'package:equatable/equatable.dart';
import '../../../data/models/transaction_model.dart';

abstract class PointsEvent extends Equatable {
  const PointsEvent();

  @override
  List<Object?> get props => [];
}

class LoadUserPoints extends PointsEvent {}

class AddTransaction extends PointsEvent {
  final TransactionModel transaction;

  const AddTransaction({required this.transaction});

  @override
  List<Object?> get props => [transaction];
}

class RefreshPoints extends PointsEvent {}

