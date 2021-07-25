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

  void _updateLocation(PointerEvent details) {
    setState(() {
      details = details.transformed(details.transform);
      x = details.position.dx;
      y = details.position.dy - 55;
      pathes[pathes.length - 1].path.lineTo(x, y);
    });
  }

  void changeColorGreen() {
    setState(() {
      pathes.add(ColorPath(color: Colors.green, path: Path()));
    });
  }

  void changeColorRed() {
    setState(() {
      pathes.add(ColorPath(color: Colors.red, path: Path()));
    });
  }

  void changeColorBlue() {
    setState(() {
      pathes.add(ColorPath(color: Colors.blue, path: Path()));
    });
  }

  void changeColorYellow() {
    setState(() {
      pathes.add(ColorPath(color: Colors.yellow, path: Path()));
    });
  }

  void changeColorOrange() {
    setState(() {
      pathes.add(ColorPath(color: Colors.orange, path: Path()));
    });
  }

  var pathes = <ColorPath>[ColorPath(color: Colors.black, path: Path())];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: MouseRegion(
              onHover: _updateLocation,
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
            top: 550,
            left: 1000,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
                primary: Colors.white,
                backgroundColor: Colors.black,
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: width,
              child: const Text('ширина линии 20'),
            ),
          ),
        ],
      ),
    );
  }
}

class ColorPath {
  Path path;
  Color color;
  ColorPath({required this.color, required this.path});
}

class Width {
  Width width;
  Width({required this.width});
}

class MyPainter extends CustomPainter {
  final int iteration;
  List<ColorPath> path;
  MyPainter({required this.iteration, required this.path});

  List a = [10];

  void width() {
    a.add(20);
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (var i = 0; i < path.length; i++) {
      Paint paint = Paint()
        ..color = path[i].color
        ..style = PaintingStyle.stroke
        ..strokeWidth = a[i];
      canvas.drawPath(path[i].path, paint);
    }
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) {
    //return oldDelegate.iteration != this.iteration;
    return true;
  }
}
