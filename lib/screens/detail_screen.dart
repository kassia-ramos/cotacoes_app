import 'package:flutter/material.dart';

// Tela de Detalhes da Cotação
class DetailScreen extends StatelessWidget {
  final String currency; // nome da moeda
  final String rate;     //  valor da cotação
  final String baseCurrency; // a moeda base 

 
  const DetailScreen({
    super.key,
    required this.currency,
    required this.rate,
    required this.baseCurrency,
  });
// detalhes da moeda
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes de $currency'), 
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min, 
                crossAxisAlignment: CrossAxisAlignment.start, 
                children: [
                  Text(
                    'Moeda: $currency', 
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor 
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Taxa de Câmbio:', 
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '1 $baseCurrency = $rate $currency',
                    style: const TextStyle(fontSize: 24, color: Colors.green),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Última atualização: ${DateTime.now().toLocal().toString().split('.')[0]}', 
                    style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.grey),
                  ),
                  const SizedBox(height: 25),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context); 
                      },
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Voltar à Lista'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}