import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:prompt_result/core/constants/enums/image_state_enum.dart';
import 'package:prompt_result/core/constants/resources/app_animations.dart';
import 'package:prompt_result/core/constants/resources/app_images.dart';
import 'package:prompt_result/core/theme/app_colors.dart';
import 'package:prompt_result/feature/app/routing/path_route.dart';
import 'package:prompt_result/feature/result/presentation/bloc/image_generator_bloc.dart';
import 'package:prompt_result/generated/l10n.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocBuilder<ImageGeneratorBloc, ImageGeneratorState>(
            builder: (context, state) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _buildContent(context, state),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ImageGeneratorState state) {
    switch (state.status) {
      case ImageStateEnum.loading:
        return Center(
          key: ValueKey('loading'),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                AppAnimations.loadingCircle,
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20),
              Text(Locales.current.generating_image, style: TextStyle(fontSize: 16)),
            ],
          ),
        );

      case ImageStateEnum.success:
        return Column(
          key: ValueKey('success'),
          children: [
            Expanded(
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    state.imageUrl!,
                    fit: BoxFit.contain,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;

                      // Используем Lottie анимацию вместо CircularProgressIndicator
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Lottie.asset(
                              AppAnimations.loadingCircle,
                              width: 150,
                              height: 150,
                              fit: BoxFit.contain,
                            ),
                            // Если хотите отображать процент загрузки
                            if (loadingProgress.expectedTotalBytes != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  '${((loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!) * 100).toStringAsFixed(0)}%',
                                  style: TextStyle(color: AppColors.white, fontSize: 14),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(AppImages.placeholder, width: 200),
                            Text(
                              Locales.current.image_upload_error,
                              style: TextStyle(color: AppColors.white),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () =>
                        context.read<ImageGeneratorBloc>().add(PromptSubmitted(state.prompt)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.purple,
                      foregroundColor: AppColors.white,
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                    ),
                    child: Text(Locales.of(context).try_another),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => context.goNamed(AppRoute.promptScreen, extra: state.prompt),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.white,
                      foregroundColor: AppColors.purple,
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: BorderSide(color: Colors.grey.withOpacity(0.3)),
                      ),
                    ),
                    child: Text(Locales.of(context).new_prompt),
                  ),
                ),
              ],
            ),
          ],
        );

      case ImageStateEnum.failure:
        return Center(
          key: ValueKey('failure'),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppImages.placeholder),
              SizedBox(height: 12),
              Text(
                '${Locales.current.error} ${state.error ?? Locales.current.unknown_error}',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  context.read<ImageGeneratorBloc>().add(PromptSubmitted(state.prompt));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.purple,
                  foregroundColor: AppColors.white,
                  padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                ),
                child: Text(Locales.current.try_another),
              ),
              SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  context.goNamed(AppRoute.promptScreen, extra: state.prompt);
                },
                child: Text(Locales.of(context).new_prompt),
              ),
            ],
          ),
        );

      default:
        return Center(child: Text(Locales.current.start_image_generation));
    }
  }
}
