import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:projeto_joguete/joguete.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();
  runApp(GameWidget(
    game: Joguete(),
    loadingBuilder: (context) {
      return const Text('Loading...');
    },
  ));
}
