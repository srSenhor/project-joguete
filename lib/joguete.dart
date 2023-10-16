import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:projeto_joguete/props/orange.dart';
import 'package:projeto_joguete/props/start.dart';

class Joguete extends FlameGame {
  /*
  late Spike _spike;
  */
  late Start _start;
  late Orange _orange;

  final scoreStyle = TextPaint(
      style: const TextStyle(
          fontSize: 32.0,
          color: Color.fromARGB(255, 253, 251, 239),
          shadows: <Shadow>[
        Shadow(
          offset: Offset(2, 2),
          blurRadius: 2.5,
          color: Colors.black,
        )
      ]));

  double score = 0;
  int vel_score = 1;

  late TextComponent text_c;

  @override
  FutureOr<void> onLoad() async {
    final imgs = [
      loadParallaxImage('Level/bg.png', repeat: ImageRepeat.repeat),
      loadParallaxImage('Level/terrain.png',
          repeat: ImageRepeat.repeatX, fill: LayerFill.none)
    ];

    final layers = imgs.map((img) async => ParallaxLayer(await img,
        velocityMultiplier: Vector2((imgs.indexOf(img) + 1) * 2.0, 0)));

    final parallaxComp = ParallaxComponent(
        parallax: Parallax(
      await Future.wait(layers),
      baseVelocity: Vector2(50.0, 0),
    ));

    add(parallaxComp);

    text_c = TextComponent(
        text: 'Score: ${score.floor().toString()}',
        textRenderer: scoreStyle,
        anchor: Anchor.topLeft,
        position: Vector2.all(20.0));

    add(text_c);

    //TODO: dar um jeito desse componente aparecer uma vez só, de maneira física quando o jogo inicia
    _start = Start();
    add(_start);

    _orange = Orange();
    add(_orange);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    text_c.text = 'Score: ${score.floor().toString()}';
    score += vel_score * dt;
  }
}
