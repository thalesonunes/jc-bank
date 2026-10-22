# Aula 01 — REST, Controller e DTO

> Material de estudo da segunda aula do **JC Bank**.
>
> **Como usar:** leia os conceitos, consulte as fontes oficiais e só depois implemente a prática. Não copie código sem entender — você vai precisar explicar o que fez.

## Objetivo da aula

Ao final, você será capaz de:

- explicar o que é um **recurso REST** e como representá-lo;
- criar um controller com `GET` de lista e `GET` por id;
- usar um **DTO** para controlar o que a API expõe;
- responder `404` quando o recurso não existe;
- manter os dados **em memória** (o banco entra na AULA 03).

## Pré-requisitos

- AULA 00 concluída: projeto rodando e publicado no GitHub.
- Conceitos da AULA 00: HTTP, JSON, `@RestController` e `@GetMapping`.
- Branch local atualizada com a `main`.

---

## Conteúdo a ser estudado

### 1. REST: recursos, não ações

**Explicação inicial.** Em REST, a API é organizada em **recursos** — normalmente substantivos. A ação é indicada pelo **método HTTP**.

| Caminho | Representa |
|---|---|
| `/clientes` | A coleção de clientes. |
| `/clientes/{id}` | Um cliente específico. |

`GET /clientes` lê a coleção; `POST /clientes` criaria um cliente (na AULA 04). Repare que o caminho não tem verbo: não é `/buscarClientes`.

**Pesquise e responda:**

- Por que `/clientes` é preferível a `/buscarClientes` em uma API REST?
- O que significa dizer que o cliente e o servidor trocam **representações** do recurso?

**Para se aprofundar:**

- MDN — HTTP: <https://developer.mozilla.org/en-US/docs/Web/HTTP>
- Spring — Web MVC: <https://docs.spring.io/spring-framework/reference/web/webmvc.html>

### 2. `GET` e parâmetros de caminho

**Explicação inicial.** O `GET` serve para **ler**. Em `/clientes/{id}`, o trecho `{id}` é um **path parameter**: faz parte do caminho e identifica um recurso.

No Spring, isso vira:

```kotlin
@GetMapping("/{id}")
fun buscar(@PathVariable id: Long): ClienteResponse { ... }
```

**Pesquise e responda:**

- Qual é a diferença entre um **path parameter** (`/clientes/{id}`) e um **query parameter** (`/clientes?nome=ana`)?
- O que acontece se o `id` da URL não for um número?

**Para se aprofundar:**

- Spring — Controllers: <https://docs.spring.io/spring-framework/reference/web/webmvc/mvc-controller.html>
- Spring — Request Mapping: <https://docs.spring.io/spring-framework/reference/web/webmvc/mvc-controller/ann-requestmapping.html>
- MDN — `GET`: <https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/GET>

### 3. DTO: o contrato da API

**Explicação inicial.** **DTO** (*Data Transfer Object*) é o objeto que define **o formato dos dados que saem (ou entram) na API**. Ele não é o modelo interno.

Por que não devolver o modelo interno direto?

- Para **não expor dados sensíveis** (o modelo tem `cpf`; a resposta não deve ter).
- Para **controlar o contrato**: mudar o interno sem quebrar a API.
- Para deixar claro o que é API e o que é regra de negócio.

No Kotlin, `data class` é uma boa escolha para DTOs: gera `equals`, `hashCode` e `toString`.

**Pesquise e responda:**

- Por que expor o CPF na resposta de uma API seria um problema?
- Qual a diferença entre o **modelo interno** e o **DTO**?

**Para se aprofundar:**

- Kotlin — Data classes: <https://kotlinlang.org/docs/data-classes.html>

### 4. Serialização para JSON

**Explicação inicial.** Quando o método do controller retorna um objeto, o Spring o converte para **JSON** (usando o Jackson). Os nomes das propriedades do objeto viram as chaves do JSON.

```kotlin
data class ClienteResponse(val id: Long, val nome: String, val email: String)
```

```json
{ "id": 1, "nome": "Ana", "email": "ana@example.com" }
```

**Pesquise e responda:**

- Como o header `Content-Type: application/json` aparece na resposta?
- O que aconteceria se o método retornasse uma `String`?

**Para se aprofundar:**

- MDN — JSON: <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON>

### 5. Status `200` e `404`

**Explicação inicial.**

- `200 OK` — o recurso foi encontrado e está no corpo da resposta.
- `404 Not Found` — o recurso pedido não existe.

No Spring, uma forma de sinalizar o `404` é lançar `ResponseStatusException(HttpStatus.NOT_FOUND)`. A padronização de erros (Problem Details) vem na AULA 04.

**Pesquise e responda:**

- Quando faz sentido responder `404` em uma API?
- Qual a diferença entre "não encontrado" (`404`) e "requisição inválida" (`400`)?

**Para se aprofundar:**

- MDN — `404`: <https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/404>
- Spring — `ResponseStatusException`: <https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/web/server/ResponseStatusException.html>

### 6. Organização por domínio

**Explicação inicial.** Vamos agrupar o código de cliente no pacote `br.com.jcbank.cliente`.

Nesta aula, os dados ficam em uma lista dentro do controller. Na **AULA 02** vamos extrair isso para as camadas `service` e `repository` — e você vai entender o valor da separação.

**Pesquise e responda:**

- Quais problemas podem aparecer quando o controller concentra dados e regras?
- O que muda quando separamos controller, service e repository?

**Para se aprofundar:**

- Spring — Controllers: <https://docs.spring.io/spring-framework/reference/web/webmvc/mvc-controller.html>

---

## Prática da semana

### Contexto

Criar a **leitura de clientes**, ainda sem banco de dados. O foco é praticar REST, controller, DTO e `404`.

### Especificação dos endpoints

#### `GET /api/v1/clientes`

- Status: `200 OK`.
- Corpo: lista de clientes.

```json
[
  { "id": 1, "nome": "Ana", "email": "ana@example.com" },
  { "id": 2, "nome": "Bruno", "email": "bruno@example.com" }
]
```

#### `GET /api/v1/clientes/{id}`

- Status `200 OK` com o cliente, se existir.
- Status `404 Not Found` se não existir.

**Contrato do `ClienteResponse`:**

| Campo | Tipo | Regra |
|---|---|---|
| `id` | número | Identificador do cliente. |
| `nome` | texto | Nome do cliente. |
| `email` | texto | E-mail do cliente. |

> O modelo interno tem `cpf`, mas o **CPF não deve aparecer** na resposta. É justamente para isso que existe o DTO.

### Requisitos técnicos

- Pacote `br.com.jcbank.cliente`.
- Modelo interno `Cliente` (com `cpf`) e DTO `ClienteResponse` (sem `cpf`).
- Dados em memória: uma lista fixa com **pelo menos 2 clientes**.
- Usar `@RestController`, `@GetMapping` e `@PathVariable`.
- Sem banco de dados e sem dependências novas.
- Por enquanto, a lista pode ficar no controller; na AULA 02 ela sai de lá.

### Entregáveis

- Branch `feat/clientes-leitura`.
- Commits pequenos, com mensagens claras.
- **Pull Request** para a `main`, com o relatório abaixo.

### Critérios de aceite

- [ ] `GET /api/v1/clientes` responde `200` com a lista.
- [ ] `GET /api/v1/clientes/{id}` de um cliente existente responde `200`.
- [ ] `GET /api/v1/clientes/{id}` de um id inexistente responde `404`.
- [ ] A resposta **não contém** o campo `cpf`.
- [ ] O código está no pacote `br.com.jcbank.cliente`.
- [ ] O PR foi aberto a partir da branch `feat/clientes-leitura`.

### Como testar

1. Rode a aplicação:
   ```bash
   ./gradlew bootRun
   ```
2. Teste os endpoints:
   ```bash
   curl -i http://localhost:8080/api/v1/clientes
   curl -i http://localhost:8080/api/v1/clientes/1
   curl -i http://localhost:8080/api/v1/clientes/999
   ```
3. Rode o smoke test da etapa:
   ```bash
   ./scripts/smoke-test.sh 01
   ```

### Relatório do Pull Request

Escreva, com suas palavras:

1. Por que usamos `/clientes` e não `/buscarClientes`?
2. Por que existe o `ClienteResponse` em vez de retornar o `Cliente` direto?
3. O que o `@PathVariable` faz?
4. O que acontece ao acessar `/api/v1/clientes/abc`? Por quê?
5. Como o Spring transforma o objeto em JSON?

### Rubrica de avaliação

| Critério | O que será observado |
|---|---|
| Funciona | Lista responde `200`; id existente responde `200`; inexistente responde `404`. |
| Contrato | JSON com `id`, `nome` e `email`; sem `cpf`. |
| Código | Pacote correto, `@RestController`/`@GetMapping`/`@PathVariable`, DTO em `data class`. |
| Git | Branch, commits pequenos, PR com descrição. |
| Compreensão | Relatório com explicações e experimentos. |

### Bônus (opcional)

- Adicionar um filtro por nome: `GET /api/v1/clientes?nome=ana` (pesquise `@RequestParam`).
- Adicionar um terceiro cliente à lista e testar.

---

## Fontes oficiais

- **Spring — Controllers**: <https://docs.spring.io/spring-framework/reference/web/webmvc/mvc-controller.html>
- **Spring — Request Mapping**: <https://docs.spring.io/spring-framework/reference/web/webmvc/mvc-controller/ann-requestmapping.html>
- **Kotlin — Data classes**: <https://kotlinlang.org/docs/data-classes.html>
- **MDN — HTTP**: <https://developer.mozilla.org/en-US/docs/Web/HTTP>
- **MDN — `404`**: <https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/404>

## Dicas de estudo

- Explique o conceito com suas palavras antes de implementar.
- Consulte a documentação oficial antes de procurar soluções prontas.
- Faça commits pequenos e teste cada endpoint assim que criar.
- Anote as dúvidas e traga para a próxima aula.
