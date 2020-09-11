import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

enum _AniProps { opacity }

class FadeIn extends StatelessWidget {
  final Widget child;
  final double delay;

  FadeIn(this.child, this.delay);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<_AniProps>()
      ..add(_AniProps.opacity, 0.0.tweenTo(1.0));

    return PlayAnimation<MultiTweenValues<_AniProps>>(
      duration: 1.seconds,
      delay: delay.seconds,
      tween: tween,
      child: child,
      builder: (context, child, value) => Opacity(
        opacity: value.get(_AniProps.opacity),
        child: child,
      ),
    );
  }
}
