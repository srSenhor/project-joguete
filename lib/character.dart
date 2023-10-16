import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import './joguete.dart';

class Person extends SpriteAnimationComponent
    with
        TapCallbacks,
        HasGameRef<Joguete>,
        HasCollisionDetection,
        CollisionCallbacks {}
