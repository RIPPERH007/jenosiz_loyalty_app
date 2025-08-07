import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/point_repository.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../data/models/transaction_model.dart';
import 'package:uuid/uuid.dart';
import 'membership_event.dart';
import 'membersip_state.dart';

class MembershipBloc extends Bloc<MembershipEvent, MembershipState> {
  final UserRepository userRepository;
  final PointsRepository pointsRepository;
  final _uuid = const Uuid();

  MembershipBloc({
    required this.userRepository,
    required this.pointsRepository,
  }) : super(MembershipInitial()) {
    on<CheckMembershipStatus>(_onCheckMembershipStatus);
    on<JoinMembership>(_onJoinMembership);
  }

  Future<void> _onCheckMembershipStatus(
      CheckMembershipStatus event,
      Emitter<MembershipState> emit,
      ) async {
    emit(MembershipLoading());

    try {
      print('🔄 Checking membership status...'); // Debug log
      final user = await userRepository.getUser();
      print('✅ User loaded: ${user.name}, isMember: ${user.isMember}'); // Debug log
      emit(MembershipLoaded(user: user));
    } catch (e) {
      print('❌ Error checking membership: $e'); // Debug log
      emit(MembershipError(message: e.toString()));
    }
  }

  Future<void> _onJoinMembership(
      JoinMembership event,
      Emitter<MembershipState> emit,
      ) async {
    if (state is MembershipLoaded) {
      final currentUser = (state as MembershipLoaded).user;

      if (currentUser.isMember) {
        print('ℹ️ User is already a member'); // Debug log
        return; // Already a member
      }

      print('🎯 Joining membership...'); // Debug log
      emit(MembershipJoining());

      try {
        final success = await userRepository.joinMembership(currentUser.id);
        print('🔄 Join membership result: $success'); // Debug log

        if (success) {
          print('📝 Creating membership bonus transaction...'); // Debug log

          final transaction = TransactionModel(
            id: _uuid.v4(),
            type: TransactionType.membership,
            description: 'Welcome bonus for joining membership',
            points: 100,
            date: DateTime.now(),
          );

          print('💾 Adding membership transaction: +${transaction.points} points'); // Debug log
          await pointsRepository.addTransaction(transaction);

          // Get updated user data
          final updatedUser = await userRepository.getUser();
          print('✅ Membership joined successfully'); // Debug log

          emit(MembershipJoined(user: updatedUser));

          // Return to loaded state with updated data
          emit(MembershipLoaded(user: updatedUser));
        } else {
          print('❌ Failed to join membership'); // Debug log
          emit(const MembershipError(message: 'Failed to join membership'));
          emit(MembershipLoaded(user: currentUser));
        }
      } catch (e) {
        print('❌ Error joining membership: $e'); // Debug log
        emit(MembershipError(message: e.toString()));
        emit(MembershipLoaded(user: currentUser));
      }
    } else {
      print('❌ Cannot join membership: not in loaded state'); // Debug log
    }
  }
}
