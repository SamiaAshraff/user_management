import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pcfc_assignment/core/error/failure.dart';
import 'package:pcfc_assignment/screens/users/data/model/users_model.dart';
import 'package:pcfc_assignment/screens/users/domain/repository/users_repository.dart';

@injectable
class GetUserByIdUseCase {
  final GetAllUsersRepository repository;

  GetUserByIdUseCase(this.repository);

  Future<Either<Failure, UsersModel?>> call(String id) async {
    return await repository.getUserById(id);
  }
}
