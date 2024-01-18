import 'package:flutter/material.dart';

class Typewriter extends StatefulWidget {
  final String text;
  final Duration duration;

  Typewriter({required this.text, required this.duration});

  @override
  _TypewriterState createState() => _TypewriterState();
}

class _TypewriterState extends State<Typewriter> {
  int _charPosition = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.duration, _addChar);
  }

  void _addChar() {
    setState(() {
      _charPosition++;
    });
    if (_charPosition < widget.text.length) {
      Future.delayed(widget.duration, _addChar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text.substring(0, _charPosition),
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
    );
  }
}