class UserEntity {
  final String id;
  final String name;
  final String role; // لازم يكون فيه قيمة "admin" أو "user"

  UserEntity({required this.id, required this.name, required this.role});
}
