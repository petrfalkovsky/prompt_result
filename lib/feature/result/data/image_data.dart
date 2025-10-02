import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:prompt_result/core/constants/resources/app_images.dart';
import 'package:prompt_result/generated/l10n.dart';

@lazySingleton
class ImageData {
  bool _lastSuccess = false;

  Future<String> generate(String prompt) async {
    try {
      await Future.delayed(Duration(milliseconds: 2000 + Random().nextInt(1000)));

      _lastSuccess = !_lastSuccess;

      if (!_lastSuccess) {
        throw Exception(Locales.current.failed_to_generate_image);
      }

      return AppImages.placeholder;
    } catch (e) {
      rethrow;
    }
  }
}
