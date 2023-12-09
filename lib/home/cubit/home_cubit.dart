import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:locator_mobile/data/model/user.dart';
import 'package:locator_mobile/data/repo/user_repository.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  Future<void> fetchUsers() async {
    emit(const LoadingState(message: 'Loading users'));

    try {
      // Fetch users or perform any async operations
      final users = await UserRepository().fetchUserData();
      final locations =
          <String, String>{}; // Map to store user IDs and their locations

      for (final user in users) {
        // Fetch geocoded location for each user
        await fetchLocation(
          double.parse(user.currentLat),
          double.parse(user.currentLon),
        ).then((location) {
          locations[user.id] = location;
        }).catchError((_) {
          print('err');
          return null;
        });
      }

      emit(LoadedState(users, locations));
    } catch (e) {
      emit(ErrorState(errorMessage: 'Error fetching users: $e'));
    }
  }

  Future<String> fetchLocation(double latitude, double longitude) async {
    try {
      final placemarks = await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        return placemarks.first.name ?? 'Unknown';
      } else {
        throw Exception('No location found');
      }
    } on PlatformException catch (e) {
      if (e.code == 'NOT_FOUND') {
        return 'No address found';
      } else {
        throw Exception('Error fetching user information');
      }
    } catch (e) {
      throw Exception('Error fetching user information');
    }
  }
}
