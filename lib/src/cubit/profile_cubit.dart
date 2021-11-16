import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:task_helper/src/models/user.dart';
import 'package:task_helper/src/task_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final TaskRepository taskRepository;
  final String userId;

  ProfileCubit(this.taskRepository, this.userId) : super(ProfileInitial()) {
    update();
  }

  Future<void> update() async {
    emit(ProfileLoading());

    try {
      final user = await taskRepository.getUserById(userId);
      emit(ProfileLoaded(user));
    } catch (e) {
      debugPrint(e.toString());
      // TODO Error message
      emit(const ProfileError('Failed to load profile'));
    }
  }
}
