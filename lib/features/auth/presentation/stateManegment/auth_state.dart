import 'package:equatable/equatable.dart';
import 'package:inventory_project/features/auth/domain/entities/auth_user_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserEntity user;
  const AuthSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class AuthLoggedOut extends AuthState {}

class AuthFailure extends AuthState {
  final String message;
  const AuthFailure(this.message);

  @override
  List<Object> get props => [message];
}

class authenticated extends AuthState {
  final UserEntity user;
  const authenticated(this.user);
}

class unauthenticated extends AuthState {}
