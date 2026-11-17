--- Consulta 10: transações no bar com COMMIT, ROLLBACK e SAVEPOINT
--- Objetivo: demonstrar o controle de transações em três situações:
---   (1) uma venda é confirmada (COMMIT), mas um reajuste de preços feito em seguida é desfeito até um SAVEPOINT (ROLLBACK TO);
---   (2) um ajuste de estoque é testado e desfeito até um SAVEPOINT, e a transação termina com COMMIT;
---   (3) uma exclusão acidental de vendas é totalmente desfeita (ROLLBACK).

-- Transação 1
BEGIN TRANSACTION;

INSERT INTO consome (id_ingresso, id_produto, data_hora, quantidade)
SELECT 12, 3, '2026-06-14 03:00', 2
WHERE NOT EXISTS (
    SELECT 1
    FROM consome
    WHERE id_ingresso = 12
      AND id_produto = 3
      AND data_hora = '2026-06-14 03:00'
);

SAVEPOINT sp_reajuste;
UPDATE produto_bar SET preco = ROUND(preco * 1.10, 2);
SELECT id_produto, nome, preco AS preco_reajustado FROM produto_bar ORDER BY id_produto;

ROLLBACK TO sp_reajuste;
SELECT id_produto, nome, preco AS preco_apos_rollback FROM produto_bar ORDER BY id_produto;

RELEASE sp_reajuste;
COMMIT;

-- Transação 2
BEGIN TRANSACTION;

SAVEPOINT sp_estoque;
UPDATE produto_bar SET quantidade = quantidade + 100 WHERE id_produto = 1;
SELECT nome, quantidade AS estoque_com_ajuste FROM produto_bar WHERE id_produto = 1;

ROLLBACK TO sp_estoque;
SELECT nome, quantidade AS estoque_apos_rollback FROM produto_bar WHERE id_produto = 1;

RELEASE sp_estoque;
COMMIT;

-- Transação 3
BEGIN TRANSACTION;

DELETE FROM consome WHERE id_ingresso = 14;
SELECT COUNT(*) AS vendas_do_ingresso_14_apos_delete FROM consome WHERE id_ingresso = 14;

ROLLBACK;
SELECT COUNT(*) AS vendas_do_ingresso_14_apos_rollback FROM consome WHERE id_ingresso = 14;