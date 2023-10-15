import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:projeto_joguete/joguete.dart';

void main() {
  Joguete game = Joguete();
  runApp(GameWidget(game: game));
}
