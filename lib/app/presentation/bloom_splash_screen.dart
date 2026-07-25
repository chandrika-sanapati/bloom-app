import 'package:bloom/app/theme/bloom_colors.dart';
import 'package:bloom/shared/widgets/bloom_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Branded launch animation shown once after the native splash hands off.
class BloomSplashScreen extends StatefulWidget {
  const BloomSplashScreen({
    required this.onFinished,
    this.duration = const Duration(milliseconds: 1700),
    super.key,
  });

  final VoidCallback onFinished;
  final Duration duration;

  @override
  State<BloomSplashScreen> createState() => _BloomSplashScreenState();
}

class _BloomSplashScreenState extends State<BloomSplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _logoOpacity;
  late final Animation<double> _logoScale;
  late final Animation<double> _glowOpacity;
  late final Animation<double> _wordmarkOpacity;
  late final Animation<Offset> _wordmarkOffset;
  late final Animation<double> _exitOpacity;
  var _finished = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _logoOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.42, curve: Curves.easeOutCubic),
    );
    _logoScale = Tween<double>(begin: 0.82, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.48, curve: Curves.easeOutBack),
      ),
    );
    _glowOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.08, 0.55, curve: Curves.easeOut),
      ),
    );
    _wordmarkOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.34, 0.68, curve: Curves.easeOutCubic),
    );
    _wordmarkOffset =
        Tween<Offset>(begin: const Offset(0, 0.18), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.34, 0.72, curve: Curves.easeOutCubic),
          ),
        );
    _exitOpacity = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.82, 1.0, curve: Curves.easeInCubic),
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _finish();
      }
    });

    // Avoid starting animations in the same frame as the first paint.
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  void _finish() {
    if (_finished || !mounted) {
      return;
    }
    _finished = true;
    widget.onFinished();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Opacity(
          opacity: _exitOpacity.value.clamp(0.0, 1.0),
          child: DecoratedBox(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  BloomColors.canvas,
                  BloomColors.brandGreenSoft,
                  BloomColors.seaSalt,
                ],
                stops: [0.0, 0.55, 1.0],
              ),
            ),
            child: SafeArea(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 168,
                      height: 168,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Opacity(
                            opacity: _glowOpacity.value * 0.9,
                            child: Container(
                              width: 132,
                              height: 36,
                              margin: const EdgeInsets.only(top: 110),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(999),
                                boxShadow: [
                                  BoxShadow(
                                    color: BloomColors.brandGreen.withValues(
                                      alpha: 0.22,
                                    ),
                                    blurRadius: 28,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          FadeTransition(
                            opacity: _logoOpacity,
                            child: ScaleTransition(
                              scale: _logoScale,
                              child: const BloomLogo(size: 108),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    FadeTransition(
                      opacity: _wordmarkOpacity,
                      child: SlideTransition(
                        position: _wordmarkOffset,
                        child: Text(
                          'Bloom',
                          style: textTheme.titleLarge?.copyWith(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.4,
                            color: BloomColors.labelPrimary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    FadeTransition(
                      opacity: _wordmarkOpacity,
                      child: Text(
                        'Plant care, kept simple',
                        style: textTheme.bodySmall?.copyWith(
                          color: BloomColors.labelTertiary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
