# Desafio Jaya Tech

Desafio dedicado a empresa Jaya Tech para avaliação

### 🚦 Pré Requisitos

- [Docker](https://www.docker.com/products/docker-desktop)

## Para executar o projeto

Clone o projeto em sua pasta local

```bash
git clone https://github.com/mateus-sartori/jaya_tech
```

Para subir os containers em `backend(Phoenix)`:

## 🎲 Rodando o servidor

É necessário estar dentro da basta Jaya Tech e rodar os seguintes comandos:

```bash
docker-compose build
```

```bash
docker-compose up
```

```bash
# Instale as dependencias do Gemfile
docker-compose exec api bash

# Dentro da bash do api
mix deps.get

# Por ser um projeto em Phoenix é necessário também inicializar o banco de dados em ambiente dev
mix ecto.create && mix ecto.migrate

# Por ser um projeto em Phoenix é necessário também inicializar o banco de dados em ambiente dev
Após isso, é necessário cadastrar os usuários ficticios para as transações

Rodar o comando mix ecto.migrate rodar "mix run priv/repo/seeds.exs"
```

## Como testar

```bash
É necessário realizar um start no servidor "iex -S mix"

Após isso, endpoints de transações estará disponível

EX: POST "localhost:4000/api/transactions" && GET "localhost:4000/api/list-transactions"

Para gravar uma trasação basta informar em JSON:

EX:

{
    "transaction": {
        "origin_currency": "usd",
        "destination_currency": "brl",
        "origin_value": 2500
    }
}

```

## Considerações

Eu poderia ter me esforçado mais, porém aconteceram uns problemas e acabei ficando sem muito tempo, acredito que com o que tenho entregado possa ser suficiente para avaliar algo do que foi pedido no desafio.
