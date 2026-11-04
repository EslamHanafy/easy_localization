import 'dart:ui' as ui;

import 'package:cupertino_ui/cupertino_ui.dart' as cupertino;
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_logger/easy_logger.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utils/test_asset_loaders.dart';

late BuildContext _context;

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      home: Builder(builder: (context) {
        _context = context;
        return const SizedBox.shrink();
      }),
    );
  }
}

void main() async {
  SharedPreferences.setMockInitialValues({});
  EasyLocalization.logger.enableLevels = <LevelMessages>[];
  await EasyLocalization.ensureInitialized();

  testWidgets(
    'delegates provide material_ui and cupertino_ui localizations',
    (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(EasyLocalization(
          path: 'path',
          supportedLocales: const [Locale('en', 'US'), Locale('ar', 'DZ')],
          startLocale: const Locale('ar', 'DZ'),
          assetLoader: const JsonAssetLoader(),
          child: const _App(),
        ));
        await tester.idle();
        await tester.pump();

        expect(_context.locale, const Locale('ar', 'DZ'));
        expect(MaterialLocalizations.of(_context),
            isA<GlobalMaterialLocalizations>());
        expect(cupertino.CupertinoLocalizations.of(_context),
            isA<cupertino.GlobalCupertinoLocalizations>());
        expect(Directionality.of(_context), ui.TextDirection.rtl);
      });
    },
  );
}
