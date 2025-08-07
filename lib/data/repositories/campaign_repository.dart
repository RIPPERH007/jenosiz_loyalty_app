import '../models/campaign_model.dart';
import '../datasources/mock_data.dart';
import '../../core/utils/shared_preferences_helper.dart';
import 'dart:convert';

class CampaignRepository {
  Future<List<CampaignModel>> getCampaigns() async {
    try {
      return await MockData.getCampaigns();
    } catch (e) {
      throw Exception('Failed to fetch campaigns: $e');
    }
  }

  Future<CampaignModel?> getCampaignById(String id) async {
    try {
      final campaigns = await getCampaigns();
      return campaigns.firstWhere(
            (campaign) => campaign.id == id,
        orElse: () => throw Exception('Campaign not found'),
      );
    } catch (e) {
      return null;
    }
  }

  Future<bool> joinCampaign(String campaignId, String userId) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 1000));
      return true;
    } catch (e) {
      return false;
    }
  }
}


