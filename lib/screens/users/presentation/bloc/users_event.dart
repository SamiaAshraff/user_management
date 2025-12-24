part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchUsers extends UsersEvent {}

class AddUserEvent extends UsersEvent {
  final UsersModel user;
  AddUserEvent({required this.user});
}

class GetAllUsersEvent extends UsersEvent {}

class GetUserByIdEvent extends UsersEvent {
  final String userId;
  GetUserByIdEvent({required this.userId});
}

class UpdateUserByIdEvent extends UsersEvent {
  final UsersModel user;
  UpdateUserByIdEvent({required this.user});
}

class DeleteUserEvent extends UsersEvent {
  final String userId;
  DeleteUserEvent({required this.userId});
}
