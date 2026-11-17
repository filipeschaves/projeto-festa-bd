--- Consulta 4: vendas do bar por evento e produto
--- Objetivo: mostrar quantas unidades de cada produto foram vendidas em cada evento e o faturamento, considerando só produtos com 5 ou mais unidades vendidas.
--- O caminho percorrido é consome -> ingresso -> lote -> evento (o evento da venda é descoberto pelo ingresso).
SELECT e.nome AS evento,
        p.nome AS produto,
        SUM(c.quantidade) AS unidades_vendidas,
        SUM(c.quantidade * p.preco) AS faturamento
FROM consome c
INNER JOIN ingresso i ON i.id_ingresso = c.id_ingresso
INNER JOIN lote l ON l.id_lote = i.id_lote
INNER JOIN evento e ON e.id_evento = l.id_evento
INNER JOIN produto_bar p ON p.id_produto  = c.id_produto
GROUP BY e.id_evento, e.nome, p.id_produto, p.nome
HAVING SUM(c.quantidade) >= 5
ORDER BY e.nome ASC, faturamento DESC;