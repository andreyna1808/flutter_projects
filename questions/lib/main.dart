import 'package:flutter/material.dart';
import './question.dart';
import './answer.dart';
import 'mocks/questions_mock.dart';
import './utils/findMostFrequent.dart';

void main() {
  runApp(const QuestionApp()); // Inicia o aplicativo com o widget QuestionApp.
}

class QuestionApp extends StatefulWidget {
  const QuestionApp({super.key}); // Construtor do QuestionApp.

  @override
  QuestionsAppState createState() =>
      QuestionsAppState(); // Cria o estado para o QuestionApp.
}

class QuestionsAppState extends State<QuestionApp> {
  var questionSelected = 0;
  List<int> choices = [];

  void handleAnswer(int selectedIndex) {
    if (hasQuestionSelected) {
      choices.add(selectedIndex);
      setState(() {
        questionSelected++; // Avança para a próxima pergunta.
      });
    }
  }

  void resetQuiz() {
    setState(() {
      questionSelected = 0;
      choices = [];
    });
  }

  get hasQuestionSelected {
    return questionSelected < questions.length;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget>? widgetsAnswers = hasQuestionSelected
        ? (questions[questionSelected]["answers"] as List<dynamic>)
            .asMap() // Cria um mapa com índices e valores
            .entries
            .map((entry) => Answer(entry.value, entry.key,
                handleAnswer)) // Passa o índice e a função
            .toList()
        : null;

    return MaterialApp(
      title: 'Perguntas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple), // Define o tema do aplicativo.
        useMaterial3: true, // Habilita o Material 3.
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Perguntas"), // Título da AppBar.
        ),
        body: hasQuestionSelected
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Question(questions[questionSelected]["text"]
                        as String), // Usa o widget Question para mostrar a pergunta atual.
                    ...?widgetsAnswers,
                  ],
                ),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Parabéns!!",
                      style: TextStyle(fontSize: 28),
                    ),
                    // Calcula o número mais frequente quando a tela de "Parabéns" é exibida
                    Text(
                      'Sua casa de Hogwarts é: ${result[findMostFrequent(choices)]}',
                      style: const TextStyle(fontSize: 24),
                    ),
                    ElevatedButton(
                      onPressed: resetQuiz,
                      child: const Text("Tentar novamente"),
                    ),
                  ],
                ),
              ), // Ambiente de resultado
      ),
    );
  }
}
