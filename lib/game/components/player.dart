import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart';

/// Represents the player character in the platformer game.
class Player extends SpriteAnimationComponent
    with HasGameRef, Hitbox, Collidable, KeyboardHandler {
  Vector2 velocity = Vector2.zero();
  final double gravity = 500;
  final double jumpSpeed = -300;
  bool onGround = false;
  int lives = 3;
  int score = 0;

  Player({SpriteAnimation? animation, Vector2? position, Vector2? size})
      : super(animation: animation, position: position, size: size) {
    addShape(HitboxRectangle());
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Apply gravity
    velocity.y += gravity * dt;
    position += velocity * dt;

    // Check for ground contact
    if (position.y > gameRef.size.y - size.y) {
      position.y = gameRef.size.y - size.y;
      onGround = true;
      velocity.y = 0;
    } else {
      onGround = false;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    // Handle collision with ground or platforms
    if (other is Platform) {
      onGround = true;
      velocity.y = 0;
    }
    // Handle collision with obstacles or enemies
    if (other is Enemy) {
      lives--;
      if (lives <= 0) {
        // Handle game over or player death
      }
    }
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.contains(LogicalKeyboardKey.space) && onGround) {
      // Jump if on the ground and spacebar is pressed
      velocity.y = jumpSpeed;
      onGround = false;
    }
    return super.onKeyEvent(event, keysPressed);
  }

  /// Increases the player's score.
  void addScore(int points) {
    score += points;
  }

  /// Resets the player's state for a new game or after losing a life.
  void reset() {
    position = Vector2(100, gameRef.size.y - size.y);
    velocity = Vector2.zero();
    lives = 3;
    score = 0;
  }
}

/// Placeholder class for Platform, representing ground or platforms the player can land on.
class Platform extends PositionComponent with Collidable {
  Platform({Vector2? position, Vector2? size}) : super(position: position, size: size) {
    addShape(HitboxRectangle());
  }
}

/// Placeholder class for Enemy, representing obstacles or enemies the player can collide with.
class Enemy extends PositionComponent with Collidable {
  Enemy({Vector2? position, Vector2? size}) : super(position: position, size: size) {
    addShape(HitboxRectangle());
  }
}