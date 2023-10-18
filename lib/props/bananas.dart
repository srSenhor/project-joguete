import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:projeto_joguete/character.dart';
import 'package:projeto_joguete/joguete.dart';

class Bananas extends SpriteAnimationComponent
    with HasGameRef<Joguete>, CollisionCallbacks {
  Bananas() {
    debugColor = Colors.white;
    //debugMode = true;
  }
  double vx = -100.0;
  double vy = 0.0;
  bool exists = false;

  late final staticHeightFruit;

  late SpriteSheet idleSpriteSheet;
  late SpriteAnimation idleAnimation;

  @override
  FutureOr<void> onLoad() async {
    //TODO: dar um jeito melhor de fazer spawnar próximo ao chão
    staticHeightFruit = gameRef.size.y - size.y - 96;

    position = Vector2(gameRef.size.x / 2, staticHeightFruit);
    size = Vector2.all(32.0);
    anchor = Anchor.bottomCenter;
    scale = Vector2(2, 2);

    idleSpriteSheet = SpriteSheet(
        image: await gameRef.images.load('Props/bananas.png'),
        srcSize: Vector2.all(32.0));

    idleAnimation =
        idleSpriteSheet.createAnimation(row: 0, stepTime: 0.13, to: 17);

    animation = idleAnimation;

    add(RectangleHitbox(
        collisionType: CollisionType.passive,
        isSolid: true,
        size: Vector2.all(16.0)));

    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    super.onCollision(points, other);

    if (other is Character) {
      gameRef.text_c.text =
          'Score: ${(gameRef.score.floor() + 10).toString()} + 200';
      gameRef.score += 200;
      removeFromParent();
      exists = false;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.x += vx * dt;
    position.y = staticHeightFruit + 16 * cos(position.x / 40);

    if (position.x < 0) {
      position.x = gameRef.size.x;
    }
  }
}
