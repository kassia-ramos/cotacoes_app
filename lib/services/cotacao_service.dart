import 'dart:convert'; 
import 'package:http/http.dart' as http; 

class CotacaoService {
  final String apiKey = 'dcb7c98b00ff44c3063370cf'; 
  final String baseUrl = 'https://v6.exchangerate-api.com/v6';

  // Método para obter as taxas de câmbio de uma moeda base 
  Future<Map<String, dynamic>> fetchExchangeRates(String baseCurrency) async {
    final String apiUrl = '$baseUrl/$apiKey/latest/$baseCurrency';

    try {
      final response = await http.get(Uri.parse(apiUrl)); // Faz a requisição HTTP GET

      if (response.statusCode == 200) { // Verifica se a requisição foi bem-sucedida
        final Map<String, dynamic> data = json.decode(response.body); // Decodifica a resposta JSON
        if (data['result'] == 'success') { // Verifica o status da API 
          return data['conversion_rates']; // Retorna apenas as taxas de conversão
        } else {
          throw Exception('Erro na API: ${data['error-type']}'); // Lança exceção se a API retornar erro
        }
      } else {
        throw Exception('Falha ao carregar cotações: ${response.statusCode}'); // Lança exceção se o status HTTP não for 200
      }
    } catch (e) {
      throw Exception('Erro de conexão: $e'); // Lança exceção para erros de rede ou outros
    }
  }
}