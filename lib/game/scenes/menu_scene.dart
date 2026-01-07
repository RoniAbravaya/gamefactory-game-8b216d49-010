import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/palette.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

/// A component for the main menu scene of a platformer game.
class MenuScene extends Component with HasGameRef, TapDetector {
  late TextComponent title;
  late TextComponent playButton;
  late TextComponent levelSelectButton;
  late TextComponent settingsButton;
  late RectComponent background;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    _loadBackground();
    _loadTitle();
    _loadPlayButton();
    _loadLevelSelectButton();
    _loadSettingsButton();
  }

  void _loadBackground() {
    background = RectComponent(
      position: Vector2.zero(),
      size: gameRef.size,
      paint: Paint()..color = Colors.blueGrey,
    );
    add(background);
  }

  void _loadTitle() {
    title = TextComponent(
      text: 'Leap and bound through a colorful world!',
      position: Vector2(gameRef.size.x / 2, gameRef.size.y / 4),
      anchor: Anchor.center,
      textRenderer: TextPaint(style: TextStyle(fontSize: 24.0, color: Colors.white, fontFamily: 'Arial')),
    );
    add(title);
  }

  void _loadPlayButton() {
    playButton = TextComponent(
      text: 'Play',
      position: Vector2(gameRef.size.x / 2, gameRef.size.y / 2),
      anchor: Anchor.center,
      textRenderer: TextPaint(style: TextStyle(fontSize: 20.0, color: Colors.white, fontFamily: 'Arial')),
    );
    playButton.add(RectangleHitbox()..onTapDown = (_) => _onPlayButtonPressed());
    add(playButton);
  }

  void _loadLevelSelectButton() {
    levelSelectButton = TextComponent(
      text: 'Select Level',
      position: Vector2(gameRef.size.x / 2, gameRef.size.y / 2 + 50),
      anchor: Anchor.center,
      textRenderer: TextPaint(style: TextStyle(fontSize: 20.0, color: Colors.white, fontFamily: 'Arial')),
    );
    levelSelectButton.add(RectangleHitbox()..onTapDown = (_) => _onLevelSelectPressed());
    add(levelSelectButton);
  }

  void _loadSettingsButton() {
    settingsButton = TextComponent(
      text: 'Settings',
      position: Vector2(gameRef.size.x / 2, gameRef.size.y / 2 + 100),
      anchor: Anchor.center,
      textRenderer: TextPaint(style: TextStyle(fontSize: 20.0, color: Colors.white, fontFamily: 'Arial')),
    );
    settingsButton.add(RectangleHitbox()..onTapDown = (_) => _onSettingsPressed());
    add(settingsButton);
  }

  void _onPlayButtonPressed() {
    // Implement navigation to the game play scene
    print('Play button pressed');
  }

  void _onLevelSelectPressed() {
    // Implement navigation to the level select scene
    print('Level Select button pressed');
  }

  void _onSettingsPressed() {
    // Implement navigation to the settings scene
    print('Settings button pressed');
  }
}