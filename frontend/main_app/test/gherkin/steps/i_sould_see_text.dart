import 'package:flutter_test/flutter_test.dart';

/// Usage: I sould see text {"Welcome, John Doe"}
Future<void> iSouldSeeText(WidgetTester tester, String text) async {
  expect(find.text(text), findsOneWidget);
}
