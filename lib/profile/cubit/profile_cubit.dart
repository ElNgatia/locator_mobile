import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:locator_mobile/data/model/user.dart';
import 'package:locator_mobile/data/repo/user_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required this.userRepository}) : super(ProfileInitial());
  final UserRepository userRepository;

  Future<void> fetchUserProfile(String userId) async {
    try {
      emit(ProfileLoading());

      final users = await userRepository.fetchUserData();

      final user = users.firstWhere((user) => user.id == userId);

      emit(ProfileLoaded(user));
    } catch (e) {
      emit(ProfileError('Error: $e'));
    }
  }
}
