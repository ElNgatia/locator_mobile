import 'package:bloc/bloc.dart';
import 'package:locator_mobile/data/model/user.dart';


part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial());

  void extractLocation(List<User> users) {
    try {
      final locationMap = <String, double>{};
      for (final user in users) {
        locationMap[user.id] = double.parse(user.currentLat);
        locationMap[user.id] = double.parse(user.currentLon);
      }
      emit(MapLoaded(location: locationMap));
    } on Exception catch (_) {
      emit(MapError(message: 'Failed to load map data'));
    }
  }
}
