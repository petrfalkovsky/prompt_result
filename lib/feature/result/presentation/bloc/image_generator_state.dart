part of 'image_generator_bloc.dart';

class ImageGeneratorState extends Equatable {
  final ImageStateEnum status;
  final String prompt;
  final String? imageUrl;
  final String? error;

  const ImageGeneratorState({
    this.status = ImageStateEnum.initial,
    this.prompt = '',
    this.imageUrl,
    this.error,
  });

  ImageGeneratorState copyWith({
    ImageStateEnum? status,
    String? prompt,
    String? imageUrl,
    String? error,
  }) {
    return ImageGeneratorState(
      status: status ?? this.status,
      prompt: prompt ?? this.prompt,
      imageUrl: imageUrl ?? this.imageUrl,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, prompt, imageUrl, error];
}
