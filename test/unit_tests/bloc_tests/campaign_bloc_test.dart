// test/unit_tests/bloc_tests/campaign_bloc_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:jenosize_loyalty_app/data/repositories/point_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:jenosize_loyalty_app/presentation/bloc/campaign/campaign_bloc.dart';
import 'package:jenosize_loyalty_app/presentation/bloc/campaign/campaign_event.dart';
import 'package:jenosize_loyalty_app/presentation/bloc/campaign/campaign_state.dart';
import 'package:jenosize_loyalty_app/data/repositories/campaign_repository.dart';
import 'package:jenosize_loyalty_app/data/models/campaign_model.dart';

class MockCampaignRepository extends Mock implements CampaignRepository {}
class MockPointsRepository extends Mock implements PointsRepository {}

void main() {
  group('CampaignBloc', () {
    late CampaignBloc campaignBloc;
    late MockCampaignRepository mockCampaignRepository;
    late MockPointsRepository mockPointsRepository;

    setUp(() {
      mockCampaignRepository = MockCampaignRepository();
      mockPointsRepository = MockPointsRepository();
      campaignBloc = CampaignBloc(
        campaignRepository: mockCampaignRepository,
        pointsRepository: mockPointsRepository,
      );
    });

    tearDown(() {
      campaignBloc.close();
    });

    final mockCampaigns = [
      CampaignModel(
        id: '1',
        title: 'Test Campaign',
        description: 'Test Description',
        imageUrl: 'https://example.com/image.jpg',
        pointsReward: 50,
        startDate: DateTime(2025, 1, 1),
        endDate: DateTime(2025, 12, 31),
        isActive: true,
      ),
    ];

    test('initial state is CampaignInitial', () {
      expect(campaignBloc.state, CampaignInitial());
    });

    blocTest<CampaignBloc, CampaignState>(
      'emits [CampaignLoading, CampaignLoaded] when LoadCampaigns is added',
      build: () {
        when(() => mockCampaignRepository.getCampaigns())
            .thenAnswer((_) async => mockCampaigns);
        return campaignBloc;
      },
      act: (bloc) => bloc.add(LoadCampaigns()),
      expect: () => [
        CampaignLoading(),
        CampaignLoaded(campaigns: mockCampaigns),
      ],
    );

    blocTest<CampaignBloc, CampaignState>(
      'emits [CampaignLoading, CampaignError] when LoadCampaigns fails',
      build: () {
        when(() => mockCampaignRepository.getCampaigns())
            .thenThrow(Exception('Failed to load campaigns'));
        return campaignBloc;
      },
      act: (bloc) => bloc.add(LoadCampaigns()),
      expect: () => [
        CampaignLoading(),
        isA<CampaignError>(),
      ],
    );
  });
}
