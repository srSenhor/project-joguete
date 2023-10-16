import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:projeto_joguete/joguete.dart';

class Start extends SpriteAnimationComponent with HasGameRef<Joguete> {
  late SpriteSheet idleSpriteSheet;
  late SpriteAnimation idleAnimation;

  @override
  FutureOr<void> onLoad() async {
    //TODO: Achar uma posição melhor, talvez mexendo no anchor
    position = Vector2(gameRef.size.x / 2, gameRef.size.y - 100);
    size = Vector2(64.0, 64.0);
    anchor = Anchor.center;
    scale = Vector2(2, 2);

    idleSpriteSheet = SpriteSheet(
        image: await gameRef.images.load('Props/start (Moving).png'),
        srcSize: Vector2.all(64.0));

    idleAnimation =
        idleSpriteSheet.createAnimation(row: 0, stepTime: 0.2, to: 8);

    animation = idleAnimation;
    return super.onLoad();
  }
}
