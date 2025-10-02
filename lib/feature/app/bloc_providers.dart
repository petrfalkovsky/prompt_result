part of 'app.dart';


List<BlocProvider> buildListProviders({required GetIt locator}) {
  return <BlocProvider>[
    BlocProvider<ImageGeneratorBloc>(create: (context) => locator<ImageGeneratorBloc>()),
  ];
}
