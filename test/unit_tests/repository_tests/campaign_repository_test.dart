
import 'package:flutter_test/flutter_test.dart';
import 'package:jenosize_loyalty_app/data/repositories/campaign_repository.dart';
import 'package:jenosize_loyalty_app/data/models/campaign_model.dart';

void main() {
  group('CampaignRepository', () {
    late CampaignRepository repository;

    setUp(() {
      repository = CampaignRepository();
    });

    test('getCampaigns returns list of campaigns', () async {
      // Act
      final campaigns = await repository.getCampaigns();

      // Assert
      expect(campaigns, isA<List<CampaignModel>>());
      expect(campaigns.length, greaterThan(0));
      expect(campaigns.first.id, isNotEmpty);
      expect(campaigns.first.title, isNotEmpty);
    });

    test('getCampaignById returns specific campaign', () async {
      // Arrange
      final allCampaigns = await repository.getCampaigns();
      final targetId = allCampaigns.first.id;

      // Act
      final campaign = await repository.getCampaignById(targetId);

      // Assert
      expect(campaign, isNotNull);
      expect(campaign!.id, equals(targetId));
    });

    test('getCampaignById returns null for invalid id', () async {
      // Act
      final campaign = await repository.getCampaignById('invalid-id');

      // Assert
      expect(campaign, isNull);
    });

    test('joinCampaign returns true on success', () async {
      // Act
      final result = await repository.joinCampaign('test-campaign', 'test-user');

      // Assert
      expect(result, isTrue);
    });
  });
}

