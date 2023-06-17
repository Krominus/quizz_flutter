import 'package:flutter/material.dart';

class Quizz {
  late final String name;
  final IconData icon;
  final List<String> questions; // Modification : le type de la liste de questions est défini comme List<String>
  
  Quizz({required this.icon, required this.name, required this.questions});
}
