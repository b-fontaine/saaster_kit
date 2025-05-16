import 'package:flutter_test/flutter_test.dart';

/// Usage: I should see a {ElevatedButton} with text {"Login"}
Future<void> iShouldSeeAWithText(
    WidgetTester tester, Type widget, String text) async {
  expect(find.widgetWithText(widget, text), findsOneWidget);
}
