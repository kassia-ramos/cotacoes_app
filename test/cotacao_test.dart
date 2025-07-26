import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:cotacoes_app/services/cotacao_service.dart';

import 'cotacao_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('CotacaoService', () {
    late CotacaoService cotacaoService;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
      cotacaoService = CotacaoService.withClient(mockClient);
    });

    test('fetchExchangeRates deve retornar taxas de câmbio se a chamada HTTP for bem-sucedida', () async {
      final String baseCurrency = 'USD';
      final String expectedJson = '''
      {
        "result": "success",
        "conversion_rates": {
          "USD": 1,
          "EUR": 0.93,
          "BRL": 5.20,
          "GBP": 0.82
        }
      }
      ''';

      when(mockClient.get(any)).thenAnswer((_) async => http.Response(expectedJson, 200));

      final result = await cotacaoService.fetchExchangeRates(baseCurrency);

      expect(result, isA<Map<String, dynamic>>());
      expect(result['EUR'], 0.93);
      expect(result['BRL'], 5.20);
    });

    test('fetchExchangeRates deve lançar uma exceção se a chamada HTTP falhar', () async {
      final String baseCurrency = 'USD';

      when(mockClient.get(any)).thenAnswer((_) async => http.Response('Not Found', 404));

      expect(
        () => cotacaoService.fetchExchangeRates(baseCurrency),
        throwsA(isA<Exception>()),
      );
    });

    test('fetchExchangeRates deve lançar uma exceção se a API retornar um erro', () async {
      final String baseCurrency = 'USD';
      final String errorJson = '''
      {
        "result": "error",
        "error-type": "invalid-key"
      }
      ''';

      when(mockClient.get(any)).thenAnswer((_) async => http.Response(errorJson, 200));

      expect(
        () => cotacaoService.fetchExchangeRates(baseCurrency),
        throwsA(isA<Exception>()),
      );
    });
  });
}
