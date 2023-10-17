import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/sprite.dart';
import 'joguete.dart';

class Character extends SpriteAnimationComponent
    with
        TapCallbacks,
        HasGameRef<Joguete>,
        HasCollisionDetection,
        CollisionCallbacks {
  double vx = 0;
  double vy = 0;
  double ax = 0;
  double ay = 300;
  bool gameOver = false;
  late SpriteSheet idleSpriteSheet, hitSpriteSheet;
  late SpriteAnimation idleAnimation, hitAnimation;

  @override
  void onLoad() async {
    position = gameRef.size / 2;
    size = Vector2(64.0, 64.0);
    anchor = Anchor.center;
    idleSpriteSheet = SpriteSheet(
      image: await gameRef.images.load('Idle.png'),
      srcSize: Vector2.all(32.0),
    );
    hitSpriteSheet = SpriteSheet(
      image: await gameRef.images.load('Hit'),
      srcSize: Vector2.all(32.0),
    );
    idleAnimation = idleSpriteSheet.createAnimation(
        row: 0, stepTime: 0.2, from: 0, to: 6, loop: true);
    hitAnimation = hitSpriteSheet.createAnimation(
        row: 0, stepTime: 0.2, from: 0, to: 10, loop: true);
    animation = idleAnimation;
    super.onLoad();
  }

  @override
  void onTapUp(TapUpEvent event) async {
    scale = Vector2(1, -2);
    animation = hitAnimation;
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    scale = Vector2(1.5, 1.5);
  }

  void jump() {
    vy = -200;
  }

  @override
  void update(double dt) {
    super.update(dt);
    vy += ay * dt;
    if (position.y - 40 >= gameRef.size.y) {
      ay = 0;
      vy = 0;
      gameOver = true;
      removeFromParent();
    }
    position.x += vx * dt;
    position.y += vy * dt;
  }
}
