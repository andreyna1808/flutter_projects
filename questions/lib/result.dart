import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  // Propriedades que o widget filho vai receber
  final List<String> result;
  final int Function(List<int>) findMostFrequent;
  final List<int> choices;
  final VoidCallback resetQuiz;

  // Construtor para receber esses valores do widget pai
  Result({
    required this.result,
    required this.findMostFrequent,
    required this.choices,
    required this.resetQuiz,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Parabéns!!",
            style: TextStyle(fontSize: 28),
          ),
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
    );
  }
}
