import 'dart:async';

import 'package:flame/components.dart';
import 'package:projeto_joguete/joguete.dart';

class TerrainBlock extends SpriteComponent
    with HasGameRef<Joguete>, HasCollisionDetection {
  TerrainBlock() {
    _loadSprite();
  }

  @override
  FutureOr<void> onLoad() async {
    size = Vector2.all(46);
    return super.onLoad();
  }

  _loadSprite() async {
    sprite = await gameRef.loadSprite('Level/terrain.png');
  }
}
