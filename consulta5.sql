--- Consulta 5: ingressos pagantes comprados em lotes mais caros que a média
--- Pra saber quais clientes compraram ingressos de lotes com preço acima do média de preço de todos os lotes cadastrados. 
SELECT cl.nome AS cliente,
    e.nome AS evento,
    l.id_lote,
    l.preco,
    i.data_compra
FROM ingresso i
INNER JOIN cliente cl ON cl.id_cliente = i.id_cliente
INNER JOIN lote l ON l.id_lote = i.id_lote
INNER JOIN evento e ON e.id_evento = l.id_evento
WHERE i.tipo = 'pagante'
  AND l.preco > (SELECT AVG(preco) FROM lote)
ORDER BY l.preco DESC, cl.nome ASC;