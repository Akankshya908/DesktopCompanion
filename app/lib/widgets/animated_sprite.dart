import 'dart:async';

import 'package:flutter/material.dart';

import '../core/services/sprite_loader.dart';
import '../models/companion_state.dart';

class AnimatedSprite extends StatefulWidget {
  const AnimatedSprite({
    super.key,
    required this.state,
    this.width = 96,
    this.height = 96,
    this.frameDuration = const Duration(milliseconds: 120),
  });

  final CompanionState state;
  final double width;
  final double height;
  final Duration frameDuration;

  @override
  State<AnimatedSprite> createState() => _AnimatedSpriteState();
}

class _AnimatedSpriteState extends State<AnimatedSprite> {
  Timer? _timer;
  int _frameIndex = 0;
  late List<String> _frames;

  @override
  void initState() {
    super.initState();
    _frames = SpriteLoader.framesForState(widget.state);
    _startAnimation();
  }

  @override
  void didUpdateWidget(covariant AnimatedSprite oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.state != widget.state) {
      _frames = SpriteLoader.framesForState(widget.state);
      _frameIndex = 0;
      _restartAnimation();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startAnimation() {
    _timer?.cancel();
    if (_frames.length <= 1) {
      return;
    }

    _timer = Timer.periodic(widget.frameDuration, (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _frameIndex = (_frameIndex + 1) % _frames.length;
      });
    });
  }

  void _restartAnimation() {
    _timer?.cancel();
    if (_frames.length <= 1) {
      return;
    }

    _timer = Timer.periodic(widget.frameDuration, (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _frameIndex = (_frameIndex + 1) % _frames.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final framePath = _frames.isNotEmpty ? _frames[_frameIndex] : SpriteLoader.defaultSpritePath();

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Image.asset(
        framePath,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            SpriteLoader.defaultSpritePath(),
            fit: BoxFit.contain,
          );
        },
      ),
    );
  }
}
