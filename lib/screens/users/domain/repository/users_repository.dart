import 'package:dartz/dartz.dart';
import 'package:pcfc_assignment/core/error/failure.dart';
import 'package:pcfc_assignment/screens/users/data/model/users_model.dart';

abstract class GetAllUsersRepository {
  Future<Either<Failure, List<UsersModel>>> getAllUsersApi();
  Future<Either<Failure, void>> addUser({UsersModel user});
  Future<Either<Failure, UsersModel?>> getUserById(String id);
  Future<Either<Failure, void>> updateUserById(UsersModel user);
  Future<Either<Failure, void>> deleteUser(String userId);
}
