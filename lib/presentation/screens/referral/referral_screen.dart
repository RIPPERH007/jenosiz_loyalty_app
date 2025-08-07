import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jenosize_loyalty_app/presentation/screens/referral/widgets/referal_code_widget.dart';
import 'package:uuid/uuid.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_string.dart';
import '../../../core/utils/share_helper.dart';
import '../../../data/models/transaction_model.dart';
import '../../bloc/membership/membership_bloc.dart';
import '../../bloc/membership/membersip_state.dart';
import '../../bloc/points/point_bloc.dart';
import '../../bloc/points/point_event.dart';

class ReferralScreen extends StatelessWidget {
  const ReferralScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(AppStrings.referralTitle),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocBuilder<MembershipBloc, MembershipState>(
        builder: (context, state) {
          if (state is MembershipLoaded) {
            final user = state.user;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [AppColors.secondary, AppColors.primary],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.secondary.withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.people_rounded,
                          color: Colors.white,
                          size: 48,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          AppStrings.referralTitle,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          AppStrings.referralSubtitle,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.accent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            AppStrings.referralReward,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Referral Code Section
                  ReferralCodeWidget(
                    referralCode: user.referralCode,
                    onShare: () => ShareHelper.shareReferralCode(user.referralCode),
                    onCopy: () => ShareHelper.copyToClipboard(context, user.referralCode),
                  ),

                  const SizedBox(height: 32),

                  // How it Works Section
                  const Text(
                    'How it Works',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),

                  const SizedBox(height: 16),

                  _buildStepCard(
                    step: '1',
                    title: 'Share Your Code',
                    description: 'Send your referral code to friends via any platform',
                    icon: Icons.share_rounded,
                    color: AppColors.info,
                  ),

                  _buildStepCard(
                    step: '2',
                    title: 'Friend Joins',
                    description: 'Your friend downloads the app and uses your code',
                    icon: Icons.person_add_rounded,
                    color: AppColors.accent,
                  ),

                  _buildStepCard(
                    step: '3',
                    title: 'Both Get Rewarded',
                    description: 'You both receive 100 bonus points instantly!',
                    icon: Icons.celebration_rounded,
                    color: AppColors.secondary,
                  ),

                  const SizedBox(height: 32),

                  // Demo Button (for testing)
                  if (user.isMember)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _simulateReferral(context);
                        },
                        icon: const Icon(Icons.bug_report_rounded),
                        label: const Text('Simulate Referral (Demo)'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _buildStepCard({
    required String step,
    required String title,
    required String description,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Step Number
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                step,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icon, color: color, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _simulateReferral(BuildContext context) {
    const uuid = Uuid();
    final transaction = TransactionModel(
      id: uuid.v4(),
      type: TransactionType.referral,
      description: 'Friend referral bonus (Demo)',
      points: 100,
      date: DateTime.now(),
    );

    context.read<PointsBloc>().add(AddTransaction(transaction: transaction));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Referral bonus added! +100 points 🎉'),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
