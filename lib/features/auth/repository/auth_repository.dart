import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthRepository {
  final supabase = Supabase.instance.client;

  Future<void> login({
    required String email,
    required String password,
    required String role,
  }) async {
    await supabase.auth.signInWithPassword(email: email, password: password);
    await supabase.auth.updateUser(UserAttributes(data: {'role': role}));
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
    required String university,
  }) async {
    await supabase.auth.signUp(
      email: email,
      password: password,
      data: {
        'full_name': fullName,
        'university': university,
      },
    );
  }

  Future<void> logout() async {
    await supabase.auth.signOut();
  }

  Future<void> signInWithGoogle() async {
  await supabase.auth.signInWithOAuth(
    OAuthProvider.google,
    redirectTo: kIsWeb
        ? 'http://localhost:59013'
        : 'io.supabase.sakina://login-callback/',
    authScreenLaunchMode: kIsWeb
        ? LaunchMode.platformDefault
        : LaunchMode.externalApplication,
  );
}

Future<void> signInWithMicrosoft() async {
  await supabase.auth.signInWithOAuth(
    OAuthProvider.azure,
    redirectTo: kIsWeb
        ? 'http://localhost:59013'
        : 'io.supabase.sakina://login-callback/',
    authScreenLaunchMode: kIsWeb
        ? LaunchMode.platformDefault
        : LaunchMode.externalApplication,
  );
}
}