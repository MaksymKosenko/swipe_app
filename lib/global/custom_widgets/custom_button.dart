import 'package:flutter/material.dart';

  Widget CustomButton(
      double _width,
      double _height,
      double _borderRadiusCircular,
      Color _color1,
      Color _color2,
      Alignment _beginGradient,
      Alignment _endGradient,
      String _text,
      TextStyle _style,
      Color _borderColor,
      ) {
    return Container(
      height: _height,
      width: _width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_borderRadiusCircular),
        border: Border.all(color: _borderColor),
        gradient: LinearGradient(
          begin: _beginGradient,
          end: _endGradient,
          colors: [_color1, _color2],//[Color(0xff56C385), Color(0xff41BFB5)],
        ),
      ),
      child: Text("$_text", style: _style),
    );
  }
