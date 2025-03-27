import 'package:flutter/material.dart';
import 'dart:math' as math;

class WaveAnimation extends StatelessWidget {
  final AnimationController animationController;
  final bool isRecording;

  const WaveAnimation({
    super.key,
    required this.animationController,
    required this.isRecording,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // ignore: deprecated_member_use
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          ),
          child: Center(
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primary,
              ),
              child: CustomPaint(
                painter: _WavePainter(
                  animation: animationController,
                  isRecording: isRecording,
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Center(
                  child: Icon(
                    Icons.mic,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _WavePainter extends CustomPainter {
  final Animation<double> animation;
  final bool isRecording;
  final Color color;

  _WavePainter({
    required this.animation,
    required this.isRecording,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (!isRecording) return;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;
    
    // Draw outer waves
    for (int i = 3; i >= 0; i--) {
      final waveRadius = radius + 20.0 * (i + 1) + 20.0 * animation.value;
      final opacity = math.max(0.0, 1.0 - (i * 0.25 + animation.value));
      
      final paint = Paint()
        // ignore: deprecated_member_use
        ..color = color.withOpacity(opacity * 0.5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;
      
      canvas.drawCircle(center, waveRadius, paint);
    }
  }

  @override
  bool shouldRepaint(_WavePainter oldDelegate) {
    return animation.value != oldDelegate.animation.value || 
           isRecording != oldDelegate.isRecording;
  }
}