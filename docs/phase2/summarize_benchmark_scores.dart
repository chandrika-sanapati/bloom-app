// ignore_for_file: avoid_print
/// Summarize Phase 2 identification benchmark scores (no API keys).
///
/// Usage (from repo root):
///   dart run docs/phase2/summarize_benchmark_scores.dart
///   dart run docs/phase2/summarize_benchmark_scores.dart path/to/scores.csv
///
/// Pass thresholds (PRD): top-1 ≥ 70%, top-3 ≥ 90%, median ≤ 5000ms, p95 ≤ 10000ms.
import 'dart:io';

void main(List<String> args) {
  final path = args.isEmpty
      ? 'docs/phase2/benchmark_scores.csv'
      : args.first;
  final file = File(path);
  if (!file.existsSync()) {
    stderr.writeln('Missing $path');
    exitCode = 1;
    return;
  }

  final lines = file
      .readAsLinesSync()
      .map((line) => line.trim())
      .where((line) => line.isNotEmpty)
      .toList();
  if (lines.length < 2) {
    print('No score rows yet in $path');
    print('Fill rows after calling Pl@ntNet and plant.id, then re-run.');
    return;
  }

  final header = _splitCsv(lines.first);
  final idx = {for (var i = 0; i < header.length; i++) header[i]: i};
  for (final required in [
    'provider',
    'top1_match',
    'top3_match',
    'latency_ms',
    'non_plant_rejected',
  ]) {
    if (!idx.containsKey(required)) {
      stderr.writeln('CSV missing column: $required');
      exitCode = 1;
      return;
    }
  }

  final byProvider = <String, _Bucket>{};
  for (final line in lines.skip(1)) {
    final cols = _splitCsv(line);
    if (cols.length < header.length) {
      continue;
    }
    final provider = cols[idx['provider']!];
    final bucket = byProvider.putIfAbsent(provider, _Bucket.new);
    bucket.n += 1;
    if (_yes(cols[idx['top1_match']!])) {
      bucket.top1 += 1;
    }
    if (_yes(cols[idx['top3_match']!])) {
      bucket.top3 += 1;
    }
    final latency = int.tryParse(cols[idx['latency_ms']!]);
    if (latency != null) {
      bucket.latencies.add(latency);
    }
    final nonPlant = cols[idx['non_plant_rejected']!];
    if (nonPlant != 'na' && nonPlant.isNotEmpty) {
      bucket.nonPlantTotal += 1;
      if (_yes(nonPlant)) {
        bucket.nonPlantRejected += 1;
      }
    }
  }

  if (byProvider.isEmpty) {
    print('No parsable score rows in $path');
    return;
  }

  print('Benchmark summary for $path\n');
  for (final entry in byProvider.entries) {
    final b = entry.value;
    final top1 = b.n == 0 ? 0.0 : b.top1 / b.n;
    final top3 = b.n == 0 ? 0.0 : b.top3 / b.n;
    final median = _percentile(b.latencies, 0.50);
    final p95 = _percentile(b.latencies, 0.95);
    final pass =
        top1 >= 0.70 &&
        top3 >= 0.90 &&
        median != null &&
        p95 != null &&
        median <= 5000 &&
        p95 <= 10000;

    print('Provider: ${entry.key}');
    print('  n=${b.n}');
    print('  top-1=${(top1 * 100).toStringAsFixed(1)}% (need ≥70%)');
    print('  top-3=${(top3 * 100).toStringAsFixed(1)}% (need ≥90%)');
    print(
      '  latency median=${median ?? "-"}ms p95=${p95 ?? "-"}ms '
      '(need ≤5000 / ≤10000)',
    );
    if (b.nonPlantTotal > 0) {
      print('  non-plant rejected=${b.nonPlantRejected}/${b.nonPlantTotal}');
    }
    print('  PRD quality+latency gate: ${pass ? "PASS" : "FAIL / incomplete"}');
    print('');
  }
  print(
    'Next: update IDENTIFICATION_BENCHMARK.md decision log to '
    'plantnet, plant_id, or keep defer.',
  );
}

class _Bucket {
  var n = 0;
  var top1 = 0;
  var top3 = 0;
  var nonPlantTotal = 0;
  var nonPlantRejected = 0;
  final latencies = <int>[];
}

bool _yes(String value) => value.trim().toLowerCase() == 'y';

List<String> _splitCsv(String line) {
  // Simple comma split; benchmark template does not use quoted commas.
  return line.split(',').map((part) => part.trim()).toList();
}

int? _percentile(List<int> values, double p) {
  if (values.isEmpty) {
    return null;
  }
  final sorted = [...values]..sort();
  final rank = p * (sorted.length - 1);
  final low = rank.floor();
  final high = rank.ceil();
  if (low == high) {
    return sorted[low];
  }
  final weight = rank - low;
  return (sorted[low] * (1 - weight) + sorted[high] * weight).round();
}
