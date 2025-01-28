import 'package:flutter_bloc/flutter_bloc.dart';
import '/data/repositories/users_repository.dart';
import '/models/user.dart';

// Events
abstract class UsersEvent {}

class LoadUsers extends UsersEvent {}

class AddUser extends UsersEvent {
  final User user;
  AddUser(this.user);
}

class UpdateUser extends UsersEvent {
  final User user;
  UpdateUser(this.user);
}

class DeleteUser extends UsersEvent {
  final String userId;
  DeleteUser(this.userId);
}

// States
abstract class UsersState {}

class UsersLoading extends UsersState {}

class UsersLoaded extends UsersState {
  final List<User> users;
  UsersLoaded(this.users);
}

class UsersError extends UsersState {
  final String message;
  UsersError(this.message);
}

// BLoC
class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UsersRepository repository;

  UsersBloc({required this.repository}) : super(UsersLoading()) {
    on<LoadUsers>((event, emit) async {
      emit(UsersLoading());
      try {
        final users = await repository.getUsers();
        emit(UsersLoaded(users));
      } catch (e) {
        emit(UsersError(e.toString()));
      }
    });

    on<AddUser>((event, emit) async {
      emit(UsersLoading());
      try {
        await repository.addUser(event.user);
        final users = await repository.getUsers();
        emit(UsersLoaded(users));
      } catch (e) {
        emit(UsersError(e.toString()));
      }
    });

    on<UpdateUser>((event, emit) async {
      emit(UsersLoading());
      try {
        await repository.updateUser(event.user);
        final users = await repository.getUsers();
        emit(UsersLoaded(users));
      } catch (e) {
        emit(UsersError(e.toString()));
      }
    });

    on<DeleteUser>((event, emit) async {
      emit(UsersLoading());
      try {
        await repository.deleteUser(event.userId);
        final users = await repository.getUsers();
        emit(UsersLoaded(users));
      } catch (e) {
        emit(UsersError(e.toString()));
      }
    });
  }
}

