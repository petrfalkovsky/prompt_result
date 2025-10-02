part of 'image_generator_bloc.dart';

@immutable
abstract class ImageGeneratorEvent extends Equatable {
  const ImageGeneratorEvent();

  @override
  List<Object> get props => [];
}

class PromptSubmitted extends ImageGeneratorEvent {
  final String prompt;

  const PromptSubmitted(this.prompt);

  @override
  List<Object> get props => [prompt];
}
