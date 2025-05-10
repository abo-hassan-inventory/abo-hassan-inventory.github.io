import 'package:dartz/dartz.dart';
import 'package:inventory_project/core/failures/failures.dart';
import 'package:inventory_project/features/auth/domain/entities/auth_user_entity.dart';
import 'package:inventory_project/features/auth/domain/repo/auth_repository.dart';

class UseCase {
  final AuthRepository repository;

  UseCase(this.repository);

  Future<Either<Failure, UserEntity>> login(String email, String password) {
    return repository.login(email, password);
  }

  Future<Either<Failure, void>> logout() async {
    return await repository.logout();
  }

  Future<Either<String, UserEntity>> checkAuthstate() async {
    return await repository.checkAuthState();
  }
}
