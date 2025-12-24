import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pcfc_assignment/core/error/failure.dart';
import 'package:pcfc_assignment/screens/users/data/model/users_model.dart';
import 'package:pcfc_assignment/screens/users/domain/repository/users_repository.dart';

@injectable
class UpdateUserByIdUseCase {
  final GetAllUsersRepository repository;

  UpdateUserByIdUseCase(this.repository);

  Future<Either<Failure, void>> call(UsersModel user) async {
    return await repository.updateUserById(user);
  }
}
