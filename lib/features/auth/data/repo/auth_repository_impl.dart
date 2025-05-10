import 'package:dartz/dartz.dart';
import 'package:inventory_project/core/failures/failures.dart';
import 'package:inventory_project/features/auth/data/data%20source/auth_remote_data_source.dart';
import 'package:inventory_project/features/auth/domain/entities/auth_user_entity.dart';
import 'package:inventory_project/features/auth/domain/repo/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> login(
      String email, String password) async {
    try {
      final authResult = await remoteDataSource.login(email, password);

      if (authResult == null) {
        return Left(Failure("Invalid email or password"));
      }
      final userId = authResult['id'] as String;

      final userData = await remoteDataSource.getUserData(userId);
      final user = UserEntity(
        id: userData['id'] as String,
        name: userData['name'] as String,
        role: userData['role'] as String,
      );

      return Right(user);
    } catch (e) {
      print("AuthRepositoryImpl.login: Error: $e");
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDataSource.logout();
      return Right(null);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<String, UserEntity>> checkAuthState() async {
    return await remoteDataSource.checkAuthState();
  }
}
