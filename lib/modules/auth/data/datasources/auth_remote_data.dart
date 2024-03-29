import 'package:gawa/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteData {
  Future<String> loginWithEmail(
      {required String email, required String password});
  Future<String> registerWithEmail(
      {required String email, required String password});
  Future<String> logout();
  Future<String> getCurrentUser();
}

class AuthRemoteDataImpl implements AuthRemoteData {
  final SupabaseClient supabaseClient;
  AuthRemoteDataImpl({required this.supabaseClient});

  @override
  Future<String> loginWithEmail(
      {required String email, required String password}) async {
    await Future.delayed(Duration(seconds: 1));
    return 'token';
  }

  @override
  Future<String> registerWithEmail(
      {required String email, required String password}) async {
    try {
      final response =
          await supabaseClient.auth.signUp(email: email, password: password);
      if (response.user == null) {
        throw const ServerException('User is null');
      }
      return response.user!.id;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> logout() async {
    await Future.delayed(Duration(seconds: 1));
    return 'token';
  }

  @override
  Future<String> getCurrentUser() async {
    await Future.delayed(Duration(seconds: 1));
    return 'token';
  }
}
