import 'package:bloom/app/theme/bloom_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Simple scrollable Markdown viewer for bundled legal/trust documents.
class MarkdownDocumentScreen extends StatefulWidget {
  const MarkdownDocumentScreen({
    required this.title,
    required this.assetPath,
    super.key,
  });

  final String title;
  final String assetPath;

  @override
  State<MarkdownDocumentScreen> createState() => _MarkdownDocumentScreenState();
}

class _MarkdownDocumentScreenState extends State<MarkdownDocumentScreen> {
  late final Future<String> _load = rootBundle.loadString(widget.assetPath);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: FutureBuilder<String>(
        future: _load,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Could not load this document.'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            padding: const EdgeInsets.all(BloomSpacing.screenMargin),
            children: [
              SelectableText(
                snapshot.data!,
                style: theme.textTheme.bodyMedium?.copyWith(height: 1.45),
              ),
            ],
          );
        },
      ),
    );
  }
}
