import 'package:flutter/material.dart';
import 'package:flutter_project_1/pages/home/widgets/the_amazing_row.dart';
import 'package:flutter_project_1/quizz/questions.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Le meilleur quizz'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [],
              ),
              TheAmazingRow(
                imagePath: 'assets/marvel.jpg',
                label: questions[0].name.toUpperCase(),
              ),
              TheAmazingRow(
                imagePath: 'assets/got.jpg',
                label: questions[1].name.toUpperCase(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
