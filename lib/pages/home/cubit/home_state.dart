part of 'home_cubit.dart';

class HomeState extends Equatable {
  final bool isServerRunning;

  const HomeState({required this.isServerRunning});

  @override
  List<Object> get props => [isServerRunning];
}
