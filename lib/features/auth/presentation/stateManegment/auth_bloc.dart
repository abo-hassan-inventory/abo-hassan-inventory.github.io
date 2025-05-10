import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:inventory_project/core/failures/failures.dart';
import 'package:inventory_project/features/auth/domain/entities/auth_user_entity.dart';
import 'package:inventory_project/features/auth/domain/usecase/auth_usecase.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UseCase Case;

  AuthBloc({required this.Case}) : super(AuthInitial()) {
    // loging in methode
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());

      final Either<Failure, UserEntity> result =
          await Case.login(event.email, event.password);

      result.fold(
        (failure) => emit(AuthFailure(failure.message)),
        (user) => emit(AuthSuccess(user)),
      );
    });

    // login out methode
    on<LogoutEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await Case.logout();
      result.fold(
        (failure) => emit(AuthFailure(failure.message)),
        (_) => emit(AuthLoggedOut()),
      );
    });

    on<checkAuthstate>((event, emit) async {
      emit(AuthLoading());

      final result = await Case.checkAuthstate();
      result.fold(
        (error) => emit(AuthFailure(error)),
        (user) {
          emit(AuthSuccess(user));
        },
      );
    });
  }
}
