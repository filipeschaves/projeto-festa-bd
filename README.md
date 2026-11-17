# Gestão de Festa Universitária

Projeto desenvolvido para a disciplina de Banco de Dados e Aplicações I, com o objetivo de modelar e implementar um banco de dados relacional para o gerenciamento de festas universitárias.

## 1. Descrição do projeto

O sistema foi desenvolvido para organizar e controlar as principais atividades relacionadas à realização de eventos universitários, incluindo a gestão de locais, eventos, clientes, ingressos, lotes, fornecedores, atrações, trabalhadores, turnos e produtos comercializados no bar.

A implementação utiliza SQLite, com restrições de integridade, chaves estrangeiras e gatilhos (*triggers*) para garantir o cumprimento das regras de negócio.

## 2. Cenário e funcionalidades

O banco de dados contempla:

- Cadastro e gerenciamento de eventos e locais.
- Controle de clientes e emissão de ingressos.
- Organização de lotes, preços e quantidades de ingressos.
- Gerenciamento de fornecedores e contratos.
- Registro de atrações contratadas por evento.
- Organização de trabalhadores e escalas de turnos.
- Controle de produtos, estoque e vendas do bar.
- Controle de check-in dos participantes.
- Verificação de regras de negócio por meio de restrições e triggers.

## 3. Estrutura do banco de dados

O modelo contempla 14 tabelas:

**Entidades principais:**
- EVENTO
- LOCAL
- CLIENTE
- INGRESSO
- LOTE
- FORNECEDOR
- TURNO
- ATRACAO
- TRABALHADOR
- PRODUTO_BAR

**Tabelas associativas:**
- CONTRATA
- APRESENTA
- ORGANIZA
- CONSOME

O modelo conceitual e a estrutura relacional estão documentados nos arquivos correspondentes.

## 4. Regras de negócio

A implementação contempla 15 regras de negócio relacionadas, entre outros aspectos, à emissão de ingressos, limite de cortesias, classificação etária, capacidade dos locais, orçamento dos eventos, contratação de fornecedores, duração dos eventos, check-in, vendas do bar, controle de estoque e organização dos turnos.

Essas regras são implementadas por meio de restrições (`CHECK`, `UNIQUE` e `FOREIGN KEY`) e gatilhos (`TRIGGER`).

## 5. Arquivos entregues

| Arquivo | Descrição |
|---|---|
| `DDL.sql` | Criação das tabelas, restrições e triggers do banco de dados. |
| `DML.sql` | Inserção dos dados utilizados no projeto. |
| `Consulta 1.sql` a `Consulta 10.sql` | Consultas SQL desenvolvidas para demonstrar as funcionalidades do banco. |
| `db_festa.db` | Banco de dados SQLite com a estrutura e os dados do projeto. |
| `MER` | Modelo Entidade-Relacionamento do sistema. |
| Documento de requisitos | Documentação do cenário, stakeholders, entidades, regras de negócio e esquema relacional. |

## 6. Tecnologias utilizadas

- **SQLite:** sistema gerenciador de banco de dados.
- **DB Browser for SQLite:** ferramenta utilizada para criação, execução e consulta do banco de dados.
- **SQL:** linguagem utilizada para definição, manipulação e consulta dos dados.

## 7. Como executar

1. Abra o DB Browser for SQLite.
2. Abra o arquivo `db_festa.db`.
3. Acesse a aba **Executar SQL**.
4. Execute as consultas SQL disponibilizadas nos arquivos individuais.
5. Para recriar o banco de dados do zero, execute primeiro o arquivo `DDL.sql` e, em seguida, o `DML.sql`, em um banco vazio.

## 8. Consultas SQL

O projeto apresenta 10 consultas que demonstram diferentes recursos da linguagem SQL, incluindo:

- Junções (`INNER JOIN` e `LEFT JOIN`).
- Funções de agregação (`COUNT`, `SUM`, `AVG`, `MIN` e `MAX`).
- Agrupamentos (`GROUP BY` e `HAVING`).
- Subconsultas (`IN` e `EXISTS`).
- Expressões de tabela comuns (`CTE`).
- Tratamento de valores nulos (`NULL`).
- Ordenação (`ORDER BY`).
- Controle de transações (`COMMIT`, `ROLLBACK` e `SAVEPOINT`).

## 9. Considerações finais

O projeto integra modelagem conceitual, lógica e física de banco de dados, aplicando conceitos de integridade referencial, regras de negócio, manipulação de dados, consultas e controle de transações em um cenário de organização de festas universitárias.
