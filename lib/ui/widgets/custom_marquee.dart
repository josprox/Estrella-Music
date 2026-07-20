import 'dart:async';
import 'package:flutter/material.dart';

class Marquee extends StatefulWidget {
  final String id;
  final Widget child;
  final Duration delay;
  final Duration duration;

  const Marquee({
    super.key,
    required this.id,
    required this.child,
    this.delay = const Duration(milliseconds: 300),
    this.duration = const Duration(seconds: 5),
  });

  @override
  State<Marquee> createState() => _MarqueeState();
}

class _MarqueeState extends State<Marquee> {
  late final ScrollController _scrollController;
  Timer? _timer;
  bool _scrollingForward = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAnimation();
    });
  }

  void _startAnimation() {
    if (!mounted) return;
    _timer?.cancel();
    _timer = Timer(widget.delay, () {
      _animate();
    });
  }

  void _animate() {
    if (!mounted || !_scrollController.hasClients) return;
    
    final maxExtent = _scrollController.position.maxScrollExtent;
    if (maxExtent <= 0) return;

    final target = _scrollingForward ? maxExtent : 0.0;
    final currentPosition = _scrollController.position.pixels;
    final distance = (target - currentPosition).abs();
    
    if (distance < 0.1) {
      _scrollingForward = !_scrollingForward;
      _startAnimation();
      return;
    }

    final speed = maxExtent / widget.duration.inMilliseconds; // pixels per ms
    final durationMs = (distance / speed).clamp(100.0, 60000.0).toInt();

    _scrollController.animateTo(
      target,
      duration: Duration(milliseconds: durationMs),
      curve: Curves.linear,
    ).then((_) {
      if (mounted) {
        _scrollingForward = !_scrollingForward;
        _startAnimation();
      }
    });
  }

  @override
  void didUpdateWidget(covariant Marquee oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.id != widget.id) {
      _scrollingForward = true;
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(0);
      }
      _startAnimation();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      child: widget.child,
    );
  }
}
