import 'package:tflite/tflite.dart';

class Recognizer{
  Future loadModel() {
    Tflite.close();

    return Tflite.loadModel(
      model: "assets/mnist.tflite",
      labels: "assets/mnist.txt",
    );
  }

  dispose() {
    Tflite.close();
  }

}