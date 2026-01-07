import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame_audio/flame_audio.dart';

/// A component representing a collectible item in a platformer game.
/// It includes collision detection, a score value, optional animation, and a sound effect upon collection.
class Collectible extends SpriteComponent with Hitbox, Collidable {
  /// The score value this collectible adds to the player's score upon collection.
  final int scoreValue;

  /// The path to the sound effect file that should be played when this collectible is collected.
  final String collectionSoundPath;

  /// Creates a new [Collectible] instance.
  ///
  /// [sprite] is the visual representation of the collectible.
  /// [scoreValue] is the value added to the player's score when collected.
  /// [collectionSoundPath] is the path to the sound effect played upon collection.
  /// [size] is the size of the collectible.
  /// [position] is the initial position of the collectible in the game world.
  Collectible({
    required Sprite sprite,
    required this.scoreValue,
    required this.collectionSoundPath,
    Vector2? position,
    Vector2? size,
  }) : super(sprite: sprite, position: position, size: size) {
    addShape(HitboxRectangle());
  }

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    // Optionally, initialize animations or other setup tasks here.
  }

  /// Handles what happens when this collectible is collected.
  void collect() {
    // Play the collection sound effect.
    FlameAudio.play(collectionSoundPath);

    // Perform any additional actions needed upon collection, such as updating the game state.
    
    // Remove this collectible from the game.
    removeFromParent();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    // Check if the colliding entity is the player or a player-like entity.
    // This might require checking the type of `other` or using tags.
    // If so, call `collect()`.
  }
}