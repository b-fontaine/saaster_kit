import 'package:dio_mocked_responses/dio_mocked_responses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I connect as {'user'}
Future<void> iConnectAs(WidgetTester tester, String persona) async {
  MockInterceptor.setPersona(persona);
  await tester.tap(find.widgetWithText(ElevatedButton, "Login"));
  await tester.pump();
  await tester.pumpAndSettle(Duration(seconds: 1));
}
