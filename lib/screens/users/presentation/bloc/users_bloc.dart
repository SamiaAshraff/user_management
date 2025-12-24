import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:pcfc_assignment/screens/users/data/model/users_model.dart';
import 'package:pcfc_assignment/screens/users/domain/use_case/add_user_use_case.dart';
import 'package:pcfc_assignment/screens/users/domain/use_case/delete_user_use_case.dart';
import 'package:pcfc_assignment/screens/users/domain/use_case/get_all_users_use_case.dart';
import 'package:pcfc_assignment/screens/users/domain/use_case/get_user_by_id_use_case.dart';
import 'package:pcfc_assignment/screens/users/domain/use_case/update_user_by_id_use_case.dart';

part 'users_event.dart';
part 'users_state.dart';

@injectable
class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final AddUserUseCase addUserUseCase;
  final GetAllUsersUseCase getAllUsersUseCase;
  final DeleteUserUseCase deleteUserUseCase;
  final GetUserByIdUseCase getUserByIdUseCase;
  final UpdateUserByIdUseCase updateUserByIdUseCase;
  UsersBloc({
    required this.addUserUseCase,
    required this.getAllUsersUseCase,
    required this.deleteUserUseCase,
    required this.getUserByIdUseCase,
    required this.updateUserByIdUseCase,
  }) : super(UsersInitial()) {
    on<AddUserEvent>(_addUserEvent);
    on<GetAllUsersEvent>(_getAllUsersEvent);
    on<DeleteUserEvent>(_onDeleteUserEvent);
    on<GetUserByIdEvent>(_onGetUserByIdEvent);
    on<UpdateUserByIdEvent>(_onUpdateUserByIdEvent);
  }
  Future<void> _addUserEvent(
    AddUserEvent event,
    Emitter<UsersState> emit,
  ) async {
    emit(UsersLoading());
    await addUserUseCase(event.user);
    add(GetAllUsersEvent());
  }

  Future<void> _getAllUsersEvent(
    GetAllUsersEvent event,
    Emitter<UsersState> emit,
  ) async {
    emit(UsersLoading());
    final data = await getAllUsersUseCase();
    data.fold((l) => emit(UsersError(l.message.toString())), (users) {
      emit(UsersLoaded(users));
    });
  }

  Future<void> _onGetUserByIdEvent(
    GetUserByIdEvent event,
    Emitter<UsersState> emit,
  ) async {
    emit(UsersLoading());
    final userData = await getUserByIdUseCase(event.userId);
    userData.fold((l) => emit(UsersError(l.message.toString())), (user) {
      if (user != null) emit(UserDetailsLoaded(user));
    });
  }

  Future<void> _onUpdateUserByIdEvent(
    UpdateUserByIdEvent event,
    Emitter<UsersState> emit,
  ) async {
    emit(UsersLoading());
    await updateUserByIdUseCase(event.user);
    emit(UserUpdateSuccess());
  }

  Future<void> _onDeleteUserEvent(
    DeleteUserEvent event,
    Emitter<UsersState> emit,
  ) async {
    emit(UsersLoading());
    await deleteUserUseCase(event.userId);
    add(GetAllUsersEvent());
    emit(UserUpdateSuccess());
  }
}
