# Aula 00 — Ambiente e primeiro projeto

> Material de estudo da primeira aula do **JC Bank**.
>
> **Como usar:** leia cada tópico, consulte as **fontes oficiais** indicadas e só depois parta para a prática. A ideia não é decorar — é entender o suficiente para construir e explicar o que você fez.

## Objetivo da aula

Ao final, você será capaz de:

- explicar, com suas palavras, o que é uma API REST e como uma requisição HTTP funciona;
- reconhecer a estrutura de um projeto Spring Boot;
- rodar a aplicação localmente;
- versionar o código no GitHub e abrir um Pull Request.

## Pré-requisitos

- **JDK 21** instalado (`java -version`).
- **Git** instalado e configurado (`user.name`, `user.email`).
- **Conta no GitHub** com autenticação configurada (SSH ou token).
- **IntelliJ IDEA** (ou outra IDE de sua preferência).

---

## Conteúdo a ser estudado

> Estude os tópicos abaixo antes de desenvolver a prática. Cada um traz uma **explicação inicial** e **links para a documentação oficial** — aprofunde-se neles.

### 1. API e REST

**Explicação inicial.** Uma **API** é um contrato que permite que dois sistemas conversem. Na web, essa conversa acontece por **HTTP**: o cliente envia uma requisição e o servidor devolve uma resposta.

**REST** é um conjunto de convenções para organizar a API em torno de **recursos** (por exemplo: clientes, contas), usando os métodos HTTP para indicar a ação.

No nosso caso, o "cliente" pode ser o navegador, o Insomnia ou outro sistema. Nesta fase **não haverá tela**: toda a comunicação será por requisições e respostas em **JSON**.

**Pesquise e responda:**

- Qual é a diferença entre uma API REST e um site comum?
- O que significa dizer que uma API REST é *stateless*?

**Para se aprofundar:**

- MDN — HTTP: <https://developer.mozilla.org/en-US/docs/Web/HTTP>
- Spring — Web MVC: <https://docs.spring.io/spring-framework/reference/web/webmvc.html>

### 2. HTTP: requisição e resposta

**Explicação inicial.** Toda requisição HTTP tem: **método**, **URL**, **headers** e, às vezes, **corpo**. Toda resposta tem: **status**, **headers** e, às vezes, **corpo**.

**Métodos mais usados:**

| Método | Uso |
|---|---|
| `GET` | Buscar/ler um recurso. |
| `POST` | Criar um recurso. |
| `PUT` | Substituir um recurso. |
| `PATCH` | Atualizar parte de um recurso. |
| `DELETE` | Remover um recurso. |

**Famílias de status:**

| Faixa | Significado | Exemplos |
|---|---|---|
| `2xx` | Sucesso | `200 OK`, `201 Created`, `204 No Content` |
| `4xx` | Erro na requisição (cliente) | `400 Bad Request`, `404 Not Found`, `405 Method Not Allowed`, `409 Conflict` |
| `5xx` | Erro no servidor | `500 Internal Server Error` |

**Exemplo de requisição:**

```http
GET /api/v1/status HTTP/1.1
Host: localhost:8080
Accept: application/json
```

**Exemplo de resposta:**

```http
HTTP/1.1 200 OK
Content-Type: application/json

{ "status": "UP", "service": "jc-bank" }
```

**Pesquise e responda:**

- O que diferencia `404` de `400`?
- O que o header `Content-Type` informa?

**Para se aprofundar:**

- MDN — Métodos HTTP: <https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods>
- MDN — Status HTTP: <https://developer.mozilla.org/en-US/docs/Web/HTTP/Status>

### 3. JSON

**Explicação inicial.** **JSON** é um formato de texto para trocar dados. Ele organiza informações em pares `chave: valor` e suporta objetos, listas, textos, números, booleanos e `null`.

```json
{
  "status": "UP",
  "service": "jc-bank",
  "versao": 1,
  "ativo": true
}
```

O Spring converte automaticamente um objeto do seu código para JSON na resposta (e o contrário na entrada).

**Pesquise e responda:**

- Qual a diferença entre um objeto JSON e uma lista JSON?

**Para se aprofundar:**

- JSON.org: <https://www.json.org/json-en.html>
- MDN — JSON: <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON>

### 4. Git e GitHub

**Explicação inicial.** **Git** controla o histórico do código na sua máquina. **GitHub** hospeda esse repositório na nuvem e permite colaboração (branches, Pull Requests).

**Fluxo básico:** `add` (seleciona o que vai entrar) → `commit` (registra no histórico) → `push` (envia para o GitHub).

| Comando | O que faz |
|---|---|
| `git status` | Mostra o estado dos arquivos. |
| `git add <arquivo>` | Prepara um arquivo para o commit. |
| `git commit -m "mensagem"` | Registra as mudanças. |
| `git push` | Envia os commits para o GitHub. |
| `git checkout -b <branch>` | Cria e entra em uma nova branch. |
| `git log --oneline` | Mostra o histórico resumido. |

**Boas mensagens de commit** seguem um prefixo que indica o tipo da mudança:

| Prefixo | Uso |
|---|---|
| `feat` | Nova funcionalidade. |
| `fix` | Correção de bug. |
| `docs` | Documentação. |
| `test` | Testes. |
| `chore` | Manutenção/build/configuração. |
| `refactor` | Mudança sem alterar comportamento. |

**Pesquise e responda:**

- O que é uma *branch* e por que não trabalhar direto na `main`?
- O que é um *Pull Request* e quem participa dele?

**Para se aprofundar:**

- Pro Git Book (pt-BR): <https://git-scm.com/book/pt-br/v2>
- GitHub Docs — Pull Requests: <https://docs.github.com/pt/pull-requests>

### 5. A stack do projeto

| Peça | Papel |
|---|---|
| **Kotlin** | Linguagem de programação. |
| **JVM** | Ambiente que executa o código Kotlin. |
| **Spring Boot** | Framework que cria o servidor e as rotas da API. |
| **Gradle** | Ferramenta de build: compila, baixa dependências e executa. |

**Pesquise e responda:**

- O que o Spring Boot faz que o Spring "puro" não faz sozinho?
- Para que serve o arquivo `build.gradle.kts`?

**Para se aprofundar:**

- Kotlin: <https://kotlinlang.org/docs/home.html>
- Spring Boot: <https://docs.spring.io/spring-boot/>
- Gradle: <https://docs.gradle.org/current/userguide/userguide.html>

### 6. Estrutura do projeto Spring Boot

| Arquivo / pasta | Para que serve |
|---|---|
| `build.gradle.kts` | Dependências e configurações do build. |
| `gradlew` / `gradle/wrapper/` | Garantem a mesma versão do Gradle para todo mundo. |
| `src/main` | Código da aplicação. |
| `src/test` | Testes automatizados. |
| `src/main/resources/application.properties` | Configurações da aplicação (porta, etc.). |
| `JcBankApplication.kt` | Ponto de entrada: onde a aplicação inicia. |
| `.gitignore` | Lista de arquivos que não devem ir para o Git. |

**Pesquise e responda:**

- O que acontece ao executar o método `main` de `JcBankApplication`?
- Por que `src/main` e `src/test` são separados?

**Para se aprofundar:**

- Spring Boot — Referência: <https://docs.spring.io/spring-boot/reference/>

### 7. Anotações do Spring e a anatomia de um controller

**O que é uma anotação.** Em Kotlin (e Java), uma anotação é um marcador escrito com `@` que adiciona **metadados** ao código. Ela **não executa nada sozinha**: quem lê esses marcadores é o Spring, quando a aplicação inicia.

**Como o Spring encontra o seu controller.** A classe `JcBankApplication` tem `@SpringBootApplication`, que ativa a **varredura de componentes** (*component scan*): o Spring procura classes anotadas nos pacotes **abaixo** de `br.com.jcbank`. Por isso o controller precisa estar em um subpacote de `br.com.jcbank` (no nosso caso, `br.com.jcbank.status`) — se ficar fora, o Spring não o encontra.

**As anotações desta prática:**

| Anotação | O que faz |
|---|---|
| `@RestController` | Marca a classe como um controller web e indica que o **retorno dos métodos vai no corpo da resposta** (ex.: JSON), e não em uma tela. Equivale a `@Controller` + `@ResponseBody`. |
| `@GetMapping` | Liga um método a requisições **`GET`**. Pode receber o caminho: `@GetMapping("/api/v1/status")`. |
| `@RequestMapping` | *(opcional)* Define um caminho-base na classe, evitando repetir o prefixo em cada método. |

**Anatomia de um controller — exemplo genérico (não é a sua tarefa):**

```kotlin
@RestController
@RequestMapping("/api/v1/exemplo")
class ExemploController {

    @GetMapping("/ola")
    fun ola(): OlaResponse = OlaResponse(mensagem = "olá")

    data class OlaResponse(val mensagem: String)
}
```

Lendo linha a linha:

- `@RestController` na classe diz ao Spring: "esta classe atende requisições e devolve dados".
- `@RequestMapping("/api/v1/exemplo")` define a **base** do caminho.
- `@GetMapping("/ola")` responde a `GET /api/v1/exemplo/ola`.
- O método devolve um **objeto**; o Spring o converte para JSON automaticamente.
- `data class` define o **formato** da resposta (as chaves do JSON vêm dos nomes das propriedades).

**O caminho de uma requisição (visão geral):**

```text
cliente → Spring (DispatcherServlet)
        → encontra o método pelo método HTTP + caminho
        → executa o método
        → converte o retorno em JSON
        → devolve a resposta
```

**Pesquise e responda:**

- Qual é a diferença entre `@Controller` e `@RestController`?
- O que aconteceria se o controller estivesse fora do pacote `br.com.jcbank`?
- Para que serve `@ResponseBody`?

**Para se aprofundar:**

- Spring — Controllers: <https://docs.spring.io/spring-framework/reference/web/webmvc/mvc-controller.html>
- Spring — Anotações de request mapping: <https://docs.spring.io/spring-framework/reference/web/webmvc/mvc-controller/ann-requestmapping.html>
- Kotlin — Data classes: <https://kotlinlang.org/docs/data-classes.html>
- Kotlin — Anotações: <https://kotlinlang.org/docs/annotations.html>

---

## Prática da semana

### Contexto

O primeiro endpoint serve para confirmar que a aplicação está no ar e que o caminho **requisição → controller → resposta** funciona. É o "olá, mundo" da API — e a base para tudo que virá depois.

### Especificação do endpoint (contrato)

| Item | Valor |
|---|---|
| Método | `GET` |
| Caminho | `/api/v1/status` |
| Autenticação | Nenhuma |
| Corpo da requisição | Vazio |
| Status de sucesso | `200 OK` |
| `Content-Type` da resposta | `application/json` |

**Corpo da resposta:**

```json
{
  "status": "UP",
  "service": "jc-bank"
}
```

**Contrato dos campos:**

| Campo | Tipo | Regra |
|---|---|---|
| `status` | texto | Sempre `"UP"`. |
| `service` | texto | Sempre `"jc-bank"`. |

**Comportamentos esperados:**

- Caminho diferente de `/api/v1/status` → `404 Not Found`.
- Método diferente de `GET` (ex.: `POST`) → `405 Method Not Allowed`.

### Requisitos técnicos

- Criar o controller no pacote `br.com.jcbank.status`.
- Usar `@RestController` e `@GetMapping`.
- Representar a resposta com uma **`data class`** (não use `Map`).
- Não adicionar dependências novas ao projeto.

### Entregáveis

- Branch `feat/status-endpoint` criada a partir da `main`.
- Commits pequenos, com mensagens claras.
- **Pull Request** para a `main`, com descrição e o relatório abaixo.

### Critérios de aceite

- [ ] `GET /api/v1/status` responde `200`.
- [ ] A resposta tem `Content-Type: application/json`.
- [ ] O corpo contém exatamente `status: "UP"` e `service: "jc-bank"`.
- [ ] Um caminho errado responde `404`.
- [ ] Um método errado (ex.: `POST`) responde `405`.
- [ ] O retorno usa uma `data class`.
- [ ] O código está no pacote `br.com.jcbank.status`.
- [ ] O PR foi aberto a partir da branch `feat/status-endpoint`.

### Como testar

1. Rode a aplicação:
   ```bash
   ./gradlew bootRun
   ```
2. No navegador, acesse `http://localhost:8080/api/v1/status`.
3. Pelo terminal, confira status e headers:
   ```bash
   curl -i http://localhost:8080/api/v1/status
   ```
4. Teste os casos de erro:
   ```bash
   curl -i http://localhost:8080/api/v1/nao-existe   # esperado: 404
   curl -i -X POST http://localhost:8080/api/v1/status   # esperado: 405
   ```

### Relatório do Pull Request

Escreva, com suas palavras:

1. O que o `@RestController` faz? (consulte a documentação oficial)
2. Por que usamos uma `data class` em vez de um `Map`?
3. O que acontece ao mudar a porta do servidor? Mostre como rodar em outra porta.
4. Quebre algo de propósito (por exemplo, um erro de sintaxe) e conte o que você observou.
5. Para que serve o `build.gradle.kts`? O que o **Gradle Wrapper** resolve?

### Rubrica de avaliação

| Critério | O que será observado |
|---|---|
| Funciona | Endpoint responde `200` com o JSON especificado. |
| Comportamento | `404` em caminho errado e `405` em método errado. |
| Código | `@RestController`/`@GetMapping` corretos, pacote certo, retorno em `data class`. |
| Git | Branch, commits pequenos e mensagens claras, PR com descrição. |
| Compreensão | Relatório com os experimentos e explicações com suas palavras. |

### Bônus (opcional)

- Documentar o novo endpoint no `README.md`.

---

## Fontes oficiais

Consulte sempre a documentação antes de fóruns ou vídeos:

- **HTTP / JSON** — MDN: <https://developer.mozilla.org/en-US/docs/Web/HTTP>
- **Git** — Pro Git Book (pt-BR): <https://git-scm.com/book/pt-br/v2>
- **GitHub** — Documentação: <https://docs.github.com/pt>
- **Kotlin** — Documentação: <https://kotlinlang.org/docs/home.html>
- **Spring Boot** — Documentação: <https://docs.spring.io/spring-boot/>
- **Spring Framework** — Web MVC: <https://docs.spring.io/spring-framework/reference/web/webmvc.html>
- **Gradle** — Guia do usuário: <https://docs.gradle.org/current/userguide/userguide.html>

## Dicas de estudo

- Leia a documentação oficial **antes** de procurar soluções prontas.
- Explique o conceito com suas palavras; se não conseguir, volte ao material.
- Não copie código sem entender — você vai precisar explicar o que fez.
- Faça commits pequenos; fica mais fácil voltar atrás se algo der errado.
- Anote as dúvidas que surgirem e traga para a próxima aula.
