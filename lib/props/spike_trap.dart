import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:projeto_joguete/joguete.dart';

class SpikeTrap extends SpriteComponent
    with HasGameRef<Joguete>, CollisionCallbacks {
  SpikeTrap() {
    debugMode = true;
  }
  late double angVelocity;
  late double vx;

  @override
  FutureOr<void> onLoad() async {
    vx = 200;
    sprite = await gameRef.loadSprite('Traps/spikes.png');
    anchor = Anchor.bottomRight;
    position = Vector2(gameRef.size.x / 2, gameRef.size.y - size.y - 32);
    size = Vector2.all(16.0);
    scale = Vector2(3, 3);

    add(RectangleHitbox(
        collisionType: CollisionType.active,
        size: Vector2.all(16.0),
        isSolid: true));

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

    position.y = gameRef.size.y - size.y - 32;
  }
}
