import 'package:bloom/app/bloom_app.dart';
import 'package:bloom/app/hot_restart.dart';
import 'package:bloom/data/bloom_services.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  clearHotRestartPorts();
  final services = await BloomServices.bootstrap();
  runApp(BloomApp(services: services));
}
