import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:projeto_joguete/character.dart';

class Joguete extends FlameGame with TapCallbacks {
  late Character character;

  @override
  Future<void> onLoad() async {
    character = Character();
    add(character);
  }
}
