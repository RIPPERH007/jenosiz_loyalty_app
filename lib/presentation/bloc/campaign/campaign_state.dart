
import 'package:equatable/equatable.dart';
import '../../../data/models/campaign_model.dart';

abstract class CampaignState extends Equatable {
  const CampaignState();

  @override
  List<Object?> get props => [];
}

class CampaignInitial extends CampaignState {}

class CampaignLoading extends CampaignState {}

class CampaignLoaded extends CampaignState {
  final List<CampaignModel> campaigns;
  final String? joiningCampaignId;  // campaign ที่กำลัง join
  final String? joinedCampaignId;   // campaign ที่ join สำเร็จแล้ว

  const CampaignLoaded({
    required this.campaigns,
    this.joiningCampaignId,
    this.joinedCampaignId,
  });

  @override
  List<Object?> get props => [campaigns, joiningCampaignId, joinedCampaignId];
}

class CampaignError extends CampaignState {
  final String message;

  const CampaignError({required this.message});

  @override
  List<Object?> get props => [message];
}
