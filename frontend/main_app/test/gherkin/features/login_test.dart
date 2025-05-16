// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/my_app_is_running.dart';
import './step/i_should_see_a_with_text.dart';
import './step/i_connect_as.dart';
import './step/i_sould_see_text.dart';

void main() {
  group('''Login''', () {
    testWidgets('''Login page by default''', (tester) async {
      await myAppIsRunning(tester);
      await iShouldSeeAWithText(tester, ElevatedButton, "Login");
    });
    testWidgets('''Logged user can see his profile''', (tester) async {
      await myAppIsRunning(tester);
      await iConnectAs(tester, 'john');
      await iSouldSeeText(tester, "Welcome, John Doe");
    });
  });
}
