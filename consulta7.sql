--- Consulta 7: equipe escalada na Festa a Fantasia
--- Objetivo: listar os trabalhadores (organização e equipe do local) que têm turno na Festa a Fantasia, ordenados por vínculo, setor e nome.
SELECT t.nome, t.setor, t.vinculo
FROM trabalhador t
WHERE t.id_trabalhador IN (SELECT tu.id_trabalhador
                            FROM turno tu
                            INNER JOIN evento e ON e.id_evento = tu.id_evento
                            WHERE e.nome = 'Festa a Fantasia'
                            AND tu.id_trabalhador IS NOT NULL)
ORDER BY t.vinculo ASC, t.setor ASC, t.nome ASC;