// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class CustomHexagon extends StatelessWidget {
  const CustomHexagon(
      {super.key,
      required this.child,
      required this.size,
      required this.backgroundColor});
  final double size;
  final Widget child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final HexagonPathBuilder pathBuilder = HexagonPathBuilder();
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: HexagonPainter(
          pathBuilder,
          color: backgroundColor,
        ),
        child: ClipPath(
          clipper: HexagonClipper(
            pathBuilder,
          ),
          child: Align(
            alignment: Alignment.center,
            child: child,
          ),
        ),
      ),
    );
  }
}

class HexagonPathBuilder {
  final double borderRadius = 10;
  HexagonPathBuilder();

  Path build(Size size) => _hexagonPath(size);

  Point<double> _pointyHexagonCorner(Offset center, double size, int i) {
    var angleDeg = 60 * i - 30;
    var angleRad = pi / 180 * angleDeg;
    return Point(
        center.dx + size * cos(angleRad), center.dy + size * sin(angleRad));
  }

  /// Calculates hexagon corners for given size and center.
  List<Point<double>> _pointyHexagonCornerList(Offset center, double size) =>
      List<Point<double>>.generate(
        6,
        (index) => _pointyHexagonCorner(center, size, index),
        growable: false,
      );

  Point<double> _pointBetween(Point<double> start, Point<double> end,
      {double? distance, double? fraction}) {
    double xLength = end.x - start.x;
    double yLength = end.y - start.y;
    if (fraction == null) {
      if (distance == null) {
        throw Exception('Distance or fraction should be specified.');
      }
      double length = sqrt(xLength * xLength + yLength * yLength);
      fraction = distance / length;
    }
    return Point(start.x + xLength * fraction, start.y + yLength * fraction);
  }

  Point<double> _radiusStart(Point<double> corner, int index,
      List<Point<double>> cornerList, double radius) {
    var prevCorner =
        index > 0 ? cornerList[index - 1] : cornerList[cornerList.length - 1];
    double distance = radius * tan(pi / 6);
    return _pointBetween(corner, prevCorner, distance: distance);
  }

  Point<double> _radiusEnd(Point<double> corner, int index,
      List<Point<double>> cornerList, double radius) {
    var nextCorner =
        index < cornerList.length - 1 ? cornerList[index + 1] : cornerList[0];
    double distance = radius * tan(pi / 6);
    return _pointBetween(corner, nextCorner, distance: distance);
  }

  /// Returns path in shape of hexagon.
  Path _hexagonPath(Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    List<Point<double>> cornerList;
    cornerList = _pointyHexagonCornerList(center, size.height / 1 / 2);

    final path = Path();
    if (borderRadius > 0) {
      Point<double> rStart;
      Point<double> rEnd;
      cornerList.asMap().forEach((index, point) {
        rStart = _radiusStart(point, index, cornerList, borderRadius);
        rEnd = _radiusEnd(point, index, cornerList, borderRadius);
        if (index == 0) {
          path.moveTo(rStart.x, rStart.y);
        } else {
          path.lineTo(rStart.x, rStart.y);
        }
        // rough approximation of an circular arc for 120 deg angle.
        var control1 = _pointBetween(rStart, point, fraction: 0.7698);
        var control2 = _pointBetween(rEnd, point, fraction: 0.7698);
        path.cubicTo(
          control1.x,
          control1.y,
          control2.x,
          control2.y,
          rEnd.x,
          rEnd.y,
        );
      });
    } else {
      cornerList.asMap().forEach((index, point) {
        if (index == 0) {
          path.moveTo(point.x, point.y);
        } else {
          path.lineTo(point.x, point.y);
        }
      });
    }

    return path..close();
  }
}

class HexagonPainter extends CustomPainter {
  HexagonPainter(this.pathBuilder, {required this.color, this.elevation = 0});

  final HexagonPathBuilder pathBuilder;
  final double elevation;
  final Color color;

  final Paint _paint = Paint();
  Path? _path;

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: fix repainting, it is repainting due to multiple linear gradients
    _paint.color = color;
    _paint.isAntiAlias = true;
    _paint.style = PaintingStyle.fill;
    // build hexagon
    Path path = pathBuilder.build(size);
    _path = path;
    canvas.drawPath(path, _paint);

    canvas.clipPath(path);

    var rect = Offset.zero & size;
    _paint.shader = LinearGradient(
      begin: Alignment.topLeft,
      end: const Alignment(0.0, 0.5),
      colors: [Colors.black.withOpacity(0.5), Colors.transparent],
      stops: const [0.0, 0.4],
    ).createShader(rect);

    canvas.drawRect(rect, _paint);

    _paint.shader = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [ui.Color.fromARGB(10, 0, 0, 0), Colors.transparent],
      stops: [0.0, 1],
    ).createShader(rect);

    canvas.drawRect(rect, _paint);

    _paint.shader = LinearGradient(
      begin: Alignment.topRight,
      end: const Alignment(0.0, 0.5),
      colors: [Colors.black.withOpacity(0.5), Colors.transparent],
      stops: const [0.0, 0.4],
    ).createShader(rect);

    canvas.drawRect(rect, _paint);
    _paint.shader = null;
  }

  @override
  bool hitTest(Offset position) {
    return _path?.contains(position) ?? false;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }

  @override
  bool operator ==(covariant HexagonPainter other) {
    if (identical(this, other)) return true;

    return other.pathBuilder == pathBuilder &&
        other.elevation == elevation &&
        other.color == color;
  }

  @override
  int get hashCode =>
      pathBuilder.hashCode ^ elevation.hashCode ^ color.hashCode;
}

class HexagonClipper extends CustomClipper<Path> {
  HexagonClipper(this.pathBuilder);

  final HexagonPathBuilder pathBuilder;

  @override
  Path getClip(Size size) {
    return pathBuilder.build(size);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    if (oldClipper is HexagonClipper) {
      return oldClipper.pathBuilder != pathBuilder;
    }
    return true;
  }
}
