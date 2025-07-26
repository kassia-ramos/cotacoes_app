import 'package:flutter/material.dart';
import 'package:cotacoes_app/services/cotacao_service.dart'; // Import do serviço de cotações


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CotacaoService _cotacaoService = CotacaoService();
  Map<String, dynamic> _cotacoes = {};
  bool _isLoading = true;
  String? _errorMessage;

  final List<String> _moedasBaseDisponiveis = ['USD', 'BRL', 'EUR', 'GBP', 'JPY'];
  String _moedaBaseSelecionada = 'USD';

  @override
  void initState() {
    super.initState();
    _carregarCotacoes();
  }

  Future<void> _carregarCotacoes() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final data = await _cotacaoService.fetchExchangeRates(_moedaBaseSelecionada);
      setState(() {
        _cotacoes = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Erro ao carregar dados: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cotações'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: DropdownButton<String>(
              value: _moedaBaseSelecionada,
              dropdownColor: Theme.of(context).primaryColor,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              underline: Container(),
              icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _moedaBaseSelecionada = newValue;
                  });
                  _carregarCotacoes();
                }
              },
              items: _moedasBaseDisponiveis.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _carregarCotacoes,
                        child: const Text('Tentar Novamente'),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: _cotacoes.length,
                  itemBuilder: (context, index) {
                    String currency = _cotacoes.keys.elementAt(index);
                    String rate = _cotacoes[currency].toStringAsFixed(4);

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      elevation: 4,
                      child: ListTile(
                        title: Text(currency, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('1 $_moedaBaseSelecionada = $rate $currency'),
                      ),
                    );
                  },
                ),
    );
  }
}