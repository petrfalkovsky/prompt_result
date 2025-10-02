import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:prompt_result/core/constants/resources/app_animations.dart';
import 'package:prompt_result/core/constants/resources/app_images.dart';
import 'package:prompt_result/generated/l10n.dart';

class ImageGenerationSuccess extends StatelessWidget {
  final String imageUrl;

  const ImageGenerationSuccess({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Image.network(
              imageUrl,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: Lottie.asset(
                    AppAnimations.loadingCircle,
                    width: 200,
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppImages.placeholder, width: 200),
                      Text(Locales.current.image_upload_error),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        ElevatedButton(onPressed: () => context.pop(), child: Text(Locales.current.new_prompt)),
      ],
    );
  }
}
