
// test/widget_tests/button_test.dart - เทสปุ่มแยก
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jenosize_loyalty_app/core/constants/app_string.dart';
import 'package:jenosize_loyalty_app/core/widgets/custom_button.dart';

void main() {
  group('Custom Button Tests', () {
    testWidgets('custom button displays correctly', (tester) async {
      bool buttonTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              text: AppStrings.joinNow,
              onPressed: () => buttonTapped = true,
              icon: Icons.add_circle_outline_rounded,
            ),
          ),
        ),
      );

      await tester.pump();


      // Verify button exists and has correct text
      expect(find.byType(CustomButton), findsOneWidget);
      expect(find.text(AppStrings.joinNow), findsOneWidget);
      expect(find.byIcon(Icons.add_circle_outline_rounded), findsOneWidget);

      // Test tap
      await tester.tap(find.byType(CustomButton));
      await tester.pump();

      expect(buttonTapped, isTrue);
    });

    testWidgets('loading button shows spinner', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              text: 'Loading...',
              onPressed: null,
              isLoading: true,
            ),
          ),
        ),
      );

      await tester.pump();

      // Should show CircularProgressIndicator when loading
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
