import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/sprite.dart';

/// A component representing an obstacle in a platformer game.
/// It includes collision detection, damage dealing, and visual representation.
class Obstacle extends PositionComponent with HasHitboxes, Collidable {
  final Vector2 _size;
  final String _spritePath;
  final int _damage;
  late SpriteComponent _visualRepresentation;

  /// Creates an instance of an obstacle.
  /// 
  /// [size] specifies the size of the obstacle.
  /// [spritePath] specifies the path to the sprite image. If empty, a shape will be used.
  /// [damage] specifies the damage dealt to the player on collision.
  Obstacle({
    required Vector2 position,
    required Vector2 size,
    String spritePath = '',
    int damage = 1,
  })  : _size = size,
        _spritePath = spritePath,
        _damage = damage,
        super(position: position, size: size) {
    addHitbox(HitboxRectangle());
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    if (_spritePath.isNotEmpty) {
      _visualRepresentation = SpriteComponent(
        sprite: await Sprite.load(_spritePath),
        size: _size,
      );
    } else {
      // Default visual representation if no sprite is provided.
      _visualRepresentation = RectangleComponent(
        size: _size,
        paint: Paint()..color = const Color(0xFFFF6B6B),
      );
    }
    add(_visualRepresentation);
  }

  /// Handles the collision with other [Collidable] components.
  /// 
  /// This method is called when this obstacle collides with another collidable.
  /// It can be used to deal damage to the player or trigger other effects.
  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    // Implement damage dealing or other effects here.
  }
}