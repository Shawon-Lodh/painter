import 'package:flutter/material.dart';
import 'package:painter/services/recognizer.dart';
import 'package:painter/utils/constants.dart';
import 'package:painter/screens/drawing_painter.dart';

class DrawScreen extends StatefulWidget {

  @override
  _DrawScreenState createState() => _DrawScreenState();
}

class _DrawScreenState extends State<DrawScreen> {
  final _points = List<Offset>();
  final _recognizer = Recognizer();

  @override
  void initState() {
    _inItModel();
    super.initState();
  }

  void _inItModel() async {
    var res = await _recognizer.loadModel();
    print(res);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Center(child: Text('Digit Recognizer')),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        "Write As Your Wish !!!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      // Text(
                      //   'MNIST database of handwritten digits',
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // Text(
                      //   'The digits have been size-normalized and centered in a fixed-size images (28 x 28)',
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          GestureDetector(
            onPanUpdate: (DragUpdateDetails details){
              Offset _localPosition = details.localPosition;
              setState(() {
                _points.add(_localPosition);
              });
            },
            onPanEnd: (DragEndDetails details){
              _points.add(null);
            },
            child: Container(
              width: Constants.canvasSize,
              height: Constants.canvasSize,
              decoration: BoxDecoration(border: Border.all(color: Colors.black,width: Constants.borderSize)),
              child: CustomPaint(
                painter: DrawingPainter(_points),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.clear),
        onPressed: () {
          setState(() {
            _points.clear();
          });
        },
      ),
    );
  }
}