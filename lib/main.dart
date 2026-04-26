import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sakina/sakina_app.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Supabase.initialize(
  url: 'https://gmrfwpntjvcrsbqpvzur.supabase.co',
  anonKey: 'sb_publishable__vpgk7qNq798y_h3_Zs9sQ_zCqC-65D',
  );


  Supabase.instance.client.auth.onAuthStateChange.listen((data) {
    final event = data.event;
    final session = data.session;

    if (event == AuthChangeEvent.signedIn && session != null) {
      navigatorKey.currentState?.pushReplacementNamed('/home');
    } else if (event == AuthChangeEvent.signedOut) {
      navigatorKey.currentState?.pushReplacementNamed('/');
    }
  });

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      startLocale: Locale('en'),
      child: SakinaApp(),
    ),
  );
}