import 'dart:convert';
import 'package:lottie_flutter/src/keyframes.dart';
import 'package:lottie_flutter/src/parsers/parsers.dart';
import 'package:lottie_flutter/src/values.dart';
import 'package:flutter/animation.dart' show Curves, Cubic;
import 'package:flutter/painting.dart' show Color, Offset;
import 'package:test/test.dart';

void main() {


  ///
  /// Integer keyframe
  ///

  test('keyframe of integer with h test', () {
    Map map = JSON.decode('{"t":16, "h":1, "s":[352,280,0],"e":[400,299,0]}');
    _expect(map, Parsers.intParser, 352, 352, equals(Curves.linear));
  });

  test('keyframe of integer test', () {
    Map map = JSON.decode('{"t":16, "s":[352,280,0],"e":[400,299,0]}');
    _expect(map, Parsers.intParser, 352, 400, equals(Curves.linear));
  });

  test('keyframe of integer with curve test', () {
    Map map = JSON.decode('{"t":16, "s":[352,280,0], "e":[400,299,0],'
        '"o":{"x":[0.333,0.333,0.333],"y":[0.333,0,0.333]},'
        '"i":{"x":[0.667,0.667,0.667],"y":[0.667,1,0.667]}}');
    _expect(map, Parsers.intParser, 352, 400, new isInstanceOf<Cubic>());
  });


  ///
  /// Double keyframe
  ///

  test('keyframe of double with h test', () {
    Map map = JSON.decode(
        '{"t":16, "h":1, "s":[352.5,280,0],"e":[400.3,299,0]}');
    _expect(map, Parsers.doubleParser, 352.5, 352.5, equals(Curves.linear));
  });

  test('keyframe of double test', () {
    Map map = JSON.decode('{"t":16, "s":[352.3,280,0],"e":[400.5,299,0]}');
    _expect(map, Parsers.doubleParser, 352.3, 400.5, equals(Curves.linear));
  });

  test('keyframe of double with curve test', () {
    Map map = JSON.decode('{"t":16, "s":[352.3,280,0], "e":[400,299,0],'
        '"o":{"x":[0.333,0.333,0.333],"y":[0.333,0,0.333]},'
        '"i":{"x":[0.667,0.667,0.667],"y":[0.667,1,0.667]}}');
    _expect(map, Parsers.doubleParser, 352.3, 400.0, new isInstanceOf<Cubic>());
  });


  ///
  /// Point keyframe
  ///

  test('keyframe of point as list with h test', () {
    Map map = JSON.decode(
        '{"t":16, "h":1, "s":[352.5,280,0],"e":[400.3,299,0]}');
    _expectPointKeyframe(map, 352.5, 280.0);
  });

  test('keyframe of point as map with h test', () {
    Map map = JSON.decode(
        '{"t":16, "h":1, "s":{"x":352.5,"y":280},"e":{"x":400.3,"y":299}}');
    _expectPointKeyframe(map, 352.5, 280.0);
  });

  test('keyframe of point as list test', () {
    Map map = JSON.decode('{"t":16, "s":[352.5,280,0],"e":[400.3,299,0]}');
    _expectPointKeyframe(map, 352.5, 280.0, x2: 400.3, y2: 299.0);
  });

  test('keyframe of point as map test', () {
    Map map = JSON.decode(
        '{"t":16, "s":{"x":352.5,"y":280},"e":{"x":400.3,"y":299}}');
    _expectPointKeyframe(map, 352.5, 280.0, x2: 400.3, y2: 299.0);
  });

  test('keyframe of point as list with curve test', () {
    Map map = JSON.decode('{"t":16, "s":[352.3,280,0], "e":[400,299,0],'
        '"o":{"x":[0.333,0.333,0.333],"y":[0.333,0,0.333]},'
        '"i":{"x":[0.667,0.667,0.667],"y":[0.667,1,0.667]}}');
    _expectPointKeyframe(map, 352.3, 280.0, x2: 400.0, y2: 299.0,
        curveMatcher: new isInstanceOf<Cubic>());
  });

  test('keyframe of point as map with curve test', () {
    Map map = JSON.decode('{"t":16, "s":[352.3,280,0], "e":[400,299,0],'
        '"o":{"x":[0.333,0.333,0.333],"y":[0.333,0,0.333]},'
        '"i":{"x":[0.667,0.667,0.667],"y":[0.667,1,0.667]}}');
    _expectPointKeyframe(map, 352.3, 280.0, x2: 400.0, y2: 299.0,
        curveMatcher: new isInstanceOf<Cubic>());
  });

  ///
  /// Scale keyframe
  ///

  test('Scale keyframe with h test', () {
    Map map = JSON.decode(
        '{"t":16, "h":1, "s":[352.5,280,0],"e":[400.3,299,0]}');
    _expectPointKeyframe(map, 3.525, 2.8, parser: Parsers.scaleParser);
  });

  test('Scale keyframe test', () {
    Map map = JSON.decode('{"t":16, "s":[352.31,280,0],"e":[400.5,299,0]}');
    _expectPointKeyframe(
        map, 3.5231, 2.8, x2: 4.005, y2: 2.99, parser: Parsers.scaleParser);
  });

  test('Scale keyframe with curve test', () {
    Map map = JSON.decode('{"t":16, "s":[352.3,280,0], "e":[400,299,0],'
        '"o":{"x":[0.333,0.333,0.333],"y":[0.333,0,0.333]},'
        '"i":{"x":[0.667,0.667,0.667],"y":[0.667,1,0.667]}}');
    _expectPointKeyframe(map, 3.523, 2.8, x2: 4.0, y2: 2.99,
        curveMatcher: new isInstanceOf<Cubic>(), parser: Parsers.scaleParser);
  });


  ///
  /// Color keyframe
  ///

  test('Color keyframe with h test', () {
    Map map = JSON.decode(
        '{"t":16, "h":1, "s":[0.12,0.67,0.54,1.0],"e":[213,20,110,1] }');
    var expected = const Color.fromARGB(255, 30, 170, 137);
    _expect(
        map, Parsers.colorParser, expected, expected, equals(Curves.linear));
  });

  test('Color keyframe test', () {
    Map map = JSON.decode(
        '{"t":16, "s":[0.12,0.67,0.54,1.0],"e":[213,20,110,1] }');
    var startValueExpected = const Color.fromARGB(255, 30, 170, 137);
    var endValueExpected = const Color.fromARGB(1, 213, 20, 110);
    _expect(map, Parsers.colorParser, startValueExpected, endValueExpected,
        equals(Curves.linear));
  });

  test('Color keyframe with curve test', () {
    Map map = JSON.decode('{"t":16,"s":[0.12,0.67,0.54,1.0],"e":[213,20,110,1],'
        '"o":{"x":[0.333,0.333,0.333],"y":[0.333,0,0.333]},'
        '"i":{"x":[0.667,0.667,0.667],"y":[0.667,1,0.667]}}');
    var startValueExpected = const Color.fromARGB(255, 30, 170, 137);
    var endValueExpected = const Color.fromARGB(1, 213, 20, 110);
    _expect(map, Parsers.colorParser, startValueExpected, endValueExpected,
        new isInstanceOf<Cubic>());
  });


  ///
  /// GradientColor keyframe
  ///

  test('GradientColor keyframe with h test', () {
    Map map = JSON.decode(
        '{"t":16, "h":1, "s":[0,0.67,0.54,1,0.12,0.67,0,1.0],'
            '"e":[0.12,0.67,0.54,1] }');
    var colors = [
      const Color.fromARGB(255, 170, 137, 255),
      const Color.fromARGB(255, 170, 0, 255)
    ];
    var expected = new GradientColor(const [0.0, 0.12], colors);
    _expect(
        map, new GradientColorParser(2), expected, expected,
        equals(Curves.linear));
  });

  test('GradientColor keyframe test', () {
    Map map = JSON.decode(
        '{"t":16, "s":[0,0.67,0.54,1,0.12,0.67,0,1.0],'
            '"e":[2,0,0,1,1,1,1,1] }');
    _expectGradientKeyframe(map, equals(Curves.linear));
  });

  test('GradientColor keyframe test', () {
    Map map = JSON.decode(
        '{"t":16, "s":[0,0.67,0.54,1,0.12,0.67,0,1.0],'
            '"e":[2,0,0,1,1,1,1,1],'
            '"o":{"x":[0.333,0.333,0.333],"y":[0.333,0,0.333]},'
            '"i":{"x":[0.667,0.667,0.667],"y":[0.667,1,0.667]}}');
    _expectGradientKeyframe(map, new isInstanceOf<Cubic>());
  });


  ///
  /// ShapeData keyframe
  ///

  test('ShapeData keyframe with h test', () {
    Map map = JSON.decode(
        '{"t":16, "h":1,'
            '"s":{"i":[[10.0,-10.0],[5.5,1.0]],"o":[[-5.0,-10.0],[-10,-1.0]],'
            '"v":[[0,-10],[-30,-40]],"c":false},'
            '"e":{"i":[[10.0,-10.0],[5.5,1.0]],"o":[[-5.0,-10.0],[-10,-1.0]],'
            '"v":[[0,-10],[-30,-40]],"c":false}}');
    var cubicData = const [
      const CubicCurveData(
          const Offset(-5.0, -20.0), const Offset(-24.5, -39.0),
          const Offset(-30.0, -40.0))
    ];
    var expected = new ShapeData(cubicData, const Offset(0.0, -10.0), false);
    _expect(
        map, Parsers.shapeDataParser, expected, expected,
        equals(Curves.linear));
  });

  test('ShapeData keyframe with h and closed curve test', () {
    Map map = JSON.decode(
        '{"t":16, "h":1,'
            '"s":{"i":[[10.0,-10.0],[5.5,1.0]],"o":[[-5.0,-10.0],[-10,-1.0]],'
            '"v":[[0,-10],[-30,-40]],"c":true},'
            '"e":{"i":[[10.0,-10.0],[5.5,1.0]],"o":[[-5.0,-10.0],[-10,-1.0]],'
            '"v":[[0,-10],[-30,-40]],"c":true}}');
    var cubicData = const [
      const CubicCurveData(
          const Offset(-5.0, -20.0), const Offset(-24.5, -39.0),
          const Offset(-30.0, -40.0)),
      const CubicCurveData(
          const Offset(-40.0, -41.0), const Offset(10.0, -20.0),
          const Offset(0.0, -10.0))
    ];
    var expected = new ShapeData(cubicData, const Offset(0.0, -10.0), true);
    _expect(
        map, Parsers.shapeDataParser, expected, expected,
        equals(Curves.linear));
  });


  test('ShapeData keyframe test', () {
    Map map = JSON.decode(
        '{"t":16, "s":{"i":[[10.0,-10.0],[5.5,1.0]],"o":[[-5.0,-10.0],[-10,-1.0]],'
            '"v":[[0,-10],[-30,-40]],"c":false},'
            '"e":{"i":[[20.0,-20.0],[5.5,1.0]],"o":[[-10.0,-15.0],[-15,-1.0]],'
            '"v":[[0,-11],[-30,-40]],"c":false}}');
    var startCubicData = const [
      const CubicCurveData(
          const Offset(-5.0, -20.0), const Offset(-24.5, -39.0),
          const Offset(-30.0, -40.0))
    ];

    var endCubicData = const [
      const CubicCurveData(
          const Offset(-10.0, -26.0), const Offset(-24.5, -39.0),
          const Offset(-30.0, -40.0))
    ];
    var startValueExpected = new ShapeData(
        startCubicData, const Offset(0.0, -10.0), false);
    var endValueExpected = new ShapeData(
        endCubicData, const Offset(0.0, -11.0), false);
    _expect(
        map, Parsers.shapeDataParser, startValueExpected, endValueExpected,
        equals(Curves.linear));
  });


  test('ShapeData keyframe test', () {
    Map map = JSON.decode(
        '{"t":16, "s":{"i":[[10.0,-10.0],[5.5,1.0]],"o":[[-5.0,-10.0],[-10,-1.0]],'
            '"v":[[0,-10],[-30,-40]],"c":false},'
            '"e":{"i":[[20.0,-20.0],[5.5,1.0]],"o":[[-10.0,-15.0],[-15,-1.0]],'
            '"v":[[0,-11],[-30,-40]],"c":false}}');
    var startCubicData = const [
      const CubicCurveData(
          const Offset(-5.0, -20.0), const Offset(-24.5, -39.0),
          const Offset(-30.0, -40.0))
    ];

    var endCubicData = const [
      const CubicCurveData(
          const Offset(-10.0, -26.0), const Offset(-24.5, -39.0),
          const Offset(-30.0, -40.0))
    ];
    var startValueExpected = new ShapeData(
        startCubicData, const Offset(0.0, -10.0), false);
    var endValueExpected = new ShapeData(
        endCubicData, const Offset(0.0, -11.0), false);
    _expect(
        map, Parsers.shapeDataParser, startValueExpected, endValueExpected,
        equals(Curves.linear));
  });
}


void _expectPointKeyframe<T>(dynamic map, double x1, double y1,
    {double x2, double y2, Matcher curveMatcher, Parser<T> parser}) {
  var startValueExpected = new Offset(x1, y1);
  var endValueExpected = new Offset(x2 ?? x1, y2 ?? y1);
  _expect(
      map, parser ?? Parsers.pointFParser, startValueExpected, endValueExpected,
      curveMatcher ?? equals(Curves.linear));
}

void _expectGradientKeyframe(dynamic map, Matcher curveMatcher) {
  var startColors = [
    const Color.fromARGB(255, 170, 137, 255),
    const Color.fromARGB(255, 170, 0, 255)
  ];

  var endColors = [
    const Color.fromARGB(255, 0, 0, 255),
    const Color.fromARGB(255, 255, 255, 255)
  ];

  var startValueExpected = new GradientColor(const [0.0, 0.12], startColors);
  var endValueExpected = new GradientColor(const [2.0, 1.0], endColors);
  _expect(map, new GradientColorParser(2), startValueExpected, endValueExpected,
      curveMatcher);
}

void _expect<T>(dynamic map, Parser<T> parser, T startValue, T endValue,
    Matcher curveMatcher) {
  var keyframe = new Keyframe<T>.fromMap(map, parser, 1.0, 0.0);
  expect(keyframe.startValue, startValue);
  expect(keyframe.endValue, endValue);
  expect(keyframe.curve, curveMatcher);
}