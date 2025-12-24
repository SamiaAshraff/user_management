import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pcfc_assignment/core/error/failure.dart';
import 'package:pcfc_assignment/screens/users/data/model/users_model.dart';
import 'package:pcfc_assignment/screens/users/domain/repository/users_repository.dart';

@injectable
class GetAllUsersUseCase {
  final GetAllUsersRepository repository;

  GetAllUsersUseCase(this.repository);

  Future<Either<Failure, List<UsersModel>>> call() async {
    return await repository.getAllUsersApi();
  }
}
