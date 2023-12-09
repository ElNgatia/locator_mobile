part of 'home_cubit.dart';

@immutable
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class LoadingState extends HomeState {
  const LoadingState({required this.message});
  final String message;
  @override
  List<Object?> get props => [];
}

class LoadedState extends HomeState {
  const LoadedState(this.users, this.locations);
  final List<User> users;
  final Map<String, String> locations;

  @override
  List<Object?> get props => [users, locations];
}

class ErrorState extends HomeState {
  const ErrorState({required this.errorMessage});
  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
