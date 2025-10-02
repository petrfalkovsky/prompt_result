import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:prompt_result/feature/image_generator/presentation/bloc/image_generator_bloc.dart';

List<BlocProvider> buildListProviders({required GetIt locator}) {
  return <BlocProvider>[
    BlocProvider<ImageGeneratorBloc>(create: (context) => locator<ImageGeneratorBloc>()),
  ];
}
