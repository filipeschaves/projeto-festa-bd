--- Consulta 9: gastos de cada evento em relação ao orçamento (RN07)
--- Objetivo: somar aluguel do local, contratos de fornecedores e cachês de atrações de cada evento e comparar com o orçamento, mostrando o saldo e o percentual usado.
WITH gastos_fornecedores AS (
    SELECT id_evento, SUM(valor) AS total
    FROM contrata
    GROUP BY id_evento
),
gastos_atracoes AS (
    SELECT id_evento, SUM(cache) AS total
    FROM apresenta
    GROUP BY id_evento
),
custos AS (
    SELECT e.id_evento,
           e.nome,
           e.orcamento,
           lc.custo_aluguel,
           COALESCE(gf.total, 0) AS fornecedores,
           COALESCE(ga.total, 0) AS atracoes
    FROM evento e
    INNER JOIN local lc ON lc.id_local = e.id_local
    LEFT JOIN gastos_fornecedores gf ON gf.id_evento = e.id_evento
    LEFT JOIN gastos_atracoes ga ON ga.id_evento = e.id_evento
)
SELECT nome AS evento,
       orcamento,
       custo_aluguel,
       fornecedores,
       atracoes,
       custo_aluguel + fornecedores + atracoes                      AS gasto_total,
       orcamento - (custo_aluguel + fornecedores + atracoes)        AS saldo,
       ROUND(100.0 * (custo_aluguel + fornecedores + atracoes) / orcamento, 1)
                                                                    AS pct_do_orcamento
FROM custos
ORDER BY pct_do_orcamento DESC;