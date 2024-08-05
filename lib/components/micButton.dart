import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class MicButton extends StatefulWidget {
  @override
  _MicButtonState createState() => _MicButtonState();
}

class _MicButtonState extends State<MicButton> {
  bool _isPushed = false;
  Timer? _timer;
  Duration _elapsed = Duration.zero;

  void _toggleButton() {
    setState(() {
      _isPushed = !_isPushed;
      if (_isPushed) {
        _startTimer();
      } else {
        _stopTimer();
      }
    });
  }

  void _startTimer() {
    _elapsed = Duration.zero;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _elapsed = Duration(seconds: _elapsed.inSeconds + 1);
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          _isPushed ? _elapsed.toString().split('.').first : '00:00:00',
          style: TextStyle(fontSize: 24),
        ),
        SizedBox(height: 20),
        FloatingActionButton(
            onPressed: _toggleButton,
            backgroundColor:
                _isPushed ? const Color.fromARGB(125, 183, 28, 28) : Colors.red,
            shape: const CircleBorder(
                side: BorderSide(
              width: 0,
            )),
            child: const Icon(
              Icons.mic,
              color: Colors.white,
            )),
      ],
    );
  }
}
