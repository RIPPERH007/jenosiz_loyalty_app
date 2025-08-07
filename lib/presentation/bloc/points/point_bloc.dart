import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jenosize_loyalty_app/presentation/bloc/points/point_event.dart';
import 'package:jenosize_loyalty_app/presentation/bloc/points/point_state.dart';
import '../../../data/repositories/point_repository.dart';


class PointsBloc extends Bloc<PointsEvent, PointsState> {
  final PointsRepository pointsRepository;

  PointsBloc({
    required this.pointsRepository,
  }) : super(PointsInitial()) {
    on<LoadUserPoints>(_onLoadUserPoints);
    on<AddTransaction>(_onAddTransaction);
    on<RefreshPoints>(_onRefreshPoints);
  }

  Future<void> _onLoadUserPoints(
      LoadUserPoints event,
      Emitter<PointsState> emit,
      ) async {
    emit(PointsLoading());

    try {
      final points = await pointsRepository.getUserPoints();
      final transactions = await pointsRepository.getTransactions();

      emit(PointsLoaded(
        totalPoints: points,
        transactions: transactions,
      ));
    } catch (e) {
      emit(PointsError(message: e.toString()));
    }
  }

  Future<void> _onAddTransaction(
      AddTransaction event,
      Emitter<PointsState> emit,
      ) async {
    if (state is PointsLoaded) {
      try {
        await pointsRepository.addTransaction(event.transaction);

        // Reload data to get updated state
        final points = await pointsRepository.getUserPoints();
        final transactions = await pointsRepository.getTransactions();

        emit(TransactionAdded(
          transaction: event.transaction,
          totalPoints: points,
          transactions: transactions,
        ));

        // Return to loaded state
        emit(PointsLoaded(
          totalPoints: points,
          transactions: transactions,
        ));
      } catch (e) {
        emit(PointsError(message: e.toString()));
      }
    }
  }

  Future<void> _onRefreshPoints(
      RefreshPoints event,
      Emitter<PointsState> emit,
      ) async {
    try {
      final points = await pointsRepository.getUserPoints();
      final transactions = await pointsRepository.getTransactions();

      emit(PointsLoaded(
        totalPoints: points,
        transactions: transactions,
      ));
    } catch (e) {
      emit(PointsError(message: e.toString()));
    }
  }
}
