import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:prompt_result/generated/l10n.dart';

@lazySingleton
class ImageData {
  Future<String> generate(String prompt) async {
    try {
      await Future.delayed(Duration(seconds: 3));

      if (Random().nextBool()) {
        throw Exception(Locales.current.failed_to_generate_image);
      }

      return 'https://placehold.co/600x400';
    } catch (e) {
      rethrow;
    }
  }
}
