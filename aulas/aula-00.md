# Aula 00 — Ambiente e primeiro projeto

> Material de estudo da primeira aula do **JC Bank**.
> Ao final, você terá o projeto rodando na sua máquina e publicado no GitHub.

## Objetivo da aula

- Criar o projeto **JC Bank** a partir do Spring Initializr.
- Entender para que serve cada parte do projeto gerado.
- Rodar a aplicação localmente.
- Versionar o projeto no GitHub.

## Pré-requisitos

- **JDK 21** instalado (`java -version`).
- **Git** instalado e configurado (`user.name`, `user.email`).
- **Conta no GitHub** com autenticação configurada (SSH ou token).
- **IntelliJ IDEA** (ou outra IDE de sua preferência).

## Conteúdos estudados

### 1. O que é uma API

Uma **API** é a interface que permite que um sistema converse com outro.

No nosso caso, o cliente (navegador, Insomnia, Postman ou outro sistema) envia uma **requisição HTTP** e o servidor devolve uma **resposta**. Nesta fase **não haverá tela**: toda a comunicação será feita por requisições e respostas em **JSON**.

### 2. HTTP e JSON (visão geral)

- **Métodos HTTP**: `GET` (buscar), `POST` (criar), `PUT`/`PATCH` (atualizar), `DELETE` (remover).
- **Status HTTP**: `2xx` sucesso · `4xx` erro da requisição · `5xx` erro do servidor.
  - Exemplo: `404` significa que o recurso não foi encontrado.
- **JSON**: formato de texto com pares `chave: valor`, usado para enviar e receber dados.

### 3. Git e GitHub

- **Git**: controla o histórico do código na sua máquina.
- **GitHub**: hospeda o repositório na nuvem.
- **Fluxo básico**: `add` (seleciona) → `commit` (registra) → `push` (envia).
- **Boas mensagens de commit**: `feat:`, `fix:`, `docs:`, `chore:`, `test:`.

### 4. A stack do projeto

| Peça | Papel |
|---|---|
| **Kotlin** | Linguagem de programação. |
| **JVM** | Ambiente que executa o código Kotlin. |
| **Spring Boot** | Framework que cria o servidor e as rotas da API. |
| **Gradle** | Ferramenta de build: compila, baixa dependências e executa. |

### 5. Estrutura do projeto

| Arquivo / pasta | Para que serve |
|---|---|
| `build.gradle.kts` | Dependências e configurações do build. |
| `gradlew` / `gradle/wrapper/` | Garantem a mesma versão do Gradle para todo mundo. |
| `src/main` | Código da aplicação. |
| `src/test` | Testes automatizados. |
| `src/main/resources/application.properties` | Configurações da aplicação (porta, etc.). |
| `JcBankApplication.kt` | Ponto de entrada: onde a aplicação inicia. |
| `.gitignore` | Lista de arquivos que não devem ir para o Git. |

---

## Prática da semana

### Objetivo

Criar o **primeiro endpoint** da API e publicá-lo em uma branch com **Pull Request**.

### O que fazer

1. **Crie uma branch** a partir da `main`:
   ```bash
   git checkout -b feat/status-endpoint
   ```

2. **Crie um `StatusController`** com o endpoint `GET /api/v1/status`, retornando:
   ```json
   { "status": "UP", "service": "jc-bank" }
   ```
   Use uma **`data class`** para representar a resposta (não use `Map`).

3. **Rode e teste**:
   ```bash
   ./gradlew bootRun
   ```
   Acesse `http://localhost:8080/api/v1/status` no navegador ou em um cliente de API.

4. **Faça commits pequenos** com mensagens claras e abra um **Pull Request** para a `main`.

5. **No Pull Request, escreva um relatório** respondendo:
   - O que acontece se você mudar a porta do servidor? Mostre como rodar em outra porta.
   - Quebre algo de propósito (por exemplo, um erro de sintaxe) e conte o que você observou.
   - Para que serve o `build.gradle.kts`? O que o **Gradle Wrapper** resolve?

### Critérios de avaliação

| Critério | O que será observado |
|---|---|
| Funciona | `GET /api/v1/status` responde `200` com o JSON correto. |
| Código | `@RestController` e `@GetMapping` usados corretamente, no pacote certo, com retorno em `data class`. |
| Git | Branch `feat/status-endpoint`, commits pequenos e mensagens claras, PR com descrição. |
| Compreensão | Relatório com os experimentos, escrito com suas palavras. |

### Bônus (opcional)

- Documentar o novo endpoint no `README.md`.

---

## Dicas

- Leia a mensagem de erro com calma: ela costuma indicar o arquivo e a linha.
- Faça commits pequenos — fica mais fácil voltar atrás se algo der errado.
- Se travar em algo, anote a dúvida e traga para a próxima aula.
