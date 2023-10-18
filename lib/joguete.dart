import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:projeto_joguete/character.dart';
import 'package:projeto_joguete/props/Bananas.dart';
import 'package:projeto_joguete/props/orange.dart';
import 'package:projeto_joguete/props/spike_trap.dart';
import 'package:flame_audio/flame_audio.dart';
//import 'package:projeto_joguete/props/start.dart';

class Joguete extends FlameGame with HasCollisionDetection {
  Joguete() {
    size:
    Vector2(720, 1080);
  }

  late SpikeTrap _spike;
  late Character _person;
  //late Start _start;
  late Orange _orange;
  late Bananas _bananas;

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
    await FlameAudio.bgm.play('bg.mp3');
    add(parallaxComp);

    text_c = TextComponent(
        text: 'Score: ${score.floor().toString()}',
        textRenderer: scoreStyle,
        anchor: Anchor.topLeft,
        position: Vector2.all(20.0));

    /*
    //TODO: dar um jeito desse componente aparecer uma vez só, de maneira física quando o jogo inicia
    _start = Start();
    add(_start);
    */

    _spike = SpikeTrap();
    add(_spike);

    _bananas = Bananas();
    _orange = Orange();
    add(_orange);
    //_orange.orangeExists = true;

    _person = Character();
    add(_person);

    add(text_c);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (_person.gameOver == true) {
      text_c.text = 'Game Over\nScore total: ${score.floor().toString()}';
      _spike.vx = _spike.angVelocity = 0;
      _orange.vx = 0;
    } else {
      text_c.text = 'Score: ${score.floor().toString()}';
      score += vel_score * dt;
      //A lógica tá errada de alguma forma
      if (!_orange.exists) {
        _orange.removeFromParent();
        _bananas.exists = true;
        add(_bananas);
      } else if (!_bananas.exists) {
        _bananas.removeFromParent();
        _orange.exists = true;
        add(_orange);
      }
    }
  }
}
