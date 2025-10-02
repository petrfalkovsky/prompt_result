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

class _PromptScreenState extends State<PromptScreen> {
  late final TextEditingController _promptController;
  bool _isButtonActive = false;

  @override
  void initState() {
    super.initState();
    _promptController = TextEditingController(text: widget.initialPrompt);
    _isButtonActive = _promptController.text.isNotEmpty;
    _promptController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      _isButtonActive = _promptController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _promptController.removeListener(_updateButtonState);
    _promptController.dispose();
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
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                    contentPadding: EdgeInsets.all(16.0),
                  ),
                  maxLines: 5,
                  minLines: 1,
                  textInputAction: TextInputAction.done,
                  onEditingComplete: _isButtonActive ? _onGeneratePressed : null,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isButtonActive ? _onGeneratePressed : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isButtonActive ? AppColors.black : AppColors.white,
                    foregroundColor: _isButtonActive ? AppColors.white : Colors.grey,
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: Colors.grey.withOpacity(0.3)),
                    ),
                    elevation: _isButtonActive ? 2.0 : 0.0,
                  ),
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
