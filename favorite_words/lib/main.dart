import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  // informa ao Flutter para executar o app definido em MyApp
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Favorite Words',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

// Define os dados necessários para o app funcionar.
// Emitir notificações sobre suas próprias mudanças
class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      // Remove o par de palavras caso esteja na lista de favoritos
      favorites.remove(current);
    } else {
      // Adiciona o par de palavras caso não esteja na lista de favoritos
      favorites.add(current);
    }
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;

    // Conforme o idx da navegação lateral fará a mudança da página
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        page = FavoritesPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    // Estrutura padrão de tela no Flutter
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        // Alinha os filhos horizontalmente.
        body: Row(
          children: [
            // SafeArea garante que o conteúdo não sobreponha áreas protegidas
            // como a barra de status do dispositivo.
            SafeArea(
              // Componente de navegação lateral.
              child: NavigationRail(
                extended: constraints.maxWidth >=
                    600, // Se for maior que 600px então será expandido
                // Define as opções de navegação.
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.favorite),
                    label: Text('Favorites'),
                  ),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            // Expanded faz com que o próximo filho ocupe o espaço restante da tela.
            Expanded(
              child: Container(
                // Define a cor de fundo do container, usando o tema atual.
                color: Theme.of(context).colorScheme.primaryContainer,
                // Exibe a página principal (GeneratorPage) no espaço restante da tela.
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}

// Define uma página geradora (GeneratorPage) que também é StatelessWidget.
class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtém o estado do app (MyAppState) para acessar os dados e métodos dele.
    var appState = context.watch<MyAppState>();
    // Pega o par de palavras atual (WordPair) do estado.
    var pair = appState.current;

    // Define um ícone que será exibido, dependendo se está nos favoritos.
    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    // Retorna um layout centralizado (Center) na tela.
    return Center(
      // Dentro do Center, organiza os widgets verticalmente com Column.
      child: Column(
        // Centraliza os itens dentro da coluna verticalmente.
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Exibe o widget BigCard que mostra o par de palavras.
          BigCard(pair: pair),
          // Adiciona um espaço de 10px entre o BigCard e o próximo widget.
          const SizedBox(height: 10),
          // Uma linha (Row) com tamanho mínimo (mainAxisSize.min), para alinhar horizontalmente os botões.
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                // Chama a função toggleFavorite
                onPressed: () {
                  appState.toggleFavorite();
                },
                // O ícone muda com base no estado de favorito (cheio ou vazio).
                icon: Icon(icon),
                label: const Text('Like'),
              ),
              // Adiciona um espaço de 10px entre os dois botões.
              const SizedBox(width: 10),
              // Um botão que chama a função getNext().
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: const Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ...

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    if (appState.favorites.isEmpty) {
      return const Center(
        child: Text('No favorites yet.'),
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('You have '
              '${appState.favorites.length} favorites:'),
        ),
        for (var pair in appState.favorites)
          ListTile(
            title: Row(
              children: [
                const Icon(Icons.favorite),
                Text(pair.asLowerCase),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  // Chama a função toggleFavorite
                  onPressed: () {
                    appState.toggleFavorite();
                  },
                  label: const Text('Remover'),
                ),
              ],
            ),
            // onTap: () => {print("Fui apertados")},
          ),
      ],
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}
