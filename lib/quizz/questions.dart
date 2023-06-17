import 'package:flutter/material.dart';
import 'package:flutter_project_1/quizz/quizz.dart';

final questions = <Quizz>[
  Quizz(name: 'Marvel', icon: Icons.sentiment_satisfied, questions: quizzMarvel),
  Quizz(name: 'Game of Thrones', icon: Icons.fireplace, questions: quizzGot),
];

List<String> quizzMarvel = [
    'QUESTION 1 : \n\n Quelle ville protège Spider-Man ?', 
    'QUESTION 2 : \n\n Quel est le nom du marteau de Thor?', 
    "QUESTION 3 : \n\n Comment s'appelle le mari de Wanda ? (il a une pierre sur le front et il est rouge)"
];

List<String> quizzGot = [
    "QUESTION 1 : \n\n Comment s'appelle le batard de la famille Stark ?", 
    "QUESTION 2 : \n\n Quel est le nom des méchants bonhommes bleus ?", 
    'QUESTION 3 : \n\n Quel est le prénom du nain de la famille Lannister ?'
];
