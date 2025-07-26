import 'package:flutter/material.dart';
import 'package:cotacoes_app/screens/welcome_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Define a cor lilás personalizada
    const Color customLilac = Color.fromARGB(255, 88, 57, 137);

    return MaterialApp(
      title: 'Cotações Financeiras',
      theme: ThemeData(
        // Definição do Tema principal do aplicativo
        scaffoldBackgroundColor: Colors.white,
        canvasColor: Colors.white,

        // Cores personalizadas para o lilás específico
        primarySwatch: Colors.deepPurple, // Mantém como base, mas usaremos a cor exata
        primaryColor: customLilac, // Usa a cor lilás personalizada
        hintColor: customLilac.withOpacity(0.6), // Um tom mais claro do lilás para acentos

        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: customLilac, // Lilás para o fundo da AppBar
          foregroundColor: Colors.white, // Cor do texto e ícones na AppBar (branco para contraste)
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: customLilac, // Lilás para o fundo do botão
            foregroundColor: Colors.white, // Cor do texto do botão (branco para contraste)
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          ),
        ),
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        // Adicionando um tema de texto para facilitar a definição de cores de texto global
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black87),
          bodyMedium: TextStyle(color: Colors.black54),
          titleLarge: TextStyle(color: Colors.black87),
        ),
      ),
      home: const WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

