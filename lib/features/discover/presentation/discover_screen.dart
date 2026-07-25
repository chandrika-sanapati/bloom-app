import 'package:bloom/app/theme/bloom_spacing.dart';
import 'package:flutter/material.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(BloomSpacing.screenMargin),
        children: [
          Text(
            'Search is always available next to scanning.',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: BloomSpacing.x4),
          SearchBar(
            hintText: 'Search for plants',
            leading: const Icon(Icons.search),
            onTap: () {},
            onChanged: (_) {},
          ),
          const SizedBox(height: BloomSpacing.x4),
          Card(
            child: ListTile(
              leading: Icon(
                Icons.document_scanner_outlined,
                color: theme.colorScheme.primary,
              ),
              title: const Text('Scan a plant'),
              subtitle: const Text(
                'Camera identification will land here after the technical spike.',
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          ),
          const SizedBox(height: BloomSpacing.x8),
          Icon(Icons.eco_outlined, size: 40, color: theme.colorScheme.primary),
          const SizedBox(height: BloomSpacing.x3),
          Text(
            'Find your plant',
            style: theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: BloomSpacing.x2),
          Text(
            'Manual search stays available even when the camera, network, or identification confidence fails.',
            style: theme.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
