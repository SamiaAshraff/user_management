import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:pcfc_assignment/core/error/failure.dart';
import 'package:pcfc_assignment/screens/users/data/model/users_model.dart';

abstract class RemoteUsersDataSource {
  Future<Either<Failure, int>> addUser(UsersModel user);
  Future<Either<Failure, UsersModel?>> getUserById(String id);
  Future<Either<Failure, void>> deleteUser(String id);
  Future<Either<Failure, void>> updateUser(UsersModel user);
  Future<Either<Failure, List<UsersModel>>> getAllUsers();
}

@LazySingleton(as: RemoteUsersDataSource)
class RemoteUsersDataSourceImpl extends RemoteUsersDataSource {
  final http.Client client;

  RemoteUsersDataSourceImpl({required this.client});
  final String boxName = dotenv.env['HIVE_DB_NAME'] ?? '';

  // please note the below hive db name does not belong here,
  // it is commented for running application purpose
  // final String boxName = 'usersBox';

  @override
  Future<Either<Failure, int>> addUser(UsersModel user) async {
    try {
      final box = Hive.box<UsersModel>(boxName);
      final id = await box.add(user); // Auto-increment ID
      return Right(id);
    } catch (e) {
      return Left(CacheFailure('Failed to add user: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, UsersModel?>> getUserById(String id) async {
    try {
      final box = Hive.box<UsersModel>(boxName);

      // Find the box entry where user.id matches
      final entry = box.toMap().entries.firstWhere((e) => e.value.id == id);

      return Right(entry.value);
    } catch (e) {
      return Left(CacheFailure('Failed to get user: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUser(String id) async {
    try {
      final box = Hive.box<UsersModel>(boxName);
      final entry = box.toMap().entries.firstWhere((e) => e.value.id == id);
      await box.delete(entry.key);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to delete user: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> updateUser(UsersModel user) async {
    try {
      final box = Hive.box<UsersModel>(boxName);
      final entry = box.toMap().entries.firstWhere(
        (e) => e.value.id == user.id,
      );
      await box.put(entry.key, user);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to update user: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<UsersModel>>> getAllUsers() async {
    try {
      final box = Hive.box<UsersModel>(boxName);

      // Convert box values directly to List<UsersModel>
      final users = box.values.toList();

      return Right(users);
    } catch (e) {
      return Left(CacheFailure('Failed to load users: ${e.toString()}'));
    }
  }
}
