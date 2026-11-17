--- Consulta 6: eventos com cortesias e conferência do limite de 8% (RN02)
--- Objetivo: listar os eventos que emitiram pelo menos uma cortesia, mostrando quantas foram emitidas e qual é o limite permitido (8% do total de ingressos).
SELECT e.nome AS evento,
        e.data_evento,
        (SELECT COUNT(*)
          FROM lote l2
          INNER JOIN ingresso i2 ON i2.id_lote = l2.id_lote
        WHERE l2.id_evento = e.id_evento AND i2.tipo = 'cortesia') AS cortesias_emitidas,
        (SELECT SUM(l3.quantidade) FROM lote l3
        WHERE l3.id_evento = e.id_evento) * 0.08 AS limite_8_porcento
FROM evento e
WHERE EXISTS (SELECT 1
                FROM lote l
                INNER JOIN ingresso i ON i.id_lote = l.id_lote
                WHERE l.id_evento = e.id_evento
                AND i.tipo = 'cortesia')
ORDER BY e.data_evento DESC;