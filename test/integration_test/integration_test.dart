import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pixabay/main.dart' as app;

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('test navigation from screen to screen', () {
    testWidgets('verify favorite screen', (widgetTester) async {
      app.main();
      await widgetTester.pumpAndSettle();
      expect(find.byType(AnimatedContainer), findsOneWidget);
      await widgetTester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.byType(InkWell), findsOneWidget);
      await widgetTester.tap(find.byType(InkWell));
      await widgetTester.pumpAndSettle(const Duration(seconds: 2));

      expect(find.byType(Text), findsOneWidget);
    });
  });
}
