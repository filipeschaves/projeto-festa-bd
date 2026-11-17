--- Consulta 8: carga de trabalho de cada trabalhador (inclui quem não tem turno)
--- Objetivo: mostrar quantos turnos e quantas horas cada trabalhador tem escaladas,em todos os eventos. Quem não tem nenhum turno aparece com 0 horas.
SELECT  t.nome,
        t.setor,
        t.vinculo,
        COUNT(tu.id_turno) AS turnos,
        COALESCE(SUM((strftime('%s', tu.fim) - strftime('%s', tu.inicio)) / 3600.0), 0)
                        AS horas_escaladas
FROM trabalhador t
LEFT JOIN turno tu ON tu.id_trabalhador = t.id_trabalhador
GROUP BY t.id_trabalhador, t.nome, t.setor, t.vinculo
ORDER BY horas_escaladas ASC, t.nome ASC;