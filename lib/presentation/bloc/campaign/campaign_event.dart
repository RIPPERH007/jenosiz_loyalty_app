import 'package:equatable/equatable.dart';

abstract class CampaignEvent extends Equatable {
  const CampaignEvent();

  @override
  List<Object?> get props => [];
}

class LoadCampaigns extends CampaignEvent {}

class JoinCampaign extends CampaignEvent {
  final String campaignId;

  const JoinCampaign({required this.campaignId});

  @override
  List<Object?> get props => [campaignId];
}

class RefreshCampaigns extends CampaignEvent {}

