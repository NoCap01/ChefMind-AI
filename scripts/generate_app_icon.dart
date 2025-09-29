import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Create the icon
  final iconWidget = AppIconWidget();
  final iconBytes = await _widgetToImage(iconWidget, 1024, 1024);

  // Save the icon
  final file = File('assets/icons/app_icon_1024.png');
  await file.writeAsBytes(iconBytes);

  print('App icon generated successfully at: ${file.path}');
}

Future<Uint8List> _widgetToImage(Widget widget, int width, int height) async {
  final repaintBoundary = RenderRepaintBoundary();
  final renderView = RenderView(
    child: RenderPositionedBox(
      alignment: Alignment.center,
      child: repaintBoundary,
    ),
    configuration: ViewConfiguration(
      size: Size(width.toDouble(), height.toDouble()),
      devicePixelRatio: 1.0,
    ),
    window: WidgetsBinding.instance.window,
  );

  final pipelineOwner = PipelineOwner();
  final buildOwner = BuildOwner(focusManager: FocusManager());

  pipelineOwner.rootNode = renderView;
  renderView.prepareInitialFrame();

  final rootElement = RenderObjectToWidgetAdapter<RenderBox>(
    container: repaintBoundary,
    child: widget,
  ).attachToRenderTree(buildOwner);

  buildOwner.buildScope(rootElement);
  buildOwner.finalizeTree();

  pipelineOwner.flushLayout();
  pipelineOwner.flushCompositingBits();
  pipelineOwner.flushPaint();

  final image = await repaintBoundary.toImage(pixelRatio: 1.0);
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  return byteData!.buffer.asUint8List();
}

class AppIconWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1024,
      height: 1024,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF6366F1), // Indigo 500
            Color(0xFF8B5CF6), // Violet 500
          ],
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withOpacity(0.3),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Inner highlight circle
          Container(
            width: 880,
            height: 880,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 4,
              ),
            ),
          ),

          // Chef hat
          Positioned(
            top: 200,
            child: CustomPaint(
              size: const Size(400, 400),
              painter: ChefHatPainter(),
            ),
          ),

          // AI Sparkles
          Positioned(
            top: 300,
            left: 400,
            child: CustomPaint(
              size: const Size(60, 60),
              painter: SparklePainter(),
            ),
          ),

          Positioned(
            top: 350,
            right: 350,
            child: Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: Color(0xFFF59E0B),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Positioned(
            top: 420,
            left: 350,
            child: Container(
              width: 16,
              height: 16,
              decoration: const BoxDecoration(
                color: Color(0xFF10B981),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Cooking utensils
          Positioned(
            bottom: 200,
            child: CustomPaint(
              size: const Size(200, 200),
              painter: UtensilsPainter(),
            ),
          ),

          // Bottom accent
          Positioned(
            bottom: 50,
            child: Container(
              width: 600,
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.1),
                    Colors.transparent,
                  ],
                ),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChefHatPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.white, Color(0xFFF1F5F9)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = const Color(0xFF64748B).withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;

    // Chef hat main body
    final path = Path();
    path.moveTo(size.width * 0.5, size.height * 0.2);
    path.quadraticBezierTo(
      size.width * 0.8,
      size.height * 0.2,
      size.width * 0.85,
      size.height * 0.5,
    );
    path.lineTo(size.width * 0.85, size.height * 0.8);
    path.quadraticBezierTo(
      size.width * 0.85,
      size.height * 0.9,
      size.width * 0.75,
      size.height * 0.9,
    );
    path.lineTo(size.width * 0.25, size.height * 0.9);
    path.quadraticBezierTo(
      size.width * 0.15,
      size.height * 0.9,
      size.width * 0.15,
      size.height * 0.8,
    );
    path.lineTo(size.width * 0.15, size.height * 0.5);
    path.quadraticBezierTo(
      size.width * 0.2,
      size.height * 0.2,
      size.width * 0.5,
      size.height * 0.2,
    );
    path.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path, strokePaint);

    // Chef hat band
    final bandPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF10B981), Color(0xFF0EA5E9)],
      ).createShader(Rect.fromLTWH(
        size.width * 0.15,
        size.height * 0.8,
        size.width * 0.7,
        size.height * 0.1,
      ));

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.15,
          size.height * 0.8,
          size.width * 0.7,
          size.height * 0.1,
        ),
        const Radius.circular(20),
      ),
      bandPaint,
    );

    // Hat pleats
    final pleatPaint = Paint()
      ..color = const Color(0xFF64748B).withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(size.width * 0.3, size.height * 0.35),
      Offset(size.width * 0.35, size.height * 0.25),
      pleatPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.45, size.height * 0.3),
      Offset(size.width * 0.5, size.height * 0.22),
      pleatPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.65, size.height * 0.35),
      Offset(size.width * 0.7, size.height * 0.25),
      pleatPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class SparklePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFF59E0B), Color(0xFFEF4444)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    // Main sparkle
    final path = Path();
    final centerX = size.width * 0.5;
    final centerY = size.height * 0.5;
    final radius = size.width * 0.3;

    path.moveTo(centerX, centerY - radius);
    path.lineTo(centerX + radius * 0.3, centerY - radius * 0.3);
    path.lineTo(centerX + radius, centerY);
    path.lineTo(centerX + radius * 0.3, centerY + radius * 0.3);
    path.lineTo(centerX, centerY + radius);
    path.lineTo(centerX - radius * 0.3, centerY + radius * 0.3);
    path.lineTo(centerX - radius, centerY);
    path.lineTo(centerX - radius * 0.3, centerY - radius * 0.3);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class UtensilsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    // Spoon
    final spoonPath = Path();
    spoonPath.addOval(Rect.fromCenter(
      center: Offset(size.width * 0.3, size.height * 0.2),
      width: size.width * 0.15,
      height: size.height * 0.25,
    ));
    canvas.drawPath(spoonPath, paint);

    canvas.drawLine(
      Offset(size.width * 0.3, size.height * 0.32),
      Offset(size.width * 0.3, size.height * 0.8),
      strokePaint,
    );

    // Fork
    canvas.drawLine(
      Offset(size.width * 0.7, size.height * 0.2),
      Offset(size.width * 0.7, size.height * 0.8),
      strokePaint,
    );

    // Fork tines
    canvas.drawLine(
      Offset(size.width * 0.65, size.height * 0.1),
      Offset(size.width * 0.65, size.height * 0.25),
      strokePaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.7, size.height * 0.1),
      Offset(size.width * 0.7, size.height * 0.25),
      strokePaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.75, size.height * 0.1),
      Offset(size.width * 0.75, size.height * 0.25),
      strokePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
