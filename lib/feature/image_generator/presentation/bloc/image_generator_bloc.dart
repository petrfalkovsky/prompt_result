import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'image_generator_event.dart';
part 'image_generator_state.dart';

@lazySingleton
class ImageGeneratorBloc extends Bloc<ImageGeneratorEvent, ImageGeneratorState> {
  ImageGeneratorBloc() : super(ImageGeneratorInitial()) {
    on<ImageGeneratorEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
