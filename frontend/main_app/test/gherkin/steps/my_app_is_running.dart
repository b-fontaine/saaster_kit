import 'package:dio_mocked_responses/dio_mocked_responses.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:saaster/injection.dart';
import 'package:saaster/ui/ui_module.dart';

/// Usage: My app is running
Future<void> myAppIsRunning(WidgetTester tester) async {
  MockInterceptor.clearHistory();
  Intl.defaultLocale = 'fr_FR';
  await initializeDateFormatting('fr_FR', null);
  getIt.allowReassignment = true;
  configureDependencies(environment: Environment.test);
  TestWidgetsFlutterBinding.ensureInitialized();
  await tester.pumpWidget(UiModule());
  await tester.pumpAndSettle();
}
