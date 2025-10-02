import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prompt_result/core/constants/enums/image_state_enum.dart';
import 'package:prompt_result/core/theme/app_colors.dart';
import 'package:prompt_result/feature/app/routing/path_route.dart';
import 'package:prompt_result/feature/result/presentation/bloc/image_generator_bloc.dart';
import 'package:prompt_result/generated/l10n.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              CircularProgressIndicator(),
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
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.broken_image, size: 64),
                            Text(Locales.current.image_upload_error),
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
                    onPressed: () {
                      context.read<ImageGeneratorBloc>().add(PromptSubmitted(state.prompt));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.black,
                      foregroundColor: AppColors.white,
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
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
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
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
              Icon(Icons.error_outline, size: 64, color: Colors.red),
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
                  backgroundColor: AppColors.black,
                  foregroundColor: AppColors.white,
                  padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                ),
                child: Text(Locales.current.retry),
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
