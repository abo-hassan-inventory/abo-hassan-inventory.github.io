import 'package:dartz/dartz.dart';
import 'package:inventory_project/features/auth/domain/entities/auth_user_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSource({required this.supabaseClient});

  Future<Map<String, dynamic>?> login(String email, String password) async {
    try {
      // محاولة تسجيل الدخول باستخدام signInWithPassword
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      // لو مفيش مستخدم، رجع null
      if (response.user == null) {
        print(
            "AuthRemoteDataSource.login: No user returned from signInWithPassword");
        return null;
      }

      return {
        'id': response.user!.id,
        'email': response.user!.email,
      };
    } catch (e) {
      print("AuthRemoteDataSource.login: Error at the login root: $e");
      // بنرمي استثناء هنا عشان نقدر نعالجه في الريبو
      throw Exception('Login failed: $e');
    }
  }

  //--------getting the user data full date seperated from the login process
  Future<Map<String, dynamic>> getUserData(String userId) async {
    try {
      final result = await supabaseClient
          .from('clients')
          .select('id, role, name')
          .eq('id', userId)
          .maybeSingle();

      if (result == null) {
        throw Exception("User not found in clients table for id: $userId");
      }
      return result;
    } catch (e) {
      print("AuthRemoteDataSource.getUserData: Error fetching user data - $e");
      throw Exception("Error fetching user data: $e");
    }
  }

  Future<void> logout() async {
    try {
      await supabaseClient.auth.signOut();
    } catch (e) {
      print("AuthRemoteDataSource.logout: Error occurred - $e");
      throw Exception('Logout failed: $e');
    }
  }

  Future<Either<String, UserEntity>> checkAuthState() async {
    try {
      final session = supabaseClient.auth.currentSession;
      if (session == null) {
        return Left("User is not logged in.");
      }

      final userId = session.user.id;

      // Fetch user details from `clients` table
      final response = await supabaseClient
          .from('clients')
          .select('id, role, name')
          .eq('id', userId)
          .single();

      final userEntity = UserEntity(
        id: response['id'],
        name: response['name'],
        role: response['role'],
      );

      return Right(userEntity);
    } catch (e) {
      return Left("Error checking auth state: ${e.toString()}");
    }
  }
}
