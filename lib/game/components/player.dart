import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import 'obstacle.dart';
import 'collectible.dart';
import '../game.dart';

class Player extends PositionComponent
    with HasGameRef<dynamic>, CollisionCallbacks {
  
  double speed = 200;
  Vector2 velocity = Vector2.zero();
  bool isInvulnerable = false;
  
  Player({required Vector2 position})
      : super(
          position: position,
          size: Vector2(50, 50),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    position += velocity * speed * dt;
    position.x = position.x.clamp(25, gameRef.size.x - 25);
    position.y = position.y.clamp(25, gameRef.size.y - 25);
    
    velocity *= 0.9;
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()
      ..color = isInvulnerable ? Colors.grey : Colors.blue;
    canvas.drawRect(size.toRect(), paint);
  }

  void moveLeft() => velocity.x = -1;
  void moveRight() => velocity.x = 1;
  void moveUp() => velocity.y = -1;
  void moveDown() => velocity.y = 1;

  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    super.onCollision(points, other);
    
    if (other is Obstacle && !isInvulnerable) {
      takeDamage();
    } else if (other is Collectible) {
      other.collect();
      gameRef.addScore(other.value);
    }
  }

  void takeDamage() {
    if (isInvulnerable) return;
    
    gameRef.loseLife();
    isInvulnerable = true;
    
    Future.delayed(const Duration(seconds: 2), () {
      isInvulnerable = false;
    });
  }
}
