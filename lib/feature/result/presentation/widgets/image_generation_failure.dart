import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prompt_result/core/constants/resources/app_images.dart';
import 'package:prompt_result/generated/l10n.dart';

class ImageGenerationFailure extends StatelessWidget {
  final String error;

  const ImageGenerationFailure({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppImages.placeholder, width: 200),
          Text('${Locales.current.error} $error'),
          ElevatedButton(onPressed: () => context.pop(), child: Text(Locales.current.retry)),
        ],
      ),
    );
  }
}
