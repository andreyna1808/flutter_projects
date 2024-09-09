import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String text;
  final int index; // Adicione o índice
  final void Function(int)
      onSelection; // Atualize a função para aceitar o índice

  // Construtor usando parâmetros posicionais
  const Answer(this.text, this.index, this.onSelection, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.all(10.0), // Margem de 10 pixels em todos os lados
      child: FractionallySizedBox(
        widthFactor: 0.95, // 95% da largura da tela
        child: ElevatedButton(
          onPressed: () =>
              onSelection(index), // Passa o índice da resposta ao clicar
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple, // Cor de fundo do botão
            foregroundColor: Colors.white, // Cor do texto
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center, // Centraliza o texto horizontalmente
          ),
        ),
      ),
    );
  }
}
