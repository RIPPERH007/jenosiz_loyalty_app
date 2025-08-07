// presentation/screens/home/widgets/campaign_card.dart - ใช้ flags แทน states
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_string.dart';
import '../../../../data/models/campaign_model.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../bloc/campaign/campaign_bloc.dart';
import '../../../bloc/campaign/campaign_state.dart';

class CampaignCard extends StatelessWidget {
  final CampaignModel campaign;
  final VoidCallback onJoin;

  const CampaignCard({
    super.key,
    required this.campaign,
    required this.onJoin,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CampaignBloc, CampaignState>(
      builder: (context, state) {
        // ⭐ ใช้ flags ใน CampaignLoaded แทน
        bool isJoining = false;
        bool isJoined = false;

        if (state is CampaignLoaded) {
          isJoining = state.joiningCampaignId == campaign.id;
          isJoined = state.joinedCampaignId == campaign.id;
        }

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: CachedNetworkImage(
                    imageUrl: campaign.imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: AppColors.lightGrey,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: AppColors.lightGrey,
                      child: const Icon(
                        Icons.image_not_supported_rounded,
                        size: 48,
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Points
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            campaign.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Points container
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: isJoined ? AppColors.success : AppColors.accent,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: isJoined ? [
                              BoxShadow(
                                color: AppColors.success.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ] : null,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                child: Icon(
                                  isJoined ? Icons.check_circle : Icons.stars_rounded,
                                  key: ValueKey(isJoined ? 'joined' : 'default'),
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '+${campaign.pointsReward}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Description
                    Text(
                      campaign.description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Action Button
                    SizedBox(
                      width: double.infinity,
                      child: _buildActionButton(isJoining, isJoined),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionButton(bool isJoining, bool isJoined) {
    if (isJoining) {
      // ⭐ Loading state - แค่ปุ่มเท่านั้น ไม่มีหน้าจอ loading
      return ElevatedButton.icon(
        onPressed: null,
        icon: const SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
        label: const Text('Joining...'),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary.withOpacity(0.7),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    } else if (isJoined) {
      // Success state
      return ElevatedButton.icon(
        onPressed: null,
        icon: const Icon(Icons.check_circle),
        label: const Text('Joined Successfully!'),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.success,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
      );
    } else {
      // Default state
      return ElevatedButton.icon(
        onPressed: () {
          HapticFeedback.lightImpact();
          onJoin();
        },
        icon: const Icon(Icons.add_circle_outline_rounded),
        label: const Text(AppStrings.joinNow),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
  }
}
