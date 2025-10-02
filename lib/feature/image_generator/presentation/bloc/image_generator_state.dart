part of 'image_generator_bloc.dart';

sealed class ImageGeneratorState extends Equatable {
  const ImageGeneratorState();
  
  @override
  List<Object> get props => [];
}

final class ImageGeneratorInitial extends ImageGeneratorState {}
