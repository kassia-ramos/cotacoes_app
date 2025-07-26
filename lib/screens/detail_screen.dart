import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DetailScreen extends StatefulWidget {
  final String currency;
  final String rate;
  final String baseCurrency;

  const DetailScreen({
    super.key,
    required this.currency,
    required this.rate,
    required this.baseCurrency,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final TextEditingController _valorController = TextEditingController();
  double _resultadoConversao = 0.0;
  bool _conversaoDeBaseParaDestino = true; 

  // Mapa de ícones para as moedas
  final Map<String, String> _moedaIcons = const {
    'USD': '🇺🇸',
    'BRL': '🇧🇷',
    'EUR': '🇪🇺',
    'GBP': '🇬🇧',
    'JPY': '🇯🇵',
    'CAD': '🇨🇦',
    'AUD': '🇦🇺',
    'CHF': '🇨🇭',
    'CNY': '🇨🇳',
    'SEK': '🇸🇪',
    'NZD': '🇳🇿',
    'MXN': '🇲🇽',
    'SGD': '🇸🇬',
    'HKD': '🇭🇰',
    'NOK': '🇳🇴',
    'KRW': '🇰🇷',
    'TRY': '🇹🇷',
    'RUB': '🇷🇺',
    'INR': '🇮🇳',
    'ZAR': '🇿🇦',
    'PLN': '🇵🇱',
    'CZK': '🇨🇿',
    'DKK': '🇩🇰',
    'HUF': '🇭🇺',
    'ILS': '🇮🇱',
    'CLP': '🇨🇱',
    'PHP': '🇵🇭',
    'AED': '🇦🇪',
    'COP': '🇨🇴',
    'SAR': '🇸🇦',
    'MYR': '🇲🇾',
    'RON': '🇷🇴',
    'THB': '🇹🇭',
    'BGN': '🇧🇬',
    'HRK': '🇭🇷',
    'ISK': '🇮🇸',
    'UAH': '🇺🇦',
  };

  @override
  void dispose() {
    _valorController.dispose();
    super.dispose();
  }

  void _calcularConversao() {
    if (_valorController.text.isEmpty) {
      setState(() {
        _resultadoConversao = 0.0;
      });
      return;
    }

    try {
      double valor = double.parse(_valorController.text.replaceAll(',', '.'));
      double taxa = double.parse(widget.rate);

      setState(() {
        if (_conversaoDeBaseParaDestino) {
          // Converter de moeda base para moeda destino
          _resultadoConversao = valor * taxa;
        } else {
          // Converter de moeda destino para moeda base
          _resultadoConversao = valor / taxa;
        }
      });
    } catch (e) {
      setState(() {
        _resultadoConversao = 0.0;
      });
    }
  }

  void _trocarDirecaoConversao() {
    setState(() {
      _conversaoDeBaseParaDestino = !_conversaoDeBaseParaDestino;
      _calcularConversao(); // Recalcula com a nova direção
    });
  }

  String get _moedaOrigem => _conversaoDeBaseParaDestino ? widget.baseCurrency : widget.currency;
  String get _moedaDestino => _conversaoDeBaseParaDestino ? widget.currency : widget.baseCurrency;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_moedaIcons[widget.currency] ?? '💱'),
            const SizedBox(width: 8),
            Text('Detalhes de ${widget.currency}'),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Card principal com informações da moeda
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(context).primaryColor.withOpacity(0.1),
                        Theme.of(context).primaryColor.withOpacity(0.05),
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      // Ícone grande da moeda
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                            color: Theme.of(context).primaryColor.withOpacity(0.3),
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            _moedaIcons[widget.currency] ?? '💱',
                            style: const TextStyle(fontSize: 40),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      // Nome da moeda
                      Text(
                        widget.currency,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Taxa de câmbio
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Taxa de Câmbio',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '1 ${widget.baseCurrency}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 12),
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                Text(
                                  '${widget.rate} ${widget.currency}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Card do Conversor
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.swap_horiz,
                            color: Theme.of(context).primaryColor,
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Conversor de Moedas',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      
                      // Direção da conversão
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(_moedaIcons[_moedaOrigem] ?? '💱'),
                                  const SizedBox(width: 8),
                                  Text(
                                    _moedaOrigem,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: _trocarDirecaoConversao,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Icon(
                                  Icons.swap_horiz,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(_moedaIcons[_moedaDestino] ?? '💱'),
                                  const SizedBox(width: 8),
                                  Text(
                                    _moedaDestino,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Campo de entrada
                      TextField(
                        controller: _valorController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                        ],
                        decoration: InputDecoration(
                          labelText: 'Valor em $_moedaOrigem',
                          hintText: 'Digite o valor para converter',
                          prefixText: '${_moedaIcons[_moedaOrigem] ?? '💱'} ',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 2,
                            ),
                          ),
                        ),
                        onChanged: (value) => _calcularConversao(),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Resultado da conversão
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.green.withOpacity(0.3),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Resultado:',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(_moedaIcons[_moedaDestino] ?? '💱'),
                                const SizedBox(width: 8),
                                Text(
                                  '${_resultadoConversao.toStringAsFixed(2)} $_moedaDestino',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Card com informações adicionais
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Informações',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      _buildInfoRow(Icons.access_time, 'Última atualização',
                          DateTime.now().toLocal().toString().split('.')[0]),
                      
                      _buildInfoRow(Icons.attach_money, 'Moeda base', widget.baseCurrency),
                      
                      _buildInfoRow(Icons.currency_exchange, 'Taxa atual', widget.rate),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Botão de voltar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Voltar à Lista'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: Colors.grey[600],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}