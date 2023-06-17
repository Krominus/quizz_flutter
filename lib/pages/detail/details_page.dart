import 'package:flutter/material.dart';
import 'package:flutter_project_1/quizz/questions.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late String pokemonName;
  late List<String> questions;
  late List<TextEditingController> textControllers;
  int currentQuestionIndex = 0;
  String response = '';
  String correctAnswer = '';

  // Added list for multiple-choice options
  List<List<String>> mcqOptions = [
    [], // No options for question 0
    ['mjollnir', 'marteau', 'strombreaker'], // Options for question 1
    [], // No options for question 2
  ];
  int? selectedOption;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadQuestions();
  }

  void loadQuestions() {
    pokemonName = ModalRoute.of(context)!.settings.arguments as String;
    if (pokemonName == "MARVEL") {
      questions = quizzMarvel;
    } else {
      questions = quizzGot;
    }
    textControllers = List.generate(
      questions.length,
      (index) => TextEditingController(),
    );
  }

  void validateAnswer() {
    if (currentQuestionIndex == 1) {
      if (selectedOption == null) {
        return;
      }
      response = mcqOptions[currentQuestionIndex][selectedOption!];
    } else {
      // Validate regular answer
      response = textControllers[currentQuestionIndex].text.trim().toLowerCase();
    }

    correctAnswer = getCorrectAnswer(currentQuestionIndex);

    if (response == correctAnswer) {
      print("Bonne réponse pour la question $currentQuestionIndex: $response");
      // Perform appropriate action for correct answer
      if (currentQuestionIndex == questions.length - 1) {
        // Show pop-up dialog for last question
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Bravo !'),
              content: Text('Vous avez répondu correctement à toutes les questions.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    // Perform any additional actions
                  },
                ),
              ],
            );
          },
        );
      } else {
        goToNextQuestion();
      }
    } else {
      print("Mauvaise réponse pour la question $currentQuestionIndex: $response");
      // Perform appropriate action for incorrect answer
      setState(() {
        textControllers[currentQuestionIndex].text = ''; // Clear the text field
        textControllers[currentQuestionIndex].selection =
            TextSelection.collapsed(offset: 0); // Reset cursor position
      });
    }
  }

  String getCorrectAnswer(int questionIndex) {
    if (pokemonName == "MARVEL") {
      switch (questionIndex) {
        case 0:
          return "new york";
        case 1:
          return "mjollnir";
        case 2:
          return "vision";
      }
    } else {
      switch (questionIndex) {
        case 0:
          return "jon snow";
        case 1:
          return "marcheurs blancs";
        case 2:
          return "tyrion";
      }
    }
    return "";
  }

  void goToNextQuestion() {
    setState(() {
      currentQuestionIndex++;
    });
  }

  Widget buildQuestionWidget() {
    final questionStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
    final optionStyle = TextStyle(fontSize: 16);

    if (currentQuestionIndex == 1 && pokemonName == "MARVEL") {
      // Render multiple-choice question widget for quizzMarvel question 2
      return Column(
        children: [
          Text(
            questions[currentQuestionIndex],
            style: questionStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Column(
            children: List.generate(mcqOptions[currentQuestionIndex].length, (index) {
              return RadioListTile<int>(
                title: Text(
                  mcqOptions[currentQuestionIndex][index],
                  style: optionStyle,
                ),
                value: index,
                groupValue: selectedOption,
                onChanged: (value) {
                  setState(() {
                    selectedOption = value;
                  });
                },
              );
            }).toList(),
          ),
        ],
      );
    } else {
      // Render regular question widget for other questions
      return Column(
        children: [
          Text(
            questions[currentQuestionIndex],
            style: questionStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          TextField(
            textAlign: TextAlign.center, // Center the text in the TextField
            controller: textControllers[currentQuestionIndex],
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: response == correctAnswer ? Color.fromARGB(255, 0, 208, 255) : Colors.red,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: response == correctAnswer ? Color.fromARGB(255, 0, 208, 255) : Colors.red,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: response == correctAnswer ? Color.fromARGB(255, 0, 208, 255) : Colors.red,
                ),
              ),
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quizz'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildQuestionWidget(), // Use the helper function to render the question widget
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: validateAnswer,
                child: Text('Valider'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
