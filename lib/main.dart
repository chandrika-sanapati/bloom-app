import 'package:bloom/app/bloom_app.dart';
import 'package:bloom/app/hot_restart.dart';
import 'package:bloom/data/auth/auth_config.dart';
import 'package:bloom/data/bloom_services.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  clearHotRestartPorts();
  if (AuthConfig.isConfigured) {
    await Supabase.initialize(
      url: AuthConfig.supabaseUrl.trim(),
      publishableKey: AuthConfig.supabaseAnonKey.trim(),
      authOptions: const FlutterAuthClientOptions(
        authFlowType: AuthFlowType.pkce,
      ),
    );
  }
  final services = await BloomServices.bootstrap();
  runApp(BloomApp(services: services));
}
