import '../models/campaign_model.dart';
import 'package:uuid/uuid.dart';

import '../models/transaction_model.dart';
import '../models/user_model.dart';

class MockData {
  static const _uuid = Uuid();

  static List<CampaignModel> get campaigns => [
    CampaignModel(
      id: '1',
      title: 'Coffee Lovers Reward',
      description: 'Earn 50 points for every coffee purchase. Join now and get your first reward!',
      imageUrl: 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=400',
      pointsReward: 50,
      startDate: DateTime(2025, 1, 1),
      endDate: DateTime(2025, 12, 31),
      isActive: true,
    ),
    CampaignModel(
      id: '2',
      title: 'Shopping Spree Bonus',
      description: 'Get 100 points for every 1000 THB spent. Perfect for your shopping needs!',
      imageUrl: 'https://images.unsplash.com/photo-1472851294608-062f824d29cc?w=400',
      pointsReward: 100,
      startDate: DateTime(2025, 1, 15),
      endDate: DateTime(2025, 3, 15),
      isActive: true,
    ),
    CampaignModel(
      id: '3',
      title: 'Fitness Challenge',
      description: 'Complete daily fitness goals and earn 30 points each day. Stay healthy, stay rewarded!',
      imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400',
      pointsReward: 30,
      startDate: DateTime(2025, 2, 1),
      endDate: DateTime(2025, 2, 28),
      isActive: true,
    ),
    CampaignModel(
      id: '4',
      title: 'Restaurant Week Special',
      description: 'Dine at partner restaurants and earn 75 points per visit. Discover new flavors!',
      imageUrl: 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=400',
      pointsReward: 75,
      startDate: DateTime(2025, 3, 1),
      endDate: DateTime(2025, 3, 31),
      isActive: true,
    ),
    CampaignModel(
      id: '5',
      title: 'Green Living Initiative',
      description: 'Use eco-friendly products and services to earn 60 points. Help save the planet!',
      imageUrl: 'https://images.unsplash.com/photo-1542601906990-b4d3fb778b09?w=400',
      pointsReward: 60,
      startDate: DateTime(2025, 1, 1),
      endDate: DateTime(2025, 6, 30),
      isActive: true,
    ),
    CampaignModel(
      id: '6',
      title: 'Tech Gadget Rewards',
      description: 'Purchase tech gadgets from partner stores and earn 150 points. Upgrade your tech!',
      imageUrl: 'https://images.unsplash.com/photo-1468495244123-6c6c332eeece?w=400',
      pointsReward: 150,
      startDate: DateTime(2025, 2, 15),
      endDate: DateTime(2025, 4, 15),
      isActive: true,
    ),
  ];

  static UserModel get defaultUser => UserModel(
    id: _uuid.v4(),
    name: 'John Doe',
    email: 'john.doe@example.com',
    isMember: false,
    referralCode: generateReferralCode(),
    totalPoints: 0,
  );

  static String generateReferralCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = DateTime.now().millisecondsSinceEpoch;
    var result = 'JENO';

    for (int i = 0; i < 4; i++) {
      result += chars[(random + i) % chars.length];
    }

    return result;
  }

  static List<TransactionModel> get sampleTransactions => [
    TransactionModel(
      id: _uuid.v4(),
      type: TransactionType.membership,
      description: 'Welcome bonus for joining membership',
      points: 100,
      date: DateTime.now().subtract(const Duration(days: 5)),
    ),
    TransactionModel(
      id: _uuid.v4(),
      type: TransactionType.joinCampaign,
      description: 'Joined Coffee Lovers Reward campaign',
      points: 50,
      date: DateTime.now().subtract(const Duration(days: 3)),
      relatedId: '1',
    ),
    TransactionModel(
      id: _uuid.v4(),
      type: TransactionType.referral,
      description: 'Friend referral bonus',
      points: 100,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    TransactionModel(
      id: _uuid.v4(),
      type: TransactionType.purchase,
      description: 'Shopping spree reward',
      points: 100,
      date: DateTime.now(),
    ),
  ];

  static Future<List<CampaignModel>> getCampaigns() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    return campaigns;
  }

  static Future<UserModel> getUser() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return defaultUser;
  }

  static Future<List<TransactionModel>> getTransactions() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return sampleTransactions;
  }
}
