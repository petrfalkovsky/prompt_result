import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prompt_result/core/constants/enums/image_state_enum.dart';
import 'package:prompt_result/feature/app/routing/path_route.dart';
import 'package:prompt_result/feature/result/presentation/bloc/image_generator_bloc.dart';
import 'package:prompt_result/generated/l10n.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ImageGeneratorBloc, ImageGeneratorState>(
        builder: (context, state) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 150),
            child: _buildContent(context, state),
          );
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, ImageGeneratorState state) {
    switch (state.status) {
      case ImageStateEnum.loading:
        return Center(key: ValueKey('loading'), child: CircularProgressIndicator());

      case ImageStateEnum.success:
        return Column(
          children: [
            Expanded(
              child: Center(
                child: Image.network(
                  state.imageUrl!,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(child: CircularProgressIndicator());
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
            ElevatedButton(
              onPressed: () => context.goNamed(AppRoute.promptScreen),
              child: Text(Locales.of(context).new_prompt),
            ),
          ],
        );

      case ImageStateEnum.failure:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64),
              Text('${Locales.current.error} ${state.error ?? Locales.current.unknown_error}'),
              ElevatedButton(
                onPressed: () => context.goNamed(AppRoute.promptScreen),
                child: Text(Locales.of(context).try_another),
              ),
            ],
          ),
        );

      default:
        return Center(child: Text(Locales.current.start_image_generation));
    }
  }
}
