import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:projeto_joguete/character.dart';
import 'package:projeto_joguete/joguete.dart';

class Orange extends SpriteAnimationComponent
    with HasGameRef<Joguete>, HasCollisionDetection, CollisionCallbacks {
  double vx = -100.0;
  double vy = 0.0;

  late final staticHeightFruit;

  late SpriteSheet idleSpriteSheet;
  late SpriteAnimation idleAnimation;

  @override
  FutureOr<void> onLoad() async {
    //TODO: dar um jeito melhor de fazer spawnar próximo ao chão
    //staticHeightFruit = size.y;
    staticHeightFruit = 600;
    position = Vector2(gameRef.size.x / 2, gameRef.size.y - staticHeightFruit);
    size = Vector2(32.0, 32.0);
    anchor = Anchor.bottomCenter;
    scale = Vector2(2, 2);

    idleSpriteSheet = SpriteSheet(
        image: await gameRef.images.load('Props/orange.png'),
        srcSize: Vector2.all(32.0));

    idleAnimation =
        idleSpriteSheet.createAnimation(row: 0, stepTime: 0.2, to: 8);

    animation = idleAnimation;

    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    super.onCollision(points, other);

    if (other is Person) {
      gameRef.score += 10;
      removeFromParent();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.x += vx * dt;
    position.y = staticHeightFruit + 15 * cos(position.x / 40);

    if (position.x < 0) {
      position.x = gameRef.size.x;
    }
  }
}
