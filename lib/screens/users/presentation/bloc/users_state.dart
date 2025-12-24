part of 'users_bloc.dart';

abstract class UsersState extends Equatable {
  @override
  List<Object> get props => [];
}

class UsersInitial extends UsersState {}

class UsersLoading extends UsersState {}

class UsersLoaded extends UsersState {
  final List<UsersModel> symbols;

  UsersLoaded(this.symbols);

  @override
  List<Object> get props => [symbols];
}

class UserDetailsLoaded extends UsersState {
  final UsersModel user;

  UserDetailsLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class UserUpdateSuccess extends UsersState {}

class UsersError extends UsersState {
  final String message;

  UsersError(this.message);

  @override
  List<Object> get props => [message];
}
