import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(const MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: MyStatefulWidget(),
      ),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
/// class MyPainter extends CustomPainter {

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  double x = 0.0;
  double y = 0.0;
  int _downCounter = 0;
  var color = Colors.black;
  double width = 10;
  void updateXY(PointerEvent details) {
    details = details.transformed(details.transform);
    x = details.position.dx;
    y = details.position.dy - 55;
  }

  void _updateLocation(PointerEvent details) {
    updateXY(details);
    setState(() {
      pathes[pathes.length - 1].path.lineTo(x, y);
    });
  }

  void _incrementDown(PointerEvent details) {
    updateXY(details);
    setState(() {
      _downCounter++;
      addToPath();
    });
  }

  void _decrementDown(PointerEvent details) {
    updateXY(details);
    setState(() {
      _downCounter--;
    });
  }

  void changeColorGreen() {
    setState(() {
      color = Colors.green;
      addToPath();
    });
  }

  void changeColorRed() {
    setState(() {
      color = Colors.red;
      addToPath();
    });
  }

  void changeColorBlue() {
    setState(() {
      color = Colors.blue;
      addToPath();
    });
  }

  void changeColorYellow() {
    setState(() {
      color = Colors.yellow;
      addToPath();
    });
  }

  void changeColorOrange() {
    setState(() {
      color = Colors.orange;
      addToPath();
    });
  }

  void changeWidthToA(double a) {
    setState(() {
      width = a;
      addToPath();
    });
  }

  void addToPath() {
    pathes.add(ColorPathWidth(color: color, path: Path(), width: width));
    pathes[pathes.length - 1].path.moveTo(x, y);
  }

  var pathes = <ColorPathWidth>[
    ColorPathWidth(color: Colors.black, path: Path(), width: 10)
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Listener(
              onPointerDown: _incrementDown,
              onPointerUp: _decrementDown,
              onPointerMove: _updateLocation,
              child: Container(
                color: Colors.white,
                child: CustomPaint(
                  painter: MyPainter(
                    path: pathes,
                    iteration: 0,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 1100,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
                primary: Colors.white,
                backgroundColor: Colors.green,
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: changeColorGreen,
              child: const Text(''),
            ),
          ),
          Positioned(
            top: 80,
            left: 1100,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
                primary: Colors.white,
                backgroundColor: Colors.red,
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: changeColorRed,
              child: const Text(''),
            ),
          ),
          Positioned(
            top: 130,
            left: 1100,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
                primary: Colors.white,
                backgroundColor: Colors.blue,
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: changeColorBlue,
              child: const Text(''),
            ),
          ),
          Positioned(
            top: 180,
            left: 1100,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
                primary: Colors.white,
                backgroundColor: Colors.yellow,
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: changeColorYellow,
              child: const Text(''),
            ),
          ),
          Positioned(
            top: 230,
            left: 1100,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
                primary: Colors.white,
                backgroundColor: Colors.orange,
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: changeColorOrange,
              child: const Text(''),
            ),
          ),
          Positioned(
            top: 300,
            left: 900,
            right: 0,
            height: 50,
            child: Slider.adaptive(
              min: 10,
              max: 50,
              value: width,
              onChanged: changeWidthToA,
            ),
          ),
        ],
      ),
    );
  }
}

class ColorPathWidth {
  Path path;
  Color color;
  double width;
  ColorPathWidth(
      {required this.color, required this.path, required this.width});
}

class MyPainter extends CustomPainter {
  final int iteration;
  List<ColorPathWidth> path;
  MyPainter({required this.iteration, required this.path});

  @override
  void paint(Canvas canvas, Size size) {
    for (var i = 0; i < path.length; i++) {
      Paint paint = Paint()
        ..color = path[i].color
        ..style = PaintingStyle.stroke
        ..strokeWidth = path[i].width;
      canvas.drawPath(path[i].path, paint);
    }
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) {
    //return oldDelegate.iteration != this.iteration;
    return true;
  }
}
