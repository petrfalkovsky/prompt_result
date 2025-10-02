import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:prompt_result/core/constants/enums/image_state_enum.dart';
import 'package:prompt_result/feature/result/data/image_data.dart';

part 'image_generator_event.dart';
part 'image_generator_state.dart';

@lazySingleton
class ImageGeneratorBloc extends Bloc<ImageGeneratorEvent, ImageGeneratorState> {
  final ImageData _provider;

  ImageGeneratorBloc(this._provider) : super(const ImageGeneratorState()) {
    on<PromptSubmitted>(_onPromptSubmitted);
  }

  Future<void> _onPromptSubmitted(PromptSubmitted event, Emitter<ImageGeneratorState> emit) async {
    try {
      emit(state.copyWith(status: ImageStateEnum.loading, prompt: event.prompt, error: null));

      final image = await _provider.generate(event.prompt);

      emit(state.copyWith(status: ImageStateEnum.success, imageUrl: image, error: null));
    } catch (e) {
      emit(state.copyWith(status: ImageStateEnum.failure, error: e.toString()));
    }
  }
}
