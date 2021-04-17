import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

class CustomGestureRecognizer extends OneSequenceGestureRecognizer {
  double maxScreenOffsetX;
  final double edgeMargin = 20.0;

  CustomGestureRecognizer({@required this.maxScreenOffsetX});

  @override
  void addAllowedPointer(PointerDownEvent event) {
    print("CustomGestureRecognizer: Screen Width: " +
        maxScreenOffsetX.toString());
    print("CustomGestureRecognizer: dx: " + event.position.dx.toString());

    if (event.position.dx < edgeMargin ||
        event.position.dx > (maxScreenOffsetX - edgeMargin)) {
      print("CustomGestureRecognizer: At the Edge.");
      return;
    }
    print("CustomGestureRecognizer: Inside Safe Zone");
    startTrackingPointer(event.pointer, event.transform);
    resolve(GestureDisposition.accepted);
    stopTrackingPointer(event.pointer);
  }

  @override
  // TODO: implement debugDescription
  String get debugDescription => throw UnimplementedError();

  @override
  void didStopTrackingLastPointer(int pointer) {
    // TODO: implement didStopTrackingLastPointer
  }

  @override
  void handleEvent(PointerEvent event) {
    // TODO: implement handleEvent
  }
}