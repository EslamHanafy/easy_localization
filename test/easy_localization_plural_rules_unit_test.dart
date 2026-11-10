import 'dart:developer';

import 'package:easy_localization/src/easy_localization_controller.dart';
import 'package:easy_localization/src/localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils/test_asset_loaders.dart';

void main() {
  // Setup
  var r = EasyLocalizationController(
      forceLocale: const Locale('fb'),
      supportedLocales: [const Locale('en'), const Locale('ar'), const Locale('ru'), const Locale('fb')],
      fallbackLocale: const Locale('fb'),
      path: 'path',
      useOnlyLangCode: true,
      useFallbackTranslations: true,
      onLoadError: (FlutterError e) {
        log(e.toString());
      },
      saveLocale: false,
      assetLoader: const JsonAssetLoader());

  setUpAll(() async {
    await r.loadTranslations();
  });

  group('English plural', () {
    test('English one (no ignorePluralRules)', () async {
      Localization.load(
        const Locale('en'),
        translations: r.translations,
        fallbackTranslations: r.fallbackTranslations,
        ignorePluralRules: false,
      );

      expect(Localization.instance.plural('hat', 1), 'one hat');
    });
    test('English all cases (no ignorePluralRules)', () async {
      Localization.load(
        const Locale('en'),
        translations: r.translations,
        fallbackTranslations: r.fallbackTranslations,
        ignorePluralRules: false,
      );

      expect(Localization.instance.plural('hat', 1), 'one hat');
      expect(Localization.instance.plural('hat', 0), 'no hats');
      expect(Localization.instance.plural('hat', 2), 'other hats');
      expect(Localization.instance.plural('hat', 3), 'other hats');
      expect(Localization.instance.plural('hat', 4), 'other hats');
      expect(Localization.instance.plural('hat', 11), 'other hats');
      expect(Localization.instance.plural('hat', 101), 'other hats');
      expect(Localization.instance.plural('hat', 111), 'other hats');
    });
    test('English all cases (with ignorePluralRules) | using `_pluralCaseFallback`', () async {
      Localization.load(
        const Locale('en'),
        translations: r.translations,
        fallbackTranslations: r.fallbackTranslations,
        ignorePluralRules: true,
      );

      expect(Localization.instance.plural('hat', 0), 'no hats');
      expect(Localization.instance.plural('hat', 1), 'one hat');
      expect(Localization.instance.plural('hat', 2), 'two hats');
      expect(Localization.instance.plural('hat', 3), 'other hats');
      expect(Localization.instance.plural('hat', 4), 'other hats');
      expect(Localization.instance.plural('hat', 11), 'other hats');
      expect(Localization.instance.plural('hat', 101), 'other hats');
      expect(Localization.instance.plural('hat', 111), 'other hats');
    });
  });

  group('Russian plural', () {
    test('Russian one', () async {
      Localization.load(
        const Locale('ru'),
        translations: r.translations,
        fallbackTranslations: r.fallbackTranslations,
      );
      expect(Localization.instance.plural('hat', 1), 'one hat');
    });
    test('Russian few (no ignorePluralRules)', () async {
      Localization.load(
        const Locale('ru'),
        translations: r.translations,
        fallbackTranslations: r.fallbackTranslations,
        ignorePluralRules: false,
      );
      expect(Localization.instance.plural('hat', 2), 'few hats');
      expect(Localization.instance.plural('hat', 3), 'few hats');
    });
    test('Russian few (with ignorePluralRules)', () async {
      Localization.load(
        const Locale('ru'),
        translations: r.translations,
        fallbackTranslations: r.fallbackTranslations,
        ignorePluralRules: true,
      );
      expect(Localization.instance.plural('hat', 2), 'two hats');
      expect(Localization.instance.plural('hat', 3), 'other hats');
    });
    test('Russian many (no ignorePluralRules)', () async {
      Localization.load(
        const Locale('ru'),
        translations: r.translations,
        fallbackTranslations: r.fallbackTranslations,
        ignorePluralRules: false,
      );
      expect(Localization.instance.plural('hat', 0), 'no hats');
      expect(Localization.instance.plural('hat', 5), 'many hats');
      expect(Localization.instance.plural('hat', 101), 'one hat');
    });
    test('Russian many (with ignorePluralRules)', () async {
      Localization.load(
        const Locale('ru'),
        translations: r.translations,
        fallbackTranslations: r.fallbackTranslations,
        ignorePluralRules: true,
      );
      expect(Localization.instance.plural('hat', 0), 'no hats');
      expect(Localization.instance.plural('hat', 5), 'other hats');
      expect(Localization.instance.plural('hat', 101), 'other hats');
    });
  });

  group("Arabic plural", () {
    test('Arabic few (no ignorePluralRules)', () async {
      Localization.load(
        const Locale('ar'),
        translations: r.translations,
        fallbackTranslations: r.fallbackTranslations,
        ignorePluralRules: false,
      );
      expect(Localization.instance.plural('hat', 2), 'two hats');
      expect(Localization.instance.plural('hat', 10), 'few hats');
      expect(Localization.instance.plural('hat', 110), 'few hats');
    });
    test('Arabic few (with ignorePluralRules)', () async {
      Localization.load(
        const Locale('ar'),
        translations: r.translations,
        fallbackTranslations: r.fallbackTranslations,
        ignorePluralRules: true,
      );
      expect(Localization.instance.plural('hat', 2), 'two hats');
      expect(Localization.instance.plural('hat', 3), 'other hats');
      expect(Localization.instance.plural('hat', 10), 'other hats');
      expect(Localization.instance.plural('hat', 110), 'other hats');
    });
    test('Arabic many (no ignorePluralRules)', () async {
      Localization.load(
        const Locale('ar'),
        translations: r.translations,
        fallbackTranslations: r.fallbackTranslations,
        ignorePluralRules: false,
      );

      expect(Localization.instance.plural('hat', 11), 'many hats');
      expect(Localization.instance.plural('hat', 111), 'many hats');
    });
    test('Arabic many (with ignorePluralRules)', () async {
      Localization.load(
        const Locale('ar'),
        translations: r.translations,
        fallbackTranslations: r.fallbackTranslations,
        ignorePluralRules: true,
      );
      expect(Localization.instance.plural('hat', 10), 'other hats');
      expect(Localization.instance.plural('hat', 11), 'other hats');
      expect(Localization.instance.plural('hat', 111), 'other hats');
    });
    test('Arabic all cases (no ignorePluralRules)', () async {
      Localization.load(
        const Locale('ar'),
        translations: r.translations,
        fallbackTranslations: r.fallbackTranslations,
        ignorePluralRules: false,
      );

      expect(Localization.instance.plural('hat', 0), 'no hats');
      expect(Localization.instance.plural('hat', 1), 'one hat');
      expect(Localization.instance.plural('hat', 2), 'two hats');
      expect(Localization.instance.plural('hat', 3), 'few hats');
      expect(Localization.instance.plural('hat', 4), 'few hats');
      expect(Localization.instance.plural('hat', 11), 'many hats');
      expect(Localization.instance.plural('hat', 101), 'other hats');
      expect(Localization.instance.plural('hat', 111), 'many hats');
      expect(Localization.instance.plural('hat', 103), 'few hats');
    });
    test('Arabic all cases (with ignorePluralRules) | using `_pluralCaseFallback`', () async {
      Localization.load(
        const Locale('ar'),
        translations: r.translations,
        fallbackTranslations: r.fallbackTranslations,
        ignorePluralRules: true,
      );

      expect(Localization.instance.plural('hat', 0), 'no hats');
      expect(Localization.instance.plural('hat', 1), 'one hat');
      expect(Localization.instance.plural('hat', 2), 'two hats');
      expect(Localization.instance.plural('hat', 3), 'other hats');
      expect(Localization.instance.plural('hat', 4), 'other hats');
      expect(Localization.instance.plural('hat', 11), 'other hats');
      expect(Localization.instance.plural('hat', 101), 'other hats');
      expect(Localization.instance.plural('hat', 111), 'other hats');
      expect(Localization.instance.plural('hat', 103), 'other hats');
    });
  });

  group('Explicit zero text', () {
    test('English 0 uses the zero entry when it exists (rules ON)', () async {
      Localization.load(
        const Locale('en'),
        translations: r.translations,
        fallbackTranslations: r.fallbackTranslations,
        ignorePluralRules: false,
      );
      expect(Localization.instance.plural('hat', 0), 'no hats');
    });
    test('English 0 falls back to other when there is no zero entry (rules ON)', () async {
      Localization.load(
        const Locale('en'),
        translations: r.translations,
        fallbackTranslations: r.fallbackTranslations,
        ignorePluralRules: false,
      );
      expect(Localization.instance.plural('hat_other', 0), 'other hats');
    });
    test('English 0 ignores a zero entry that only the fallback has (rules ON)', () async {
      final en = EasyLocalizationController(
          forceLocale: const Locale('en'),
          supportedLocales: [const Locale('en'), const Locale('fb')],
          fallbackLocale: const Locale('fb'),
          path: 'path',
          useOnlyLangCode: true,
          useFallbackTranslations: true,
          onLoadError: (FlutterError e) {
            log(e.toString());
          },
          saveLocale: false,
          assetLoader: const JsonAssetLoader());
      await en.loadTranslations();
      Localization.load(
        const Locale('en'),
        translations: en.translations,
        fallbackTranslations: en.fallbackTranslations,
        ignorePluralRules: false,
      );
      expect(Localization.instance.plural('test_fallback_plurals', 0), '0 seconds');
    });
    test('English 1 and 5 keep their plural rule cases (rules ON)', () async {
      Localization.load(
        const Locale('en'),
        translations: r.translations,
        fallbackTranslations: r.fallbackTranslations,
        ignorePluralRules: false,
      );
      expect(Localization.instance.plural('hat', 1), 'one hat');
      expect(Localization.instance.plural('hat', 5), 'other hats');
    });
    test('Arabic 0 uses the zero entry (rules ON, unchanged)', () async {
      Localization.load(
        const Locale('ar'),
        translations: r.translations,
        fallbackTranslations: r.fallbackTranslations,
        ignorePluralRules: false,
      );
      expect(Localization.instance.plural('hat', 0), 'no hats');
    });
  });
}
