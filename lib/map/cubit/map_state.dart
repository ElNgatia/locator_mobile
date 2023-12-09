part of 'map_cubit.dart';

abstract class MapState {}

class MapInitial extends MapState {}

class MapLoading extends MapState {}

class MapLoaded extends MapState {
  MapLoaded({required this.location});
  final Map<String, double> location;
}

class MapError extends MapState {
  MapError({required this.message});
  final String message;
}
