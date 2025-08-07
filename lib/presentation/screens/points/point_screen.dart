import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jenosize_loyalty_app/presentation/screens/points/widgets/points_summary_card.dart';
import 'package:jenosize_loyalty_app/presentation/screens/points/widgets/transaction_item.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_string.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../bloc/points/point_bloc.dart';
import '../../bloc/points/point_event.dart';
import '../../bloc/points/point_state.dart';

class PointsScreen extends StatelessWidget {
  const PointsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(AppStrings.pointsTitle),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              context.read<PointsBloc>().add(RefreshPoints());
            },
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: BlocConsumer<PointsBloc, PointsState>(
        listener: (context, state) {
          if (state is TransactionAdded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.transaction.typeIcon} +${state.transaction.points} points earned!'),
                backgroundColor: AppColors.success,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<PointsBloc>().add(RefreshPoints());
            },
            child: CustomScrollView(
              slivers: [
                // Points Summary
                if (state is PointsLoaded || state is TransactionAdded)
                  SliverToBoxAdapter(
                    child: PointsSummaryCard(
                      totalPoints: state is PointsLoaded
                          ? (state as PointsLoaded).totalPoints
                          : (state as TransactionAdded).totalPoints,
                    ),
                  ),

                // Section Header
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 24, 20, 16),
                    child: Text(
                      AppStrings.transactionHistory,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),

                // Transaction List
                if (state is PointsLoading)
                  const SliverFillRemaining(
                    child: LoadingWidget(),
                  )
                else if (state is PointsLoaded || state is TransactionAdded)
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) {
                          final transactions = state is PointsLoaded
                              ? (state as PointsLoaded).transactions
                              : (state as TransactionAdded).transactions;

                          if (transactions.isEmpty) {
                            return Container(
                              padding: const EdgeInsets.all(40),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.history_rounded,
                                    size: 64,
                                    color: AppColors.grey.withOpacity(0.5),
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    AppStrings.noTransactions,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Start joining campaigns to earn points!',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.textLight,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          }

                          final transaction = transactions[index];
                          return TransactionItem(
                            transaction: transaction,
                            isLast: index == transactions.length - 1,
                          );
                        },
                        childCount: state is PointsLoaded
                            ? (state as PointsLoaded).transactions.isEmpty
                            ? 1
                            : (state).transactions.length
                            : (state as TransactionAdded).transactions.isEmpty
                            ? 1
                            : (state as TransactionAdded).transactions.length,
                      ),
                    ),
                  )
                else if (state is PointsError)
                    SliverFillRemaining(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline_rounded,
                              size: 64,
                              color: AppColors.error,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              state.message,
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton.icon(
                              onPressed: () {
                                context.read<PointsBloc>().add(LoadUserPoints());
                              },
                              icon: const Icon(Icons.refresh_rounded),
                              label: const Text(AppStrings.retry),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    const SliverFillRemaining(
                      child: LoadingWidget(),
                    ),

                // Bottom padding
                const SliverToBoxAdapter(
                  child: SizedBox(height: 20),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

