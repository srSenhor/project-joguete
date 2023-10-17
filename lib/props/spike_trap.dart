import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:projeto_joguete/joguete.dart';

class SpikeTrap extends SpriteComponent
    with HasGameRef<Joguete>, HasCollisionDetection, CollisionCallbacks {
  late double angVelocity;
  late double vx;

  @override
  FutureOr<void> onLoad() async {
    vx = 200;
    sprite = await gameRef.loadSprite('Traps/spikes.png');
    position = Vector2(gameRef.size.x / 2, gameRef.size.y - 42);
    size = Vector2.all(16.0);
    anchor = Anchor.bottomRight;
    scale = Vector2(3, 3);
    return super.onLoad();
  }

  //TODO: dar um jeito dele spawnar em instantes de tempo aleatorios
  @override
  void update(double dt) {
    super.update(dt);

    position.x -= vx * dt;

    if (position.x < 0) {
      position.x = gameRef.size.x + 200;
    }
  }
}
