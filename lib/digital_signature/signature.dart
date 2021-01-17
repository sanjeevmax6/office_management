import 'dart:typed_data';

import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'uiuitils.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  GlobalKey painterKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: RepaintBoundary(
          key: painterKey,
          child: Container(
              width: UIUtills().getProportionalWidth(width: 250),
              height: UIUtills().getProportionalHeight(height: 175),
              child: drawer(width : UIUtills().getProportionalWidth(width: 250),height : UIUtills().getProportionalHeight(height: 175))),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          RenderRepaintBoundary boundary = painterKey
              .currentContext
              .findRenderObject();
          ui.Image image = await boundary.toImage();
          ByteData byteData = await image.toByteData(
              format: ui.ImageByteFormat.png);
          final buffer = byteData.buffer;
        },
        child: Icon(
            Icons.save
        ),
      ),
    );
  }


}

class drawer extends StatefulWidget{

  double width,height;

  drawer({this.width,this.height});

  @override
  _drawerState createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  ValueNotifier<Path> notifier;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifier = new ValueNotifier(new Path());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) => onPanStart(details, context),
      onPanUpdate: (details) => onPanUpdate(details, context),
      onPanEnd: (details) => onPanEnd(details, context),
      child: CustomPaint(
        painter: Signer(notifier: notifier,),
      ),
    );
  }

  void onPanStart(DragStartDetails details, BuildContext context) {
    Offset localTouchPosition = (context.findRenderObject() as RenderBox)
        .globalToLocal(details.globalPosition);
    setState(() {
      notifier.value.moveTo(localTouchPosition.dx, localTouchPosition.dy);
      notifier.value.lineTo(localTouchPosition.dx, localTouchPosition.dy+2);
    });
  }

  void onPanUpdate(DragUpdateDetails details, BuildContext context) {
    Offset localTouchPosition = (context.findRenderObject() as RenderBox)
        .globalToLocal(details.globalPosition);
    if(localTouchPosition.dx>0 && localTouchPosition.dx<widget.width &&
        localTouchPosition.dy>0 && localTouchPosition.dy<widget.height) {
      setState(() {
        notifier.value.lineTo(localTouchPosition.dx, localTouchPosition.dy);
      });
    }
    else{
      setState(() {
        notifier.value.moveTo(localTouchPosition.dx, localTouchPosition.dy);
      });
    }
  }

  void onPanEnd(DragEndDetails details, BuildContext context) {}
}


class Signer extends CustomPainter {
  Paint paint1,paint2;

  ValueNotifier<Path> notifier;

  Signer({this.notifier}) : super(repaint: notifier) {
    paint1 = new Paint()
      ..color = Colors.indigo
      ..style = PaintingStyle.stroke
      ..strokeWidth = UIUtills().getProportionalWidth(width: 5);
    paint2 = new Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = UIUtills().getProportionalWidth(width: 8);
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(new Rect.fromPoints(Offset(0,0), Offset(size.width,size.height)), paint2);
    canvas.drawPath(notifier.value, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
