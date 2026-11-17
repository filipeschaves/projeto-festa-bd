--- Consulta 2: política de preços e oferta de ingressos por evento
--- Mostra para cada evento, o menor, o maior e o preço médio dos lotes, quantos lotes existem, quantos ingressos foram ofertados no total e a
--- capacidade do local.
SELECT e.nome                    AS evento,
       e.data_evento,
       lc.capacidade,
       COUNT(l.id_lote)          AS lotes,
       MIN(l.preco)              AS menor_preco,
       MAX(l.preco)              AS maior_preco,
       ROUND(AVG(l.preco), 2)    AS preco_medio,
       SUM(l.quantidade)         AS ingressos_ofertados
FROM evento e
INNER JOIN local lc ON lc.id_local  = e.id_local
INNER JOIN lote l   ON l.id_evento  = e.id_evento
GROUP BY e.id_evento, e.nome, e.data_evento, lc.capacidade
ORDER BY e.data_evento ASC;