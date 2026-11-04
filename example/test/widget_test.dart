import 'package:easy_localization/easy_localization.dart';
import 'package:example/generated/codegen_loader.g.dart';
import 'package:example/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    EasyLocalization.logger.enableBuildModes = [];
    await EasyLocalization.ensureInitialized();
  });

  testWidgets('renders translated text and counter plural',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(EasyLocalization(
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ar', 'DZ'),
          Locale('de', 'DE'),
          Locale('ru', 'RU'),
        ],
        startLocale: const Locale('en', 'US'),
        path: 'resources/langs',
        assetLoader: const CodegenLoader(),
        child: const MyApp(),
      ));
      await tester.idle();
    });
    await tester.pumpAndSettle();

    expect(find.text('Hello'), findsOneWidget);
    expect(find.byIcon(Icons.language), findsOneWidget);
    expect(find.text("You didn't click yet!"), findsOneWidget);

    await tester.tap(find.text('+1'));
    await tester.pumpAndSettle();
    expect(find.text('You clicked 1 time(s)!'), findsOneWidget);
  });
}
