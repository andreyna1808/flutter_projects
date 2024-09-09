import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String text;

  // Construtor usando parâmetros posicionais
  const Question(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center, // Centraliza o conteúdo do texto
      ),
    );
  }
}
