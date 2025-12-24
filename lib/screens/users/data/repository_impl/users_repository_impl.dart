import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pcfc_assignment/core/error/failure.dart';
import 'package:pcfc_assignment/screens/users/data/data_source/remote_users_data_source.dart';
import 'package:pcfc_assignment/screens/users/data/model/users_model.dart';
import 'package:pcfc_assignment/screens/users/domain/repository/users_repository.dart';

@LazySingleton(as: GetAllUsersRepository)
class GetAllUsersRepositoryImpl implements GetAllUsersRepository {
  final RemoteUsersDataSource remoteDataSource;

  GetAllUsersRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> addUser({UsersModel? user}) async {
    return remoteDataSource.addUser(user!);
  }

  @override
  Future<Either<Failure, UsersModel?>> getUserById(String id)async{
    return remoteDataSource.getUserById(id);
  }

  @override
  Future<Either<Failure, List<UsersModel>>> getAllUsersApi() async {
    return remoteDataSource.getAllUsers();
  }

  @override
  Future<Either<Failure, void>> updateUserById(UsersModel user) async {
    return remoteDataSource.updateUser(user);
  }

  @override
  Future<Either<Failure, void>> deleteUser(String userId) {
    return remoteDataSource.deleteUser(userId);
  }
}
