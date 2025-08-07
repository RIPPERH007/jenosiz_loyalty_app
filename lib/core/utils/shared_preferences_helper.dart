import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static SharedPreferences? _prefs;

  // Keys
  static const String keyIsMember = 'is_member';
  static const String keyMembershipDate = 'membership_date';
  static const String keyUserPoints = 'user_points';
  static const String keyReferralCode = 'referral_code';
  static const String keyTransactions = 'transactions';

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static SharedPreferences get instance {
    if (_prefs == null) {
      throw Exception('SharedPreferences not initialized. Call init() first.');
    }
    return _prefs!;
  }

  // Membership
  static Future<void> setMembershipStatus(bool isMember) async {
    await instance.setBool(keyIsMember, isMember);
    if (isMember) {
      await instance.setString(keyMembershipDate, DateTime.now().toIso8601String());
    }
  }

  static bool get isMember => instance.getBool(keyIsMember) ?? false;

  static DateTime? get membershipDate {
    final dateString = instance.getString(keyMembershipDate);
    return dateString != null ? DateTime.parse(dateString) : null;
  }

  // Points
  static Future<void> setUserPoints(int points) async {
    await instance.setInt(keyUserPoints, points);
  }

  static int get userPoints => instance.getInt(keyUserPoints) ?? 0;

  // Referral Code
  static Future<void> setReferralCode(String code) async {
    await instance.setString(keyReferralCode, code);
  }

  static String get referralCode => instance.getString(keyReferralCode) ?? '';

  // Transactions
  static Future<void> addTransaction(String transaction) async {
    final transactions = getTransactions();
    transactions.add(transaction);
    await instance.setStringList(keyTransactions, transactions);
  }

  static List<String> getTransactions() {
    return instance.getStringList(keyTransactions) ?? [];
  }

  // Clear all data
  static Future<void> clearAll() async {
    await instance.clear();
  }
}
