--- Consulta 1: ingressos vendidos e receita por lote
--- Para cada lote que já vendeu pelo menos 3 ingressos, mostrar o evento, preço do lote, quantos ingressos foram vendidos, quantos estão sem check-in
--- (ausentes ou festa ainda não realizada) e a receita (cortesia não gera receita).
SELECT e.nome                                              AS evento,
       l.id_lote,
       l.preco,
       COUNT(i.id_ingresso)                                AS ingressos_vendidos,
       SUM(CASE WHEN i.check_in IS NULL THEN 1 ELSE 0 END) AS sem_check_in,
       SUM(CASE WHEN i.tipo = 'pagante' THEN l.preco ELSE 0 END) AS receita
FROM evento e
INNER JOIN lote l    ON l.id_evento = e.id_evento
INNER JOIN ingresso i ON i.id_lote  = l.id_lote
GROUP BY e.nome, l.id_lote, l.preco
HAVING COUNT(i.id_ingresso) >= 3
ORDER BY receita DESC;
