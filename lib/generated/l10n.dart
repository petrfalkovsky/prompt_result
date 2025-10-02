// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class Locales {
  Locales();

  static Locales? _current;

  static Locales get current {
    assert(
      _current != null,
      'No instance of Locales was loaded. Try to initialize the Locales delegate before accessing Locales.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<Locales> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = Locales();
      Locales._current = instance;

      return instance;
    });
  }

  static Locales of(BuildContext context) {
    final instance = Locales.maybeOf(context);
    assert(
      instance != null,
      'No instance of Locales present in the widget tree. Did you add Locales.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static Locales? maybeOf(BuildContext context) {
    return Localizations.of<Locales>(context, Locales);
  }

  /// `Describe what you want to see…`
  String get describe {
    return Intl.message(
      'Describe what you want to see…',
      name: 'describe',
      desc: '',
      args: [],
    );
  }

  /// `Generate`
  String get generate {
    return Intl.message('Generate', name: 'generate', desc: '', args: []);
  }

  /// `Try another`
  String get try_another {
    return Intl.message('Try another', name: 'try_another', desc: '', args: []);
  }

  /// `New prompt`
  String get new_prompt {
    return Intl.message('New prompt', name: 'new_prompt', desc: '', args: []);
  }

  /// `Start image generation`
  String get start_image_generation {
    return Intl.message(
      'Start image generation',
      name: 'start_image_generation',
      desc: '',
      args: [],
    );
  }

  /// `Generating image...`
  String get generating_image {
    return Intl.message(
      'Generating image...',
      name: 'generating_image',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `New request`
  String get new_request {
    return Intl.message('New request', name: 'new_request', desc: '', args: []);
  }

  /// `Image upload error`
  String get image_upload_error {
    return Intl.message(
      'Image upload error',
      name: 'image_upload_error',
      desc: '',
      args: [],
    );
  }

  /// `Failed to generate image`
  String get failed_to_generate_image {
    return Intl.message(
      'Failed to generate image',
      name: 'failed_to_generate_image',
      desc: '',
      args: [],
    );
  }

  /// `Error:`
  String get error {
    return Intl.message('Error:', name: 'error', desc: '', args: []);
  }

  /// `Unknown error`
  String get unknown_error {
    return Intl.message(
      'Unknown error',
      name: 'unknown_error',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<Locales> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<Locales> load(Locale locale) => Locales.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
