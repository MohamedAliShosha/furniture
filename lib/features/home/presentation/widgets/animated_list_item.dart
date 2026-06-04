import 'package:flutter/material.dart';

class AnimatedListItem extends StatefulWidget {
  const AnimatedListItem({
    super.key,
    required this.child,
    required this.index,
    this.isVertical = true,
  });
  final Widget child;
  final int index;
  final bool isVertical;

  @override
  State<AnimatedListItem> createState() => _AnimatedListItemState();
}

class _AnimatedListItemState extends State<AnimatedListItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _slideAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    final delay = widget.index * 60;
    Future.delayed(Duration(milliseconds: delay), () {
      if (mounted) {
        _controller.forward();
      }
    });
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.0,
          0.75,
          curve: Curves.easeOut,
        ),
      ),
    );
    _slideAnimation =
        Tween<double>(begin: widget.isVertical ? 50 : 30, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.0,
          0.75,
          curve: Curves.easeOut,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildAnimatedChild() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Align(
        alignment: Alignment.center,
        child: Transform.scale(
          scale: _scaleAnimation.value,
          child: Transform.translate(
            offset: widget.isVertical
                ? Offset(0, _slideAnimation.value)
                : Offset(_slideAnimation.value, 0),
            child: Opacity(
              opacity: _scaleAnimation.value,
              child: widget.child,
            ),
          ),
        ),
      ),
      child: widget.child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.hasBoundedWidth && constraints.hasBoundedHeight) {
          return SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: _buildAnimatedChild(),
          );
        } else {
          return _buildAnimatedChild();
        }
      },
    );
  }
}
