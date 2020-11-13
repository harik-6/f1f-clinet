import 'package:flutter/material.dart';

class TeamConstants {
  static final Map<String, Color> teamColorsMap = {
    "mercedes": Colors.green[300],
    "redbull": Colors.blue[900],
    "red_bull": Colors.blue[900],
    "ferrari": Colors.red,
    "williams": Colors.white,
    "mclaren": Colors.orange[700],
    "aston": Colors.green[900],
    "racing_point": Colors.pink,
    "alphatauri": Colors.blueAccent,
    "renault": Colors.yellow,
    "alpine": Colors.yellow,
    "alfa": Colors.purple,
    "haas": Colors.brown
  };

  static final Map<String, String> teamImages = {
    "mercedes": 'assets/images/icons/mercedes.png',
    "red_bull": 'assets/images/icons/redbull.png',
    "racing_point": 'assets/images/icons/aston.png',
    "aston": 'assets/images/icons/aston.png',
    "mclaren": 'assets/images/icons/mclaren.png',
    "renault": 'assets/images/icons/alpine.png',
    "alpine": 'assets/images/icons/alpine.png',
    "ferrari": 'assets/images/icons/ferrari.png',
    "alphatauri": 'assets/images/icons/tauri.png',
    "alfa": 'assets/images/icons/romeo.png',
    "williams": 'assets/images/icons/williams.png',
    "haas": 'assets/images/icons/haas.png'
  };

  static final Map<String,String> teamNames = {
    "mercedes": 'Mercedes AMG Petronas',
    "red_bull": 'Redbull Racing',
    "racing_point": 'Racing Point',
    "aston": 'Aston Martin Racing',
    "mclaren": 'McLaren',
    "renault": 'Alpine F1 Team',
    "alpine": 'Alpine F1 Team',
    "ferrari": 'Scuderia Ferrari',
    "alphatauri": 'Scuderia AlphaTauri',
    "alfa": 'Alfa Romeo Racing',
    "williams": 'Williams Racing',
    "haas": 'Haas F1 Team'
  };
}
