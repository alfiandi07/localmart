import 'package:flutter/material.dart';

/// Widget Logo Kustom LocalMart (Versi Vektor)
/// Digunakan di berbagai halaman seperti Info Aplikasi, Login, Splash, dll.
class LocalMartLogoWidget extends StatelessWidget {
  final double size;
  final Color backgroundColor;
  final Color bagColor;

  const LocalMartLogoWidget({
    super.key,
    this.size = 96,
    this.backgroundColor = const Color(0xFF0025A5),
    this.bagColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(size * 0.22),
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withValues(alpha: 0.35),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Center(
        child: CustomPaint(
          size: Size(size * 0.55, size * 0.55),
          painter: _LocalMartBagPainter(
            bagColor: bagColor,
            accentColor: backgroundColor,
          ),
        ),
      ),
    );
  }
}

/// Custom Painter Lukisan Vektor Tas Belanja LocalMart
class _LocalMartBagPainter extends CustomPainter {
  final Color bagColor;
  final Color accentColor;

  _LocalMartBagPainter({
    required this.bagColor,
    required this.accentColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    // 1. Pegangan Tas (Top Arch Handle)
    final Paint handlePaint = Paint()
      ..color = bagColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.11
      ..strokeCap = StrokeCap.round;

    final Rect handleRect = Rect.fromLTWH(w * 0.3, h * 0.05, w * 0.4, h * 0.4);
    canvas.drawArc(handleRect, 3.14159, 3.14159, false, handlePaint);

    // 2. Badan Tas (Rounded Rectangle Body)
    final Paint bodyPaint = Paint()
      ..color = bagColor
      ..style = PaintingStyle.fill;

    final RRect bodyRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.12, h * 0.28, w * 0.76, h * 0.65),
      Radius.circular(w * 0.12),
    );
    canvas.drawRRect(bodyRRect, bodyPaint);

    // 3. Aksesori Lengkungan "V" Smile di Tengah Tas
    final Paint accentPaint = Paint()
      ..color = accentColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.09
      ..strokeCap = StrokeCap.round;

    final Path accentPath = Path();
    accentPath.moveTo(w * 0.32, h * 0.44);
    accentPath.quadraticBezierTo(w * 0.5, h * 0.62, w * 0.68, h * 0.44);
    canvas.drawPath(accentPath, accentPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
