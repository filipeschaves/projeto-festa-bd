PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS consome;
DROP TABLE IF EXISTS organiza;
DROP TABLE IF EXISTS apresenta;
DROP TABLE IF EXISTS contrata;
DROP TABLE IF EXISTS turno;
DROP TABLE IF EXISTS ingresso;
DROP TABLE IF EXISTS produto_bar;
DROP TABLE IF EXISTS lote;
DROP TABLE IF EXISTS evento;
DROP TABLE IF EXISTS trabalhador;
DROP TABLE IF EXISTS atracao;
DROP TABLE IF EXISTS fornecedor;
DROP TABLE IF EXISTS cliente;
DROP TABLE IF EXISTS local;

-- Criação das tabelas
CREATE TABLE local (
    id_local       INTEGER PRIMARY KEY,
    endereco       TEXT    NOT NULL,
    capacidade     INTEGER NOT NULL CHECK (capacidade > 0),
    custo_aluguel  REAL    NOT NULL CHECK (custo_aluguel >= 0)
);

CREATE TABLE cliente (
    id_cliente  INTEGER PRIMARY KEY,
    nome        TEXT NOT NULL,
    cpf         TEXT NOT NULL UNIQUE CHECK (length(cpf) = 14),
    data_nasc   TEXT NOT NULL
                CHECK (data_nasc GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]')
);

CREATE TABLE fornecedor (
    id_fornecedor  INTEGER PRIMARY KEY,
    nome           TEXT NOT NULL,
    cnpj           TEXT NOT NULL UNIQUE CHECK (length(cnpj) = 18),
    categoria      TEXT NOT NULL
                   CHECK (categoria IN ('bebidas', 'equipamentos', 'decoração'))
);

CREATE TABLE atracao (
    id_atracao  INTEGER PRIMARY KEY,
    nome        TEXT NOT NULL UNIQUE
);

CREATE TABLE trabalhador (
    id_trabalhador  INTEGER PRIMARY KEY,
    nome            TEXT NOT NULL,
    setor           TEXT NOT NULL
                    CHECK (setor IN ('bar', 'bastidores', 'marketing',
                                     'fornecedores', 'orcamento',
                                     'limpeza', 'portaria')),
    vinculo         TEXT NOT NULL
                    CHECK (vinculo IN ('organizacao', 'local')),
    CHECK ((vinculo = 'organizacao'
            AND setor IN ('bar', 'bastidores', 'marketing', 'fornecedores', 'orcamento'))
        OR (vinculo = 'local'
            AND setor IN ('limpeza', 'portaria')))
);

-- Aqui também cria a RN09 - Local sem outros eventos no dia da festa
CREATE TABLE evento (
    id_evento    INTEGER PRIMARY KEY,
    nome         TEXT NOT NULL,
    data_evento  TEXT NOT NULL
                 CHECK (data_evento GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'),
    hora_evento  TEXT NOT NULL DEFAULT '21:00'
                 CHECK (hora_evento GLOB '[0-2][0-9]:[0-5][0-9]'),
    data_venda   TEXT NOT NULL
                 CHECK (data_venda GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'),
    orcamento    REAL NOT NULL CHECK (orcamento > 0),
    id_local     INTEGER NOT NULL,
    CHECK (data_venda < data_evento),
    UNIQUE (id_local, data_evento),
    FOREIGN KEY (id_local) REFERENCES local (id_local)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE lote (
    id_lote      INTEGER PRIMARY KEY,
    preco        REAL    NOT NULL CHECK (preco > 0),
    quantidade   INTEGER NOT NULL CHECK (quantidade > 0),
    data_inicio  TEXT    NOT NULL,
    data_fim     TEXT    NOT NULL,
    id_evento    INTEGER NOT NULL,
    CHECK (data_fim >= data_inicio),
    FOREIGN KEY (id_evento) REFERENCES evento (id_evento)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE produto_bar (
    id_produto     INTEGER PRIMARY KEY,
    nome           TEXT    NOT NULL UNIQUE,
    preco          REAL    NOT NULL CHECK (preco > 0),
    quantidade     INTEGER NOT NULL DEFAULT 0 CHECK (quantidade >= 0),
    id_fornecedor  INTEGER NOT NULL,
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedor (id_fornecedor)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE ingresso (
    id_ingresso  INTEGER PRIMARY KEY,
    tipo         TEXT NOT NULL DEFAULT 'pagante'
                 CHECK (tipo IN ('pagante', 'cortesia')),
    data_compra  TEXT NOT NULL
                 CHECK (data_compra GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'),
    check_in     TEXT
                 CHECK (check_in IS NULL OR check_in GLOB
                   '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] [0-9][0-9]:[0-9][0-9]'),
    id_cliente   INTEGER NOT NULL,
    id_lote      INTEGER NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_lote) REFERENCES lote (id_lote)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE turno (
    id_turno        INTEGER PRIMARY KEY,
    inicio          TEXT NOT NULL
                    CHECK (inicio GLOB
                      '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] [0-9][0-9]:[0-9][0-9]'),
    fim             TEXT NOT NULL
                    CHECK (fim GLOB
                      '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] [0-9][0-9]:[0-9][0-9]'),
    id_evento       INTEGER NOT NULL,
    id_trabalhador  INTEGER,
    id_atracao      INTEGER,
    CHECK (datetime(inicio) < datetime(fim)),
    CHECK ((id_trabalhador IS NOT NULL AND id_atracao IS NULL)
        OR (id_trabalhador IS NULL AND id_atracao IS NOT NULL)),
    FOREIGN KEY (id_evento) REFERENCES evento (id_evento)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_trabalhador) REFERENCES trabalhador (id_trabalhador)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_atracao) REFERENCES atracao (id_atracao)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE contrata (
    id_evento      INTEGER NOT NULL,
    id_fornecedor  INTEGER NOT NULL,
    valor          REAL    NOT NULL CHECK (valor > 0),
    data_inicio    TEXT    NOT NULL
                   CHECK (data_inicio GLOB
                     '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] [0-9][0-9]:[0-9][0-9]'),
    data_fim       TEXT    NOT NULL
                   CHECK (data_fim GLOB
                     '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] [0-9][0-9]:[0-9][0-9]'),
    PRIMARY KEY (id_evento, id_fornecedor),
    CHECK (datetime(data_inicio) < datetime(data_fim)),
    FOREIGN KEY (id_evento) REFERENCES evento (id_evento)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_fornecedor) REFERENCES fornecedor (id_fornecedor)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE apresenta (
    id_evento   INTEGER NOT NULL,
    id_atracao  INTEGER NOT NULL,
    cache       REAL    NOT NULL CHECK (cache > 0),
    contrato    TEXT    NOT NULL,
    PRIMARY KEY (id_evento, id_atracao),
    FOREIGN KEY (id_evento) REFERENCES evento (id_evento)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_atracao) REFERENCES atracao (id_atracao)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE organiza (
    id_evento       INTEGER NOT NULL,
    id_trabalhador  INTEGER NOT NULL,
    PRIMARY KEY (id_evento, id_trabalhador),
    FOREIGN KEY (id_evento) REFERENCES evento (id_evento)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_trabalhador) REFERENCES trabalhador (id_trabalhador)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE consome (
    id_ingresso  INTEGER NOT NULL,
    id_produto   INTEGER NOT NULL,
    data_hora    TEXT    NOT NULL
                 CHECK (data_hora GLOB
                   '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] [0-9][0-9]:[0-9][0-9]'),
    quantidade   INTEGER NOT NULL CHECK (quantidade > 0),
    PRIMARY KEY (id_ingresso, id_produto, data_hora),
    FOREIGN KEY (id_ingresso) REFERENCES ingresso (id_ingresso)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_produto) REFERENCES produto_bar (id_produto)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Criação das regras de negócio
-- RN01 - Um ingresso por pessoa (por evento)
CREATE TRIGGER trg_rn01_um_ingresso_por_evento
BEFORE INSERT ON ingresso
WHEN EXISTS (
    SELECT 1
    FROM ingresso i
    JOIN lote li ON li.id_lote = i.id_lote
    WHERE i.id_cliente = NEW.id_cliente
      AND li.id_evento = (SELECT id_evento FROM lote WHERE id_lote = NEW.id_lote)
)
BEGIN
    SELECT RAISE(ABORT, 'RN01: o cliente já possui ingresso para este evento');
END;

-- RN02 - Cortesias não podem passar de 8% do total de ingressos
CREATE TRIGGER trg_rn02_limite_cortesias
BEFORE INSERT ON ingresso
WHEN NEW.tipo = 'cortesia'
 AND (SELECT COUNT(*) + 1
      FROM ingresso i
      JOIN lote li ON li.id_lote = i.id_lote
      WHERE i.tipo = 'cortesia'
        AND li.id_evento = (SELECT id_evento FROM lote WHERE id_lote = NEW.id_lote))
     > 0.08 * (SELECT SUM(quantidade)
               FROM lote
               WHERE id_evento = (SELECT id_evento FROM lote WHERE id_lote = NEW.id_lote))
BEGIN
    SELECT RAISE(ABORT, 'RN02: cortesias não podem passar de 8% do total de ingressos');
END;

-- RN03 - Só pode vender para maiores de 18 anos
CREATE TRIGGER trg_rn03_maior_de_18
BEFORE INSERT ON ingresso
WHEN (SELECT date(c.data_nasc, '+18 years')
      FROM cliente c WHERE c.id_cliente = NEW.id_cliente)
     > (SELECT e.data_evento
        FROM lote l JOIN evento e ON e.id_evento = l.id_evento
        WHERE l.id_lote = NEW.id_lote)
BEGIN
    SELECT RAISE(ABORT, 'RN03: venda permitida apenas para maiores de 18 anos');
END;

-- RN04 - Venda por lote, por quantidade e por data

CREATE TRIGGER trg_rn04_periodo_do_lote
BEFORE INSERT ON ingresso
WHEN NEW.data_compra < (SELECT data_inicio FROM lote WHERE id_lote = NEW.id_lote)
  OR NEW.data_compra > (SELECT data_fim    FROM lote WHERE id_lote = NEW.id_lote)
BEGIN
    SELECT RAISE(ABORT, 'RN04: compra fora do período de venda do lote');
END;

CREATE TRIGGER trg_rn04_quantidade_do_lote
BEFORE INSERT ON ingresso
WHEN (SELECT COUNT(*) FROM ingresso WHERE id_lote = NEW.id_lote)
     >= (SELECT quantidade FROM lote WHERE id_lote = NEW.id_lote)
BEGIN
    SELECT RAISE(ABORT, 'RN04: lote esgotado');
END;

CREATE TRIGGER trg_rn04_lote_dentro_da_venda
BEFORE INSERT ON lote
WHEN NEW.data_inicio < (SELECT data_venda  FROM evento WHERE id_evento = NEW.id_evento)
  OR NEW.data_fim    > (SELECT data_evento FROM evento WHERE id_evento = NEW.id_evento)
BEGIN
    SELECT RAISE(ABORT, 'RN04: período do lote fora da janela de vendas do evento');
END;

-- RN05 - O preço de cada lote aumenta em relação ao anterior
CREATE TRIGGER trg_rn05_preco_crescente
BEFORE INSERT ON lote
WHEN EXISTS (
    SELECT 1 FROM lote
    WHERE id_evento = NEW.id_evento
      AND data_inicio < NEW.data_inicio
      AND preco >= NEW.preco
)
BEGIN
    SELECT RAISE(ABORT, 'RN05: o preço do lote deve ser maior que o dos lotes anteriores');
END;

-- RN06 - A soma dos lotes é limitada pela capacidade do local
CREATE TRIGGER trg_rn06_capacidade_do_local
BEFORE INSERT ON lote
WHEN (SELECT COALESCE(SUM(quantidade), 0) FROM lote WHERE id_evento = NEW.id_evento)
     + NEW.quantidade
     > (SELECT lc.capacidade
        FROM evento e JOIN local lc ON lc.id_local = e.id_local
        WHERE e.id_evento = NEW.id_evento)
BEGIN
    SELECT RAISE(ABORT, 'RN06: soma dos lotes excede a capacidade do local');
END;

-- RN07 - A soma dos gastos não pode ultrapassar o orçamento
CREATE TRIGGER trg_rn07_orcamento_contrata
BEFORE INSERT ON contrata
WHEN (SELECT lc.custo_aluguel
      FROM evento e JOIN local lc ON lc.id_local = e.id_local
      WHERE e.id_evento = NEW.id_evento)
   + (SELECT COALESCE(SUM(valor), 0) FROM contrata  WHERE id_evento = NEW.id_evento)
   + (SELECT COALESCE(SUM(cache), 0) FROM apresenta WHERE id_evento = NEW.id_evento)
   + NEW.valor
   > (SELECT orcamento FROM evento WHERE id_evento = NEW.id_evento)
BEGIN
    SELECT RAISE(ABORT, 'RN07: gastos ultrapassam o orçamento do evento');
END;

CREATE TRIGGER trg_rn07_orcamento_apresenta
BEFORE INSERT ON apresenta
WHEN (SELECT lc.custo_aluguel
      FROM evento e JOIN local lc ON lc.id_local = e.id_local
      WHERE e.id_evento = NEW.id_evento)
   + (SELECT COALESCE(SUM(valor), 0) FROM contrata  WHERE id_evento = NEW.id_evento)
   + (SELECT COALESCE(SUM(cache), 0) FROM apresenta WHERE id_evento = NEW.id_evento)
   + NEW.cache
   > (SELECT orcamento FROM evento WHERE id_evento = NEW.id_evento)
BEGIN
    SELECT RAISE(ABORT, 'RN07: gastos ultrapassam o orçamento do evento');
END;

-- RN08 - Fornecedor só entrega com contrato
CREATE TRIGGER trg_rn08_fornecedor_contratado
BEFORE INSERT ON consome
WHEN NOT EXISTS (
    SELECT 1
    FROM contrata c
    WHERE c.id_fornecedor = (SELECT id_fornecedor FROM produto_bar
                             WHERE id_produto = NEW.id_produto)
      AND c.id_evento = (SELECT l.id_evento
                         FROM ingresso i JOIN lote l ON l.id_lote = i.id_lote
                         WHERE i.id_ingresso = NEW.id_ingresso)
)
BEGIN
    SELECT RAISE(ABORT, 'RN08: o fornecedor do produto não tem contrato com este evento');
END;

-- RN10 - A festa dura 6 horas: esse é o tempo que o cliente pode fazer as coisas que o ingresso permite (entrar e consumir);
CREATE TRIGGER trg_rn10_checkin_obrigatorio
BEFORE INSERT ON consome
WHEN (SELECT check_in FROM ingresso WHERE id_ingresso = NEW.id_ingresso) IS NULL
BEGIN
    SELECT RAISE(ABORT, 'RN10: o ingresso ainda não fez check-in');
END;

CREATE TRIGGER trg_rn10_consumo_nas_6h
BEFORE INSERT ON consome
WHEN datetime(NEW.data_hora) <
       (SELECT datetime(e.data_evento || ' ' || e.hora_evento)
        FROM ingresso i JOIN lote l ON l.id_lote = i.id_lote
                        JOIN evento e ON e.id_evento = l.id_evento
        WHERE i.id_ingresso = NEW.id_ingresso)
  OR datetime(NEW.data_hora) >
       (SELECT datetime(e.data_evento || ' ' || e.hora_evento, '+6 hours')
        FROM ingresso i JOIN lote l ON l.id_lote = i.id_lote
                        JOIN evento e ON e.id_evento = l.id_evento
        WHERE i.id_ingresso = NEW.id_ingresso)
BEGIN
    SELECT RAISE(ABORT, 'RN10: consumo fora das 6 horas de duração da festa');
END;

CREATE TRIGGER trg_rn10_checkin_nas_6h
BEFORE UPDATE OF check_in ON ingresso
WHEN NEW.check_in IS NOT NULL
 AND (datetime(NEW.check_in) <
        (SELECT datetime(e.data_evento || ' ' || e.hora_evento)
         FROM lote l JOIN evento e ON e.id_evento = l.id_evento
         WHERE l.id_lote = NEW.id_lote)
   OR datetime(NEW.check_in) >
        (SELECT datetime(e.data_evento || ' ' || e.hora_evento, '+6 hours')
         FROM lote l JOIN evento e ON e.id_evento = l.id_evento
         WHERE l.id_lote = NEW.id_lote))
BEGIN
    SELECT RAISE(ABORT, 'RN10: check-in fora das 6 horas de duração da festa');
END;

-- RN11 - Clientes só podem entrar uma vez por ingresso
CREATE TRIGGER trg_rn11_checkin_unico
BEFORE UPDATE OF check_in ON ingresso
WHEN OLD.check_in IS NOT NULL
BEGIN
    SELECT RAISE(ABORT, 'RN11: este ingresso já foi utilizado');
END;

-- RN12 - Fornecedores não atuam durante a festa: só antes e depois
CREATE TRIGGER trg_rn12_fornecedor_fora_da_festa
BEFORE INSERT ON contrata
WHEN datetime(NEW.data_inicio) <
       (SELECT datetime(e.data_evento || ' ' || e.hora_evento, '+6 hours')
        FROM evento e WHERE e.id_evento = NEW.id_evento)
 AND datetime(NEW.data_fim) >
       (SELECT datetime(e.data_evento || ' ' || e.hora_evento)
        FROM evento e WHERE e.id_evento = NEW.id_evento)
BEGIN
    SELECT RAISE(ABORT, 'RN12: fornecedor não pode atuar durante a festa');
END;

-- RN13 - Venda no bar só com estoque
CREATE TRIGGER trg_rn13_estoque
BEFORE INSERT ON consome
WHEN NEW.quantidade > (SELECT quantidade FROM produto_bar
                       WHERE id_produto = NEW.id_produto)
BEGIN
    SELECT RAISE(ABORT, 'RN13: estoque insuficiente para esta venda');
END;

CREATE TRIGGER trg_rn13_baixa_estoque
AFTER INSERT ON consome
BEGIN
    UPDATE produto_bar
       SET quantidade = quantidade - NEW.quantidade
     WHERE id_produto = NEW.id_produto;
END;

-- RN14 - Turnos de atrações e de bar têm 2h, sem sobreposição
CREATE TRIGGER trg_rn14_turno_2h
BEFORE INSERT ON turno
WHEN (NEW.id_atracao IS NOT NULL
      OR (SELECT setor FROM trabalhador WHERE id_trabalhador = NEW.id_trabalhador) = 'bar')
 AND (strftime('%s', NEW.fim) - strftime('%s', NEW.inicio)) <> 7200
BEGIN
    SELECT RAISE(ABORT, 'RN14: turnos de atração e de bar duram exatamente 2 horas');
END;

CREATE TRIGGER trg_rn14_sem_sobreposicao
BEFORE INSERT ON turno
WHEN EXISTS (
    SELECT 1
    FROM turno t
    WHERE ((NEW.id_trabalhador IS NOT NULL AND t.id_trabalhador = NEW.id_trabalhador)
        OR (NEW.id_atracao     IS NOT NULL AND t.id_atracao     = NEW.id_atracao))
      AND datetime(NEW.inicio) < datetime(t.fim)
      AND datetime(NEW.fim)    > datetime(t.inicio)
)
BEGIN
    SELECT RAISE(ABORT, 'RN14/RN15: turno sobreposto para o mesmo trabalhador ou atração');
END;

-- RN15 - Turnos de limpeza têm 3h
CREATE TRIGGER trg_rn15_turno_limpeza_3h
BEFORE INSERT ON turno
WHEN (SELECT setor FROM trabalhador WHERE id_trabalhador = NEW.id_trabalhador) = 'limpeza'
 AND (strftime('%s', NEW.fim) - strftime('%s', NEW.inicio)) <> 10800
BEGIN
    SELECT RAISE(ABORT, 'RN15: turnos de limpeza duram exatamente 3 horas');
END;

-- Impedir que trabalhadores locais organizem
CREATE TRIGGER trg_organiza_so_organizacao
BEFORE INSERT ON organiza
WHEN (SELECT vinculo FROM trabalhador WHERE id_trabalhador = NEW.id_trabalhador)
     <> 'organizacao'
BEGIN
    SELECT RAISE(ABORT, 'Apenas trabalhadores com vínculo de organização organizam eventos');
END;