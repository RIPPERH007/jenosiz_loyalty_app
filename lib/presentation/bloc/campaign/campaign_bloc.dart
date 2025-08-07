// presentation/bloc/campaign/campaign_bloc.dart - แก้ไขเพื่อไม่แสดงหน้า loading
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/campaign_repository.dart';
import '../../../data/models/transaction_model.dart';
import 'package:uuid/uuid.dart';
import '../../../data/repositories/point_repository.dart';
import 'campaign_event.dart';
import 'campaign_state.dart';

class CampaignBloc extends Bloc<CampaignEvent, CampaignState> {
  final CampaignRepository campaignRepository;
  final PointsRepository pointsRepository;
  final _uuid = const Uuid();

  CampaignBloc({
    required this.campaignRepository,
    required this.pointsRepository,
  }) : super(CampaignInitial()) {
    on<LoadCampaigns>(_onLoadCampaigns);
    on<JoinCampaign>(_onJoinCampaign);
    on<RefreshCampaigns>(_onRefreshCampaigns);
  }

  Future<void> _onLoadCampaigns(
      LoadCampaigns event,
      Emitter<CampaignState> emit,
      ) async {
    emit(CampaignLoading());

    try {
      final campaigns = await campaignRepository.getCampaigns();
      emit(CampaignLoaded(campaigns: campaigns));
    } catch (e) {
      emit(CampaignError(message: e.toString()));
    }
  }

  Future<void> _onJoinCampaign(
      JoinCampaign event,
      Emitter<CampaignState> emit,
      ) async {
    if (state is CampaignLoaded) {
      final currentState = state as CampaignLoaded;

      // ⭐ เปลี่ยนจาก CampaignJoining เป็น CampaignLoaded พร้อม joining flag
      emit(CampaignLoaded(
        campaigns: currentState.campaigns,
        joiningCampaignId: event.campaignId, // เพิ่ม parameter นี้
      ));

      try {
        final success = await campaignRepository.joinCampaign(
          event.campaignId,
          'current-user-id',
        );

        if (success) {
          final campaign = currentState.campaigns.firstWhere(
                (c) => c.id == event.campaignId,
            orElse: () => throw Exception('Campaign not found'),
          );

          final transaction = TransactionModel(
            id: _uuid.v4(),
            type: TransactionType.joinCampaign,
            description: 'Joined ${campaign.title}',
            points: campaign.pointsReward,
            date: DateTime.now(),
            relatedId: event.campaignId,
          );

          await pointsRepository.addTransaction(transaction);

          // ⭐ emit CampaignLoaded พร้อม joined flag
          emit(CampaignLoaded(
            campaigns: currentState.campaigns,
            joinedCampaignId: event.campaignId, // เพิ่ม parameter นี้
          ));

        } else {
          emit(const CampaignError(message: 'Failed to join campaign'));
          emit(CampaignLoaded(campaigns: currentState.campaigns));
        }
      } catch (e) {
        emit(CampaignError(message: e.toString()));
        emit(CampaignLoaded(campaigns: currentState.campaigns));
      }
    }
  }

  Future<void> _onRefreshCampaigns(
      RefreshCampaigns event,
      Emitter<CampaignState> emit,
      ) async {
    // ⭐ เฉพาะ refresh เท่านั้นที่ใช้ loading
    emit(CampaignLoading());
    try {
      final campaigns = await campaignRepository.getCampaigns();
      emit(CampaignLoaded(campaigns: campaigns));
    } catch (e) {
      emit(CampaignError(message: e.toString()));
    }
  }
}
