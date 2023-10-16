import 'dart:async';

import 'package:flame/components.dart';
import 'package:projeto_joguete/joguete.dart';

class Background extends SpriteComponent with HasGameRef<Joguete> {
  @override
  onLoad() async {
    // TODO: implement onLoad
    super.onLoad();

    sprite = await gameRef.loadSprite('bg.png');
    size = gameRef.size;
  }
}
