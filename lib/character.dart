import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/sprite.dart';
import 'package:projeto_joguete/props/spike_trap.dart';
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
  double ay = 0;
  bool gameOver = false;
  /*
  late SpriteSheet runSpriteSheet, jumpSpriteSheet, fallSpriteSheet;
  late SpriteAnimation runAnimation, jumpAnimation, fallAnimation;
  */
  late SpriteSheet idleSpriteSheet, hitSpriteSheet;
  late SpriteAnimation idleAnimation, hitAnimation;
  @override
  void onLoad() async {
    position = Vector2(48, gameRef.size.y - size.y - 77);
    size = Vector2.all(64.0);
    anchor = Anchor.center;
    /*
    runSpriteSheet = SpriteSheet(
      image: await gameRef.images.load('Run.png'),
      srcSize: Vector2.all(32.0),
    );
    jumpSpriteSheet = SpriteSheet(
      image: await gameRef.images.load('Jump.png'),
      srcSize: Vector2.all(32.0),
    );
    fallSpriteSheet = SpriteSheet(
      image: await gameRef.images.load('Fall.png'),
      srcSize: Vector2.all(32.0),
    );
    runAnimation = runSpriteSheet.createAnimation(
        row: 0, stepTime: 0.2, from: 0, to: 6, loop: true);
    jumpAnimation = jumpSpriteSheet.createAnimation(
        row: 0, stepTime: 0.2, from: 0, to: 10, loop: true);
    fallAnimation = fallSpriteSheet.createAnimation(
        row: 0, stepTime: 0.2, from: 0, to: 10, loop: true);
    animation = runAnimation;
    */
    idleSpriteSheet = SpriteSheet(
      image: await gameRef.images.load('Idle.png'),
      srcSize: Vector2.all(32.0),
    );
    hitSpriteSheet = SpriteSheet(
      image: await gameRef.images.load('Hit.png'),
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
    jump();
    animation = hitAnimation;
    //animation = jumpAnimation;
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    scale = Vector2(1.5, 1.5);
  }

  void jump() {
    vy = -200;
  }

  /*
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is SpikeTrap) {
      gameOver = true;
      ay = 0;
      vy = 0;
      removeFromParent();
    }
  }
  */
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
