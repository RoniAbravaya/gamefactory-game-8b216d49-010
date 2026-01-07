import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'components/player.dart';
import 'components/spawner.dart';
import 'game_controller.dart';
import 'input_handler.dart';
import '../services/analytics_service.dart';
import '../config/levels.dart';

enum GameState { playing, paused, gameOver, levelComplete }

class test6-platformer-10Game extends FlameGame
    with HasCollisionDetection, TapCallbacks, DragCallbacks {
  
  late Player player;
  late Spawner spawner;
  late GameController controller;
  late InputHandler inputHandler;
  late AnalyticsService analytics;
  
  GameState state = GameState.playing;
  int currentLevel = 1;
  int score = 0;
  int lives = 3;
  LevelConfig? levelConfig;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    analytics = AnalyticsService();
    await analytics.initialize();
    
    controller = GameController(this);
    inputHandler = InputHandler(this);
    
    camera.viewfinder.anchor = Anchor.topLeft;
    
    await loadLevel(currentLevel);
    analytics.logGameStart();
  }

  Future<void> loadLevel(int level) async {
    currentLevel = level;
    levelConfig = LevelConfigs.getLevel(level);
    
    removeAll(children.whereType<PositionComponent>());
    
    player = Player(position: Vector2(size.x / 2, size.y - 100));
    add(player);
    
    spawner = Spawner(
      spawnRate: levelConfig?.obstacleSpeed ?? 1.0,
      gameSize: size,
    );
    add(spawner);
    
    score = 0;
    state = GameState.playing;
    
    analytics.logLevelStart(level);
    overlays.add('GameOverlay');
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (state != GameState.playing) return;
    controller.update(dt);
  }

  @override
  void onTapDown(TapDownEvent event) {
    inputHandler.onTapDown(event.localPosition);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    inputHandler.onDrag(event.localDelta);
  }

  void addScore(int points) {
    score += points;
    if (levelConfig != null && score >= levelConfig!.targetScore) {
      onLevelComplete();
    }
  }

  void loseLife() {
    lives--;
    if (lives <= 0) {
      onGameOver();
    }
  }

  void onLevelComplete() {
    state = GameState.levelComplete;
    analytics.logLevelComplete(currentLevel, score, 0);
    overlays.add('LevelCompleteOverlay');
    overlays.remove('GameOverlay');
  }

  void onGameOver() {
    state = GameState.gameOver;
    analytics.logLevelFail(currentLevel, score, 'no_lives', 0);
    overlays.add('GameOverOverlay');
    overlays.remove('GameOverlay');
  }

  void restartLevel() {
    lives = 3;
    loadLevel(currentLevel);
    overlays.remove('GameOverOverlay');
    overlays.remove('LevelCompleteOverlay');
  }

  void nextLevel() {
    if (currentLevel < 10) {
      loadLevel(currentLevel + 1);
      overlays.remove('LevelCompleteOverlay');
    }
  }

  void pauseGame() {
    state = GameState.paused;
    pauseEngine();
    overlays.add('PauseOverlay');
  }

  void resumeGame() {
    state = GameState.playing;
    resumeEngine();
    overlays.remove('PauseOverlay');
  }
}
