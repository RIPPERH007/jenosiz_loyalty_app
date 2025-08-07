import '../../core/utils/shared_preferences_helper.dart';
import '../datasources/mock_data.dart';
import '../models/user_model.dart';

class UserRepository {
  Future<UserModel> getUser() async {
    try {
      final user = await MockData.getUser();

      return user.copyWith(
        isMember: SharedPreferencesHelper.isMember,
        membershipDate: SharedPreferencesHelper.membershipDate,
        referralCode: SharedPreferencesHelper.referralCode.isNotEmpty
            ? SharedPreferencesHelper.referralCode
            : user.referralCode,
        totalPoints: SharedPreferencesHelper.userPoints,
      );
    } catch (e) {
      throw Exception('Failed to fetch user: $e');
    }
  }

  Future<bool> joinMembership(String userId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 1200));
      await SharedPreferencesHelper.setMembershipStatus(true);
      await SharedPreferencesHelper.setUserPoints(
        SharedPreferencesHelper.userPoints + 100,
      );

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> updateUserPoints(int points) async {
    await SharedPreferencesHelper.setUserPoints(points);
  }

  Future<void> setReferralCode(String code) async {
    await SharedPreferencesHelper.setReferralCode(code);
  }
}
