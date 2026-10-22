part of 'home_cubit.dart';

class HomeState extends Equatable {
  final bool isServerRunning;
  final int? port;

  const HomeState({required this.isServerRunning, this.port = 8921});

  HomeState copyWith({bool? isServerRunning, int? port, bool clearPort = false}) {
    return HomeState(
      isServerRunning: isServerRunning ?? this.isServerRunning,
      port: clearPort ? null : (port ?? this.port),
    );
  }

  @override
  List<Object?> get props => [isServerRunning, port];
}
