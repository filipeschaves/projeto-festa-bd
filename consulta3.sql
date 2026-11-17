--- Consulta 3: atrações contratadas por evento
--- Objetivo: listar todos os eventos com a quantidade de atrações, o total de cachês e os nomes das atrações. Eventos sem atração aparecem com 0 e com
--- uma mensagem, em vez de sumirem do resultado.
SELECT e.nome AS evento,
        e.data_evento,
        COUNT(at.id_atracao) AS qtd_atracoes,
        COALESCE(SUM(a.cache), 0) AS total_caches,
        COALESCE(GROUP_CONCAT(at.nome, ', '),
            'nenhuma atração contratada') AS atracoes
FROM evento e
LEFT JOIN apresenta a ON a.id_evento = e.id_evento
LEFT JOIN atracao at ON at.id_atracao = a.id_atracao
GROUP BY e.id_evento, e.nome, e.data_evento
ORDER BY e.data_evento ASC;