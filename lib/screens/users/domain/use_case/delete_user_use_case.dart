import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pcfc_assignment/core/error/failure.dart';
import 'package:pcfc_assignment/screens/users/domain/repository/users_repository.dart';

@injectable
class DeleteUserUseCase {
  final GetAllUsersRepository repository;

  DeleteUserUseCase(this.repository);

  Future<Either<Failure, void>> call(String userId) async {
    return await repository.deleteUser(userId);
  }
}
