import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:prompt_result/core/theme/app_colors.dart';
import 'package:prompt_result/feature/app/routing/path_route.dart';
import 'package:prompt_result/feature/result/presentation/bloc/image_generator_bloc.dart';
import 'package:prompt_result/generated/l10n.dart';

class PromptScreen extends StatefulWidget {
  final String? initialPrompt;

  const PromptScreen({super.key, this.initialPrompt});

  @override
  State<PromptScreen> createState() => _PromptScreenState();
}

class _PromptScreenState extends State<PromptScreen> with SingleTickerProviderStateMixin {
  late final TextEditingController _promptController;
  late final AnimationController _animationController;
  late final Animation<Color?> _backgroundColorAnimation;
  late final Animation<Color?> _foregroundColorAnimation;

  bool _isButtonActive = false;

  @override
  void initState() {
    super.initState();
    _promptController = TextEditingController(text: widget.initialPrompt);
    _isButtonActive = _promptController.text.isNotEmpty;
    _promptController.addListener(_updateButtonState);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _backgroundColorAnimation = ColorTween(
      begin: AppColors.purple.withOpacity(0.2),
      end: AppColors.purple,
    ).animate(_animationController);

    _foregroundColorAnimation = ColorTween(
      begin: AppColors.purple.withOpacity(0.5),
      end: AppColors.white,
    ).animate(_animationController);

    if (_isButtonActive) {
      _animationController.value = 1.0;
    } else {
      _animationController.value = 0.0;
    }
  }

  void _updateButtonState() {
    final bool isActive = _promptController.text.isNotEmpty;

    if (isActive != _isButtonActive) {
      setState(() {
        _isButtonActive = isActive;
      });

      if (isActive) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _promptController.removeListener(_updateButtonState);
    _promptController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onGeneratePressed() {
    if (_promptController.text.isNotEmpty) {
      context.read<ImageGeneratorBloc>().add(PromptSubmitted(_promptController.text));
      context.goNamed(AppRoute.resultScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.black,
        extendBodyBehindAppBar: true,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _promptController,
                  decoration: InputDecoration(
                    hintText: Locales.of(context).describe,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    contentPadding: EdgeInsets.all(16.0),
                  ),
                  maxLines: 5,
                  minLines: 1,
                  textInputAction: TextInputAction.done,
                  onEditingComplete: _isButtonActive ? _onGeneratePressed : null,
                ),
                SizedBox(height: 20),
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return ElevatedButton(
                      onPressed: _isButtonActive ? _onGeneratePressed : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _backgroundColorAnimation.value,
                        foregroundColor: _foregroundColorAnimation.value,
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: BorderSide(color: AppColors.white.withOpacity(0.3)),
                        ),
                        elevation: _isButtonActive ? 2.0 : 0.0,
                      ),
                      child: child,
                    );
                  },
                  child: Text(
                    Locales.of(context).generate,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
