# Aplicativo Mobile de Cotações Financeiras (Flutter)

## Descrição do Projeto
Este é um aplicativo mobile desenvolvido em Flutter que permite aos usuários consultar cotações de moedas financeiras em tempo real. Ele se conecta a uma API pública de cotações, exibe os dados em uma interface amigável, oferece funcionalidades de pesquisa, seleção de moeda base e um conversor de moedas detalhado.

## Contexto do Desafio
Este projeto foi desenvolvido como parte do desafio Talent Lab 2025, com foco no desenvolvimento Mobile com Flutter. O objetivo é demonstrar proficiência no desenvolvimento de aplicativos Flutter, consumo de APIs REST, gerenciamento de estado, navegação entre telas, aplicação de princípios de design e testes unitários.

## Funcionalidades Implementadas
* **Tela de Boas-Vindas (Welcome Screen):** Uma tela inicial de apresentação que guia o usuário ao aplicativo.
* **Consulta de Cotações em Tempo Real:** Conecta-se à [ExchangeRate-API](https://www.exchangerate-api.com/) para obter as taxas de câmbio mais recentes.
* **Listagem de Cotações:** Exibe uma lista de moedas e suas respectivas taxas de conversão de forma clara.
* **Seleção de Moeda Base:** Permite ao usuário escolher a moeda base (ex: USD, BRL, EUR) para ver as conversões a partir dela.
* **Pesquisa/Filtro de Moedas:** Funcionalidade de pesquisa para filtrar a lista de cotações por código de moeda (ex: "BRL").
* **Tela de Detalhes (Detail Screen):** Ao tocar em uma moeda na lista, o usuário navega para uma tela dedicada que exibe os detalhes da cotação.
* **Conversor de Moedas Integrado:** Na tela de detalhes, há um conversor que permite ao usuário digitar um valor e ver a conversão instantânea entre a moeda base e a moeda selecionada, com a opção de inverter a direção da conversão.
* **Design e UX (Experiência do Usuário):** Aplicativo com tema de cores personalizado (lilás e branco), ícones visuais e componentes Material Design para uma interface atraente e intuitiva.

## Tecnologias Utilizadas
* **Flutter:** Framework para desenvolvimento de aplicativos mobile multiplataforma.
* **Dart:** Linguagem de programação.
* **http:** Pacote Flutter para fazer requisições HTTP a APIs REST.
* **mockito:** Pacote para criação de mocks em testes unitários.
* **flutter_test:** Framework de testes para Flutter.

## Como Configurar e Executar o Projeto

### Pré-requisitos
* [Flutter SDK](https://flutter.dev/docs/get-started/install) instalado e configurado.
* [Android Studio](https://developer.android.com/studio) (para emulador ou dispositivo Android) ou [Xcode](https://developer.apple.com/xcode/) (para iOS).
* Chave de API (API Key) da [ExchangeRate-API](https://www.exchangerate-api.com/) (registro gratuito).

### Passos de Configuração

1.  **Clonar o Repositório:**
    ```bash
    git clone https://github.com/kassia-ramos/cotacoes_app.git
    cd cotacoes_app
    ```
2.  **Obter Chave de API:**
    * Registre-se gratuitamente em [ExchangeRate-API](https://www.exchangerate-api.com/) e obtenha sua chave de API.
    * Abra o arquivo `lib/services/cotacao_service.dart`.
    * Substitua `'SUA_API_KEY_AQUI'` no campo `apiKey` pela sua chave real.
        ```dart
        final String apiKey = 'SUA_API_KEY_AQUI'; 
        ```
3.  **Instalar Dependências:**
    ```bash
    flutter pub get
    ```

### Executando o Aplicativo

1.  **Iniciar Emulador ou Conectar Dispositivo:**
    * No Android Studio, inicie um emulador Android via Device Manager (AVD Manager).
    * Alternativamente, conecte um dispositivo Android físico com Depuração USB ativada.
2.  **Rodar o Aplicativo:**
    Abra o terminal na raiz do projeto (`cotacoes_app`) e execute:
    ```bash
    flutter run
    ```
    Ou, abra o arquivo main.dart e clique em:
    ```bash
     run
    ```
    No conteúdo do código, entre as importações e "Void main".

    O aplicativo será compilado e iniciado no emulador/dispositivo.

## Testes Unitários

O projeto inclui **3 testes unitários** para a funcionalidade de consulta de cotações (`CotacaoService`), utilizando `flutter_test` e `mockito`. Esses testes verificam se o serviço:
* Retorna os dados corretamente em caso de sucesso da API.
* Lança exceções apropriadas em caso de falha HTTP (ex: 404).
* Lança exceções em caso de erro retornado pela própria API (ex: chave inválida).

Todos os testes foram executados com sucesso e confirmam a robustez e confiabilidade do `CotacaoService` em diferentes cenários de resposta da API, isolando-o de dependências de rede reais através do mocking.

### Como Executar os Testes

1.  Abra o terminal na raiz do projeto (`cotacoes_app`).
2.  Execute o comando:
    ```bash
    flutter test
    ```
    O resultado esperado é "All tests passed!".

---
### Considerações
Este repositório tem como principal objetivo compartilhar a implementação do Desafio 1: Aplicativo Mobile de Consulta de Cotações (Flutter), do Talent Lab. O desenvolvimento de todas as etapas levaram em consideração as especificações e pedidos na descrição do desafio.