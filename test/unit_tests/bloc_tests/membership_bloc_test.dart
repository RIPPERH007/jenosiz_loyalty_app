import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:jenosize_loyalty_app/data/repositories/point_repository.dart';
import 'package:jenosize_loyalty_app/presentation/bloc/membership/membersip_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:jenosize_loyalty_app/presentation/bloc/membership/membership_bloc.dart';
import 'package:jenosize_loyalty_app/presentation/bloc/membership/membership_event.dart';
import 'package:jenosize_loyalty_app/data/repositories/user_repository.dart';
import 'package:jenosize_loyalty_app/data/models/user_model.dart';
import 'package:jenosize_loyalty_app/data/models/transaction_model.dart';

class MockUserRepository extends Mock implements UserRepository {}
class MockPointsRepository extends Mock implements PointsRepository {}

// ⭐ Fake classes for fallback values
class FakeTransactionModel extends Fake implements TransactionModel {}

void main() {
  group('MembershipBloc', () {
    late MembershipBloc membershipBloc;
    late MockUserRepository mockUserRepository;
    late MockPointsRepository mockPointsRepository;

    // ⭐ Register fallback values
    setUpAll(() {
      registerFallbackValue(FakeTransactionModel());
    });

    setUp(() {
      mockUserRepository = MockUserRepository();
      mockPointsRepository = MockPointsRepository();
      membershipBloc = MembershipBloc(
        userRepository: mockUserRepository,
        pointsRepository: mockPointsRepository,
      );
    });

    tearDown(() {
      membershipBloc.close();
    });

    final mockUser = UserModel(
      id: '1',
      name: 'Test User',
      email: 'test@example.com',
      isMember: false,
      referralCode: 'TEST1234',
      totalPoints: 0,
    );

    test('initial state is MembershipInitial', () {
      expect(membershipBloc.state, MembershipInitial());
    });

    blocTest<MembershipBloc, MembershipState>(
      'emits [MembershipLoading, MembershipLoaded] when CheckMembershipStatus is added',
      build: () {
        when(() => mockUserRepository.getUser())
            .thenAnswer((_) async => mockUser);
        return membershipBloc;
      },
      act: (bloc) => bloc.add(CheckMembershipStatus()),
      expect: () => [
        MembershipLoading(),
        MembershipLoaded(user: mockUser),
      ],
    );

    blocTest<MembershipBloc, MembershipState>(
      'emits correct states when joining membership successfully',
      build: () {
        final memberUser = mockUser.copyWith(isMember: true);
        when(() => mockUserRepository.getUser())
            .thenAnswer((_) async => mockUser);
        when(() => mockUserRepository.joinMembership(mockUser.id))
            .thenAnswer((_) async => true);
        when(() => mockUserRepository.getUser())
            .thenAnswer((_) async => memberUser);
        when(() => mockPointsRepository.addTransaction(any()))
            .thenAnswer((_) async {});
        return membershipBloc;
      },
      seed: () => MembershipLoaded(user: mockUser),
      act: (bloc) => bloc.add(JoinMembership()),
      expect: () => [
        MembershipJoining(),
        MembershipJoined(user: mockUser.copyWith(isMember: true)),
        MembershipLoaded(user: mockUser.copyWith(isMember: true)),
      ],
    );
  });
}
