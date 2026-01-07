import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';

class GameScene extends Component with HasGameRef, TapDetector {
  late Player player;
  late ScoreDisplay scoreDisplay;
  int currentLevel = 1;
  int score = 0;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    setupLevel(currentLevel);
  }

  /// Sets up the game level by loading the player, obstacles, and collectibles.
  void setupLevel(int levelNumber) {
    // Clear previous level components
    removeAll(children);

    // Setup player
    player = Player()
      ..position = Vector2(100, 100) // Example starting position
      ..size = Vector2(50, 50); // Example size
    add(player);

    // Setup score display
    scoreDisplay = ScoreDisplay()
      ..position = Vector2(20, 20); // Example position for score display
    add(scoreDisplay);

    // Load obstacles and collectibles based on the level number
    // This is a placeholder for actual level setup logic
    // Example: add(Obstacle(...));
    // Example: add(Collectible(...));

    // Update score display
    scoreDisplay.score = score;
  }

  @override
  void update(double dt) {
    super.update(dt);
    checkWinLoseConditions();
  }

  /// Checks if the player has met win or lose conditions.
  void checkWinLoseConditions() {
    // Placeholder for win/lose condition checks
    // Example: if (player.position.y > gameRef.size.y) { restartLevel(); }
  }

  /// Restarts the current level.
  void restartLevel() {
    setupLevel(currentLevel);
  }

  /// Increments the score and updates the score display.
  void incrementScore(int value) {
    score += value;
    scoreDisplay.score = score;
  }

  @override
  void onTap() {
    // Player tap jump logic
    player.jump();
  }
}

class Player extends SpriteComponent with Hitbox, Collidable {
  void jump() {
    // Placeholder for jump logic
    // Example: velocity.y = -300; // Example jump velocity
  }
}

class ScoreDisplay extends PositionComponent {
  int _score = 0;

  int get score => _score;

  set score(int value) {
    _score = value;
    // Update display logic here
    // Example: textComponent.text = 'Score: $_score';
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    // Load and setup score display components
    // Example: add(TextComponent(text: 'Score: $_score'));
  }
}