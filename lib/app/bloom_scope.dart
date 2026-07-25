import 'package:bloom/data/bloom_services.dart';
import 'package:bloom/data/domain/care_repository.dart';
import 'package:bloom/data/local/fixture_seeder.dart';
import 'package:flutter/material.dart';

class BloomScope extends InheritedWidget {
  const BloomScope({required this.services, required super.child, super.key});

  final BloomServices services;

  CareRepository get care => services.care;

  FixtureSeeder get seeder => services.seeder;

  static BloomScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<BloomScope>();
    assert(scope != null, 'BloomScope not found in widget tree');
    return scope!;
  }

  @override
  bool updateShouldNotify(BloomScope oldWidget) {
    return oldWidget.services != services;
  }
}
