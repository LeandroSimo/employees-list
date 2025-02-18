# Employees List

## Descrição

Employees List é um aplicativo desenvolvido em Flutter para listar empregados. O projeto permite a conexão com uma API simulada para obter e exibir informações sobre os empregados.

## Pré-requisitos

- [Flutter][flutter] SDK instalado (versão estável recomendada).
- Node.js instalado (para rodar a API simulada).

## Como Excutar o Projeto

**Clone o repositório:**

```
git clone https://github.com/LeandroSimo/employees-list.git
```

**Acesse a pasta do projeto:**

```
cd employees-list
```

**Baixe as dependências do Flutter:**

```
flutter pub get
```

**Rode o projeto com o seguinte comando:**

```
flutter run
```

## Executando Testes

**Dentro da pasta employees-list execute o seguinte comando:**

```
dart run build_runner build --delete-conflicting-outputs
```

Isso irá gerar os arquivos necessários para os testes.

**Em seguida execute os testes:**

```
flutter test
```

## Configurando a API

Caso precise alterar a rota da API, edite o arquivo lib/src/core/network/api_employees.dart. Isso é útil caso queira usar um caminho ou URL diferente do localhost ou alterar a porta do servidor.

## API Simulada

Para simular a API, siga os passos abaixo:

1. **Instale o Node.js** (caso ainda não tenha instalado):

   - [Baixe e instale o Node.Js][node]

2. **Instale o `json-server` globalmente:**

```
npm install -g json-server
```

3. **Clone o repositório da API simulada:**

```
git clone https://github.com/BeMobile/teste-pratico-mobile.git
```

4. **Navegue até a pasta do repositório clonado:**

```
cd teste-pratico-mobile
```

5. Inicie o servidor da API:

```
json-server --watch database.json
```

Ou, use o `npx` caso ocorra algum erro ou se assim preferir:

```
npx json-server database.json
```

Agora, o aplicativo estará pronto para consumir os dados da API simulada.

[flutter]:[https://docs.flutter.dev/get-started/install?_gl=1*k6ir38*_gcl_aw*R0NMLjE3Mzk4OTA1OTUuQ2owS0NRaUFfTkM5QmhDa0FSSXNBQlNuU1RaM1NvX0RES1BmQjFNeXpaZ3pUM1FTOHFIMHZ3bU9FZ3lQNG5uOVZUalh6TmNXazBsZUFqa2FBcEtIRUFMd193Y0I.*_gcl_dc*R0NMLjE3Mzk4OTA1OTUuQ2owS0NRaUFfTkM5QmhDa0FSSXNBQlNuU1RaM1NvX0RES1BmQjFNeXpaZ3pUM1FTOHFIMHZ3bU9FZ3lQNG5uOVZUalh6TmNXazBsZUFqa2FBcEtIRUFMd193Y0I.*_ga*MTU3NDA1Njk3Ni4xNzM3NDk4Njc1*_ga_04YGWK0175*MTczOTg5MDU5NS40LjAuMTczOTg5MDU5NS4wLjAuMA..]
[node]:[https://nodejs.org/pt/download]
