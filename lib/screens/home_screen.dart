import 'package:flutter/material.dart';
import 'package:cotacoes_app/services/cotacao_service.dart';
import 'package:cotacoes_app/screens/detail_screen.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CotacaoService _cotacaoService = CotacaoService();
  Map<String, dynamic> _cotacoes = {}; // Todas as cotações originais
  List<MapEntry<String, dynamic>> _cotacoesFiltradas = []; // Cotações exibidas após o filtro
  bool _isLoading = true;
  String? _errorMessage;

  final List<String> _moedasBaseDisponiveis = ['USD', 'BRL', 'EUR', 'GBP', 'JPY'];
  String _moedaBaseSelecionada = 'USD';
  
  // Variável para armazenar o texto digitado no campo de pesquisa
  String _filterText = '';

  @override
  void initState() {
    super.initState();
    _carregarCotacoes();
  }

  // Função para aplicar o filtro
  void _applyFilter() {
    setState(() {
      if (_filterText.isEmpty) {
        // Se o texto do filtro está vazio, mostra todas as cotações
        _cotacoesFiltradas = _cotacoes.entries.toList();
      } else {
        // Filtra as cotações cujas chaves (moedas) contêm o texto do filtro 
        _cotacoesFiltradas = _cotacoes.entries
            .where((entry) => entry.key.toLowerCase().contains(_filterText.toLowerCase()))
            .toList();
      }
    });
  }

  Future<void> _carregarCotacoes() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final data = await _cotacaoService.fetchExchangeRates(_moedaBaseSelecionada);
      setState(() {
        _cotacoes = data; // Armazena todas as cotações originais
        _applyFilter(); // Aplica o filtro inicial (que mostrará tudo)
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
        title: const Text('Cotações em Tempo Real'),
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
                    _filterText = ''; // Limpa o filtro ao mudar a moeda base
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
              : Column( 
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Pesquisar Moeda',
                          hintText: 'Ex: BRL, EUR, JPY',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Theme.of(context).primaryColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _filterText = value; // Atualiza o texto do filtro
                          });
                          _applyFilter(); // Aplica o filtro a cada digitação
                        },
                      ),
                    ),
                    Expanded( 
                      child: _cotacoesFiltradas.isEmpty && _filterText.isNotEmpty
                          ? Center(
                              child: Text(
                                'Nenhuma moeda encontrada para "$_filterText".',
                                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                              ),
                            )
                          : ListView.builder(
                              itemCount: _cotacoesFiltradas.length,
                              itemBuilder: (context, index) {
                                String currency = _cotacoesFiltradas[index].key;
                                String rate = _cotacoesFiltradas[index].value.toStringAsFixed(4);

                                return Card(
                                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                  elevation: 4,
                                  child: ListTile(
                                    // Apenas navega, sem passar detalhes
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailScreen(
                                            currency: currency,
                                            rate: rate,
                                            baseCurrency: _moedaBaseSelecionada,
                                          ),
                                        ),
                                      );
                                    },
                                    title: Text(currency, style: const TextStyle(fontWeight: FontWeight.bold)),
                                    subtitle: Text('1 $_moedaBaseSelecionada = $rate $currency'),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
    );
  }
}