import 'dart:convert';
import 'package:http/http.dart' as http;

class CotacaoService {
  final String apiKey = 'dcb7c98b00ff44c3063370cf'; // Sua chave de API real
  final String baseUrl = 'https://v6.exchangerate-api.com/v6';
  
  final http.Client _httpClient; 

  CotacaoService() : _httpClient = http.Client();
  CotacaoService.withClient(this._httpClient); 

  // Método para obter as taxas de câmbio de uma moeda base (ex: USD)
  // O teste irá chamar este método, e o mockClient.get() receberá uma String
  Future<Map<String, dynamic>> fetchExchangeRates(String baseCurrency) async {
    final String apiUrl = '$baseUrl/$apiKey/latest/$baseCurrency';

    try {
      // Agora, o mockClient.get() receberá uma String que será convertida para Uri aqui dentro.
      // Isso simplifica o mocking no teste.
      final response = await _httpClient.get(Uri.parse(apiUrl)); // <<< AQUI A CONVERSÃO PARA URI

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['result'] == 'success') {
          return data['conversion_rates'];
        } else {
          throw Exception('Erro na API: ${data['error-type']}');
        }
      } else {
        throw Exception('Falha ao carregar cotações: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }
}