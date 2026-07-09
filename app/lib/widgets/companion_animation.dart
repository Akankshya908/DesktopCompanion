import 'dart:async';

import 'package:flutter/material.dart';

class CompanionAnimation extends StatefulWidget {
  const CompanionAnimation({
    super.key,
    this.loop = false,
    this.width = 180,
    this.height = 180,
  });

  final bool loop;
  final double width;
  final double height;

  @override
  State<CompanionAnimation> createState() => _CompanionAnimationState();
}

class _CompanionAnimationState extends State<CompanionAnimation> {
  static const int _frameCount = 51;
  static const Duration _frameDuration = Duration(milliseconds: 83);

  late final List<String> _framePaths;
  Timer? _timer;
  int _currentFrameIndex = 0;

  @override
  void initState() {
    super.initState();
    _framePaths = List<String>.generate(
      _frameCount,
      (index) => 'assets/sprites/ezgif-frame-${(index + 1).toString().padLeft(3, '0')}.png',
    );
    _startAnimation();
  }

  @override
  void didUpdateWidget(covariant CompanionAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.loop != widget.loop) {
      if (widget.loop) {
        _startAnimation();
      } else {
        _stopAnimation();
      }
    }
  }

  @override
  void dispose() {
    _stopAnimation();
    super.dispose();
  }

  void _startAnimation() {
    _stopAnimation();

    if (!widget.loop && _currentFrameIndex >= _framePaths.length - 1) {
      return;
    }

    _timer = Timer.periodic(_frameDuration, (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        if (widget.loop) {
          _currentFrameIndex = (_currentFrameIndex + 1) % _framePaths.length;
        } else if (_currentFrameIndex < _framePaths.length - 1) {
          _currentFrameIndex++;
        } else {
          _stopAnimation();
        }
      });
    });
  }

  void _stopAnimation() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  Widget build(BuildContext context) {
    final framePath = _framePaths.isNotEmpty ? _framePaths[_currentFrameIndex] : '';

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Container(
        color: Colors.transparent,
        child: Image.asset(
          framePath,
          width: widget.width,
          height: widget.height,
          fit: BoxFit.contain,
          gaplessPlayback: true,
          excludeFromSemantics: true,
          errorBuilder: (context, error, stackTrace) {
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
