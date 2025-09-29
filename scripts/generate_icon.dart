import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:math' as math;

void main() async {
  // Create a 1024x1024 image
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  final size = 1024.0;

  // Background circle with gradient
  final backgroundPaint = Paint()
    ..shader = ui.Gradient.linear(
      const Offset(0, 0),
      Offset(size, size),
      [
        const Color(0xFF6366F1), // Indigo 500
        const Color(0xFF8B5CF6), // Violet 500
      ],
    );

  canvas.drawCircle(
    Offset(size / 2, size / 2),
    480,
    backgroundPaint,
  );

  // Inner highlight circle
  final highlightPaint = Paint()
    ..color = const Color(0xFFFFFFFF).withOpacity(0.15)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3;

  canvas.drawCircle(
    Offset(size / 2, size / 2),
    440,
    highlightPaint,
  );

  // Chef hat main body
  final hatPaint = Paint()
    ..shader = ui.Gradient.linear(
      const Offset(0, 0),
      Offset(size, size),
      [
        const Color(0xFFFFFFFF),
        const Color(0xFFF8FAFC),
      ],
    );

  final hatStrokePaint = Paint()
    ..color = const Color(0xFF94A3B8).withOpacity(0.3)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4;

  canvas.drawOval(
    Rect.fromCenter(
      center: const Offset(512, 420),
      width: 360,
      height: 280,
    ),
    hatPaint,
  );

  canvas.drawOval(
    Rect.fromCenter(
      center: const Offset(512, 420),
      width: 360,
      height: 280,
    ),
    hatStrokePaint,
  );

  // Chef hat puffs
  canvas.drawCircle(const Offset(450, 320), 60, hatPaint);
  canvas.drawCircle(const Offset(450, 320), 60, hatStrokePaint);

  canvas.drawCircle(const Offset(512, 300), 70, hatPaint);
  canvas.drawCircle(const Offset(512, 300), 70, hatStrokePaint);

  canvas.drawCircle(const Offset(574, 320), 60, hatPaint);
  canvas.drawCircle(const Offset(574, 320), 60, hatStrokePaint);

  // Chef hat band
  final bandPaint = Paint()
    ..shader = ui.Gradient.linear(
      const Offset(0, 0),
      Offset(size, size),
      [
        const Color(0xFF10B981), // Emerald 500
        const Color(0xFF0EA5E9), // Sky 500
      ],
    );

  canvas.drawRRect(
    RRect.fromRectAndRadius(
      const Rect.fromLTWH(332, 520, 360, 50),
      const Radius.circular(25),
    ),
    bandPaint,
  );

  // AI sparkle
  final sparklePaint = Paint()
    ..color = const Color(0xFFF59E0B).withOpacity(0.9);

  final sparklePath = Path();
  const sparkleCenter = Offset(420, 380);
  const sparkleSize = 25.0;

  for (int i = 0; i < 8; i++) {
    final angle = i * math.pi / 4;
    final radius = i % 2 == 0 ? sparkleSize : sparkleSize * 0.4;
    final x = sparkleCenter.dx + radius * math.cos(angle);
    final y = sparkleCenter.dy + radius * math.sin(angle);

    if (i == 0) {
      sparklePath.moveTo(x, y);
    } else {
      sparklePath.lineTo(x, y);
    }
  }
  sparklePath.close();

  canvas.drawPath(sparklePath, sparklePaint);

  // Small sparkle circles
  canvas.drawCircle(const Offset(580, 360), 8,
      Paint()..color = const Color(0xFFEF4444).withOpacity(0.8));
  canvas.drawCircle(const Offset(440, 480), 6,
      Paint()..color = const Color(0xFF10B981).withOpacity(0.7));
  canvas.drawCircle(const Offset(590, 450), 5,
      Paint()..color = const Color(0xFFF59E0B).withOpacity(0.6));

  // Cooking utensils
  final utensilPaint = Paint()
    ..color = const Color(0xFFFFFFFF).withOpacity(0.3);

  // Spoon
  canvas.drawOval(
    const Rect.fromLTWH(457, 595, 30, 50),
    utensilPaint,
  );
  canvas.drawRRect(
    RRect.fromRectAndRadius(
      const Rect.fromLTWH(467, 645, 10, 80),
      const Radius.circular(5),
    ),
    utensilPaint,
  );

  // Fork
  canvas.drawRRect(
    RRect.fromRectAndRadius(
      const Rect.fromLTWH(547, 620, 10, 105),
      const Radius.circular(5),
    ),
    utensilPaint,
  );

  // Fork tines
  for (int i = 0; i < 3; i++) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(537 + i * 10, 605, 6, 30),
        const Radius.circular(3),
      ),
      utensilPaint,
    );
  }

  // Bottom highlight
  canvas.drawOval(
    const Rect.fromLTWH(212, 800, 600, 100),
    Paint()..color = const Color(0xFFFFFFFF).withOpacity(0.1),
  );

  // Tech dots
  final techDots = [
    (300.0, 200.0, 4.0),
    (724.0, 180.0, 3.0),
    (280.0, 800.0, 3.0),
    (744.0, 820.0, 4.0),
  ];

  final dotPaint = Paint()..color = const Color(0xFFFFFFFF).withOpacity(0.2);

  for (final (x, y, r) in techDots) {
    canvas.drawCircle(Offset(x, y), r, dotPaint);
  }

  // Convert to image
  final picture = recorder.endRecording();
  final image = await picture.toImage(1024, 1024);
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  // Save to file
  final file = File('assets/icons/app_icon_1024.png');
  await file.writeAsBytes(byteData!.buffer.asUint8List());

  print('App icon generated successfully: ${file.path}');
}
