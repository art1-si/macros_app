import 'package:flutter/material.dart';

class LineProgress extends StatefulWidget {
  final int calories;
  final double snapshotData;
  const LineProgress({Key key, this.calories, this.snapshotData})
      : super(key: key);
  @override
  _LineProgressState createState() => _LineProgressState();
}

class _LineProgressState extends State<LineProgress>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    print(widget.snapshotData);
    Tween<double> _progessTween = Tween(begin: 0.0, end: widget.snapshotData);
    _animation = _progessTween.animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastLinearToSlowEaseIn))
      ..addListener(() {
        setState(() {});
      });

    _animationController.forward();
  }

  @override
  void didUpdateWidget(LineProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.snapshotData != widget.snapshotData) {
      print(widget.snapshotData);
      Tween<double> _progessTween = Tween(begin: 0.0, end: widget.snapshotData);
      _animation = _progessTween.animate(CurvedAnimation(
          parent: _animationController, curve: Curves.fastLinearToSlowEaseIn))
        ..addListener(() {
          setState(() {});
        });

      _animationController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animation,
        builder: (context, snapshot) {
          print("animation ${_animation.value}");
          return CustomPaint(
            painter: ProgressLinePainter(
              progressColor: (widget.snapshotData >= 1)
                  ? Theme.of(context).errorColor
                  : Theme.of(context).accentColor,
              progressBackgroundColor: Theme.of(context).primaryColorDark,
              progress: (widget.snapshotData >= 1) ? 1 : _animation.value,
            ),
          );
        });
  }
}

class ProgressLinePainter extends CustomPainter {
  final double progress;
  final Color progressColor;
  final Color progressBackgroundColor;
  ProgressLinePainter(
      {Key key,
      this.progress,
      this.progressColor,
      this.progressBackgroundColor});
  @override
  void paint(Canvas canvas, Size size) {
    final progressLine = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5;
    final progressDot = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 12;
    final progressLineBackground = Paint()
      ..color = progressBackgroundColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5;

    canvas.drawLine(
        Offset(0, 0), Offset(size.width, 0), progressLineBackground);
    canvas.drawLine(
        Offset(0, 0), Offset(size.width * progress, 0), progressLine);
    canvas.drawLine(Offset(size.width * progress, 0),
        Offset(size.width * progress, 0), progressDot);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
