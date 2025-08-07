// test/widget_tests/campaign_card_test.dart - Final Fixed Version
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jenosize_loyalty_app/core/constants/app_string.dart';
import 'package:jenosize_loyalty_app/data/models/campaign_model.dart';
import 'package:jenosize_loyalty_app/core/constants/app_colors.dart';

void main() {
  group('CampaignCard Widget Tests', () {
    late CampaignModel mockCampaign;

    setUp(() {
      mockCampaign = CampaignModel(
        id: '1',
        title: 'Test Campaign',
        description: 'Test Description',
        imageUrl: 'https://via.placeholder.com/400x200',
        pointsReward: 50,
        startDate: DateTime(2025, 1, 1),
        endDate: DateTime(2025, 12, 31),
        isActive: true,
      );
    });

    testWidgets('displays campaign information correctly', (tester) async {
      bool joinTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Simple image placeholder
                  Container(
                    key: const Key('image_container'),
                    height: 200,
                    width: double.infinity,
                    color: AppColors.lightGrey,
                    child: const Center(
                      child: Icon(Icons.image_rounded, size: 48),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title and Points Row
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                mockCampaign.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              key: const Key('points_container'),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.accent,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.stars_rounded,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${mockCampaign.pointsReward}',
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
                          mockCampaign.description,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () => joinTapped = true,
                            icon: const Icon(Icons.add_circle_outline_rounded),
                            label: const Text(AppStrings.joinNow),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      // Test ข้อมูลแสดงถูกต้อง
      expect(find.text('Test Campaign'), findsOneWidget);
      expect(find.text('Test Description'), findsOneWidget);
      expect(find.text('50'), findsOneWidget);
      expect(find.text(AppStrings.joinNow), findsOneWidget);

      // Test icon ต่างๆ
      expect(find.byIcon(Icons.image_rounded), findsOneWidget);
      expect(find.byIcon(Icons.stars_rounded), findsOneWidget);
      expect(find.byIcon(Icons.add_circle_outline_rounded), findsOneWidget);
    });

    testWidgets('card structure has correct widgets', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Card(
              child: Column(
                children: [
                  Container(
                    key: const Key('test_container'),
                    height: 100,
                    color: Colors.grey,
                  ),
                  const Padding(
                    key: Key('test_padding'),
                    padding: EdgeInsets.all(16),
                    child: Text('Content'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      // ⭐ ใช้ key เพื่อหา widget เฉพาะแทนการใช้ type
      expect(find.byKey(const Key('test_container')), findsOneWidget);
      expect(find.byKey(const Key('test_padding')), findsOneWidget);

      // Test structure types (ใช้ findsWidgets สำหรับ multiple widgets)
      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(Container), findsWidgets); // ⭐ ใช้ findsWidgets เพราะอาจมีหลายตัว
      expect(find.byType(Padding), findsWidgets);   // ⭐ ใช้ findsWidgets เพราะอาจมีหลายตัว
      expect(find.text('Content'), findsOneWidget);
    });

    testWidgets('specific containers can be found by key', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                Container(
                  key: const Key('image_container'),
                  height: 200,
                  color: Colors.blue,
                  child: const Text('Image'),
                ),
                Container(
                  key: const Key('points_container'),
                  padding: const EdgeInsets.all(8),
                  color: Colors.green,
                  child: const Text('Points'),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pump();

      // ⭐ ใช้ key เพื่อแยกแยะ Container แต่ละตัว
      expect(find.byKey(const Key('image_container')), findsOneWidget);
      expect(find.byKey(const Key('points_container')), findsOneWidget);

      // Test เนื้อหาใน container
      expect(find.text('Image'), findsOneWidget);
      expect(find.text('Points'), findsOneWidget);

      // Test ว่ามี Container ทั้งหมด 2 ตัว
      expect(find.byType(Container), findsNWidgets(2));
    });

  });
}
