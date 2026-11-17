PRAGMA foreign_keys = ON;
 
INSERT INTO local (id_local, endereco, capacidade, custo_aluguel) VALUES
  (1, 'Viva Clube, SC-401, 1000 - Florianópolis/SC', 500, 6000.00),
  (2, 'Arena Days, SC-281, 250 - São José/SC',    300, 3500.00),
  (3, 'Claudison Square Garden, Avenida das Rendeiras, 355 - Florianópolis/SC', 200, 2000.00);

INSERT INTO cliente (id_cliente, nome, cpf, data_nasc) VALUES
  ( 1, 'Ana Beatriz Piauí', '101.201.301-01', '2002-03-14'),
  ( 2, 'Bruno Lima Costa', '102.202.302-02', '2001-07-22'),
  ( 3, 'Carolina Mendes', '103.203.303-03', '2003-11-05'),
  ( 4, 'Daniel Ferreira', '104.204.304-04', '2000-01-30'),
  ( 5, 'Eduarda Rocha', '105.205.305-05', '2004-09-18'),
  ( 6, 'Felipe de Lins Andrade', '106.206.306-06', '2002-12-02'),
  ( 7, 'Gabriela Sá Nunes', '107.207.307-07', '2005-04-27'),
  ( 8, 'Henrique Stark', '108.208.308-08', '2003-06-09'),
  ( 9, 'Isabela Martins', '109.209.309-09', '2001-10-11'),
  (10, 'João Elias dos Anjos', '110.210.310-10', '2004-02-19'),
  (11, 'Karina Nunes Teixeira', '111.211.311-11', '2002-08-08'),
  (12, 'Leonardo Pires Koerich', '112.212.312-12', '2000-05-25'),
  (13, 'Maria Jucá Cardoso', '113.213.313-13', '2003-03-03'),
  (14, 'Nicolas Barros', '114.214.314-14', '2005-01-16'),
  (15, 'Olívia Ribeiro', '115.215.315-15', '2004-07-07'),
  (16, 'Paulo Henrique Gomes', '116.216.316-16', '2001-09-29'),
  (17, 'Quézia Moreira', '117.217.317-17', '2006-05-12'),
  (18, 'Rafael Siqueira', '118.218.318-18', '2002-06-21'),
  (19, 'Sabrina Azevedo','119.219.319-19', '2005-11-30'),
  (20, 'Thiago Neves Nascimento', '120.220.320-20', '2008-12-10');

INSERT INTO fornecedor (id_fornecedor, nome, cnpj, categoria) VALUES
  (1, 'Distribuidora Sulito', '11.111.111/0001-01', 'bebidas'),
  (2, 'Cervejaria Cervs',  '22.222.222/0001-02', 'bebidas'),
  (3, 'Ponte de Luz Eventos', '33.333.333/0001-03', 'equipamentos'),
  (4, 'Flops Festas', '44.444.444/0001-04', 'decoração'),
  (5, 'Locatplan', '55.555.555/0001-05', 'equipamentos');

INSERT INTO atracao (id_atracao, nome) VALUES
  (1, 'DJ Cida'),
  (2, 'Banda Rage Against the Machine Learning'),
  (3, 'DJ Aisha'),
  (4, 'Bateria Datacida'),
  (5, 'DJ Cidoca');

INSERT INTO trabalhador (id_trabalhador, nome, setor, vinculo) VALUES
  ( 1, 'Lucas Prado', 'bar', 'organizacao'),
  ( 2, 'Marina Dias', 'bar', 'organizacao'),
  ( 3, 'Pedro Michel Vieira', 'bar', 'organizacao'),
  ( 4, 'Ana Clara Lopes', 'bastidores', 'organizacao'),
  ( 5, 'Rodrigo Santos', 'marketing', 'organizacao'),
  ( 6, 'Carla Menezes Reus', 'fornecedores', 'organizacao'),
  ( 7, 'Rafael Viana Borges', 'orcamento', 'organizacao'),
  ( 8, 'João Batista Albuquerque', 'limpeza', 'local'),
  ( 9, 'Beatriz Azeredo', 'limpeza', 'local'),
  (10, 'Tiago Cusco Lima', 'limpeza', 'local'),
  (11, 'Sofia Leal Brasil', 'portaria', 'local'),
  (12, 'Henrique Matos', 'portaria', 'local'),
  (13, 'João Paulo Cacupé', 'portaria', 'local');

INSERT INTO evento (id_evento, nome, data_evento, hora_evento, data_venda, orcamento, id_local) VALUES
  (1, 'Arraiá Universitário', '2026-06-13', '22:00', '2026-04-20', 20000.00, 1),
  (2, 'Festa a Fantasia', '2026-12-05', '21:00', '2026-10-15', 30000.00, 1),
  (3, 'Calourada', '2027-03-20', '20:00', '2027-02-01', 12000.00, 2);

INSERT INTO lote (id_lote, preco, quantidade, data_inicio, data_fim, id_evento) VALUES
  (1, 20.00,  60, '2026-04-20', '2026-05-10', 1),
  (2, 30.00,  80, '2026-05-11', '2026-06-01', 1),
  (3, 40.00,  60, '2026-06-02', '2026-06-13', 1),
  (4, 25.00, 100, '2026-10-15', '2026-11-05', 2),
  (5, 35.00, 150, '2026-11-06', '2026-11-25', 2),
  (6, 45.00, 150, '2026-11-26', '2026-12-05', 2),
  (7, 20.00, 120, '2027-02-01', '2027-02-28', 3),
  (8, 30.00, 130, '2027-03-01', '2027-03-20', 3);

INSERT INTO produto_bar (id_produto, nome, preco, quantidade, id_fornecedor) VALUES
  (1, 'Cerveja em lata 350ml', 6.00, 800, 1),
  (2, 'Água mineral 500ml', 4.00, 500, 1),
  (3, 'Refrigerante em lata', 5.00, 400, 1),
  (4, 'Chopp 500ml',14.00, 300, 2),
  (5, 'Caipirinha', 16.00, 150, 2),
  (6, 'Energético em lata', 12.00, 120, 2);

INSERT INTO contrata (id_evento, id_fornecedor, valor, data_inicio, data_fim) VALUES
  (1, 1, 3500.00, '2026-06-13 14:00', '2026-06-13 20:00'),
  (1, 2, 2000.00, '2026-06-13 15:00', '2026-06-13 20:30'),
  (1, 3, 2500.00, '2026-06-13 12:00', '2026-06-13 20:00'),
  (1, 4, 1500.00, '2026-06-14 05:00', '2026-06-14 09:00'),
  (2, 1, 5000.00, '2026-12-05 15:00', '2026-12-05 20:00'),
  (2, 2, 3000.00, '2026-12-05 16:00', '2026-12-05 20:30'),
  (2, 3, 4500.00, '2026-12-05 12:00', '2026-12-05 20:00'),
  (2, 4, 2500.00, '2026-12-06 04:00', '2026-12-06 08:00'),
  (3, 1, 2000.00, '2027-03-20 12:00', '2027-03-20 18:00');

INSERT INTO apresenta (id_evento, id_atracao, cache, contrato) VALUES
  (1, 2, 1800.00, 'CT-2026-001'),
  (1, 3, 1200.00, 'CT-2026-002'),
  (2, 1, 3500.00, 'CT-2026-010'),
  (2, 2, 3000.00, 'CT-2026-011'),
  (2, 3, 1500.00, 'CT-2026-012');

INSERT INTO organiza (id_evento, id_trabalhador) VALUES
  (1, 1), (1, 2), (1, 4), (1, 5), (1, 6), (1, 7),
  (2, 1), (2, 3), (2, 4), (2, 5), (2, 6), (2, 7),
  (3, 4), (3, 5), (3, 6), (3, 7);

INSERT INTO ingresso (id_ingresso, tipo, data_compra, check_in, id_cliente, id_lote) VALUES
  ( 1, 'pagante',  '2026-04-22', NULL, 1, 1),
  ( 2, 'pagante',  '2026-04-25', NULL, 2, 1),
  ( 3, 'pagante',  '2026-05-02', NULL, 3, 1),
  ( 4, 'pagante',  '2026-05-08', NULL, 4, 1),
  ( 5, 'cortesia', '2026-04-21', NULL, 5, 1),
  ( 6, 'pagante',  '2026-05-15', NULL, 6, 2),
  ( 7, 'pagante',  '2026-05-20', NULL, 7, 2),
  ( 8, 'pagante',  '2026-05-28', NULL, 8, 2),
  ( 9, 'pagante',  '2026-05-30', NULL, 9, 2),
  (10, 'cortesia', '2026-05-12', NULL, 10, 2),
  (11, 'pagante',  '2026-06-03', NULL, 11, 3),
  (12, 'pagante',  '2026-06-08', NULL, 12, 3),
  (13, 'pagante',  '2026-06-10', NULL, 13, 3),
  (14, 'pagante',  '2026-06-12', NULL, 14, 3),
  (15, 'pagante',  '2026-10-16', NULL, 1, 4),
  (16, 'pagante',  '2026-10-20', NULL, 2, 4),
  (17, 'pagante',  '2026-10-25', NULL, 3, 4),
  (18, 'pagante',  '2026-11-01', NULL, 15, 4),
  (19, 'pagante',  '2026-11-04', NULL, 16, 4),
  (20, 'pagante',  '2026-11-07', NULL, 6, 5),
  (21, 'pagante',  '2026-11-10', NULL, 7, 5),
  (22, 'pagante',  '2026-11-12', NULL, 17, 5),
  (23, 'cortesia', '2026-11-08', NULL, 18, 5),
  (24, 'pagante',  '2026-11-14', NULL,  8, 5),
  (25, 'pagante',  '2026-11-15', NULL, 19, 5);

UPDATE ingresso SET check_in = '2026-06-13 22:10' WHERE id_ingresso = 1;
UPDATE ingresso SET check_in = '2026-06-13 22:25' WHERE id_ingresso = 2;
UPDATE ingresso SET check_in = '2026-06-13 22:40' WHERE id_ingresso = 3;
UPDATE ingresso SET check_in = '2026-06-13 22:15' WHERE id_ingresso = 5;
UPDATE ingresso SET check_in = '2026-06-13 22:30' WHERE id_ingresso = 6;
UPDATE ingresso SET check_in = '2026-06-13 22:50' WHERE id_ingresso = 7;
UPDATE ingresso SET check_in = '2026-06-13 23:05' WHERE id_ingresso = 8;
UPDATE ingresso SET check_in = '2026-06-13 22:20' WHERE id_ingresso = 10;
UPDATE ingresso SET check_in = '2026-06-13 23:10' WHERE id_ingresso = 11;
UPDATE ingresso SET check_in = '2026-06-13 23:30' WHERE id_ingresso = 12;
UPDATE ingresso SET check_in = '2026-06-13 23:45' WHERE id_ingresso = 14;

INSERT INTO turno (id_turno, inicio, fim, id_evento, id_trabalhador, id_atracao) VALUES
  ( 1, '2026-06-13 22:00', '2026-06-14 00:00', 1, 1, NULL),
  ( 2, '2026-06-13 22:00', '2026-06-14 00:00', 1, 2, NULL),
  ( 3, '2026-06-14 00:00', '2026-06-14 02:00', 1, 3, NULL),
  ( 4, '2026-06-14 02:00', '2026-06-14 04:00', 1, 1, NULL),
  ( 5, '2026-06-13 22:00', '2026-06-14 00:00', 1, NULL, 2),
  ( 6, '2026-06-14 00:00', '2026-06-14 02:00', 1, NULL, 3),
  ( 7, '2026-06-13 22:00', '2026-06-14 01:00', 1, 10, NULL),
  ( 8, '2026-06-14 01:00', '2026-06-14 04:00', 1, 8, NULL),
  ( 9, '2026-06-13 21:30', '2026-06-14 01:00', 1, 11, NULL),
  (10, '2026-06-14 01:00', '2026-06-14 04:00', 1, 12, NULL);

INSERT INTO turno (id_turno, inicio, fim, id_evento, id_trabalhador, id_atracao) VALUES
  (11, '2026-12-05 21:00', '2026-12-05 23:00', 2, 1, NULL),
  (12, '2026-12-05 21:00', '2026-12-05 23:00', 2, 2, NULL),
  (13, '2026-12-05 23:00', '2026-12-06 01:00', 2, 3, NULL),
  (14, '2026-12-05 23:00', '2026-12-06 01:00', 2, 2, NULL),
  (15, '2026-12-06 01:00', '2026-12-06 03:00', 2, 1, NULL),
  (16, '2026-12-06 01:00', '2026-12-06 03:00', 2, 3, NULL),
  (17, '2026-12-05 21:00', '2026-12-05 23:00', 2, NULL, 1),
  (18, '2026-12-05 23:00', '2026-12-06 01:00', 2, NULL, 2),
  (19, '2026-12-06 01:00', '2026-12-06 03:00', 2, NULL, 3),
  (20, '2026-12-05 21:00', '2026-12-06 00:00', 2, 8, NULL),
  (21, '2026-12-06 00:00', '2026-12-06 03:00', 2, 9, NULL),
  (22, '2026-12-05 20:30', '2026-12-06 00:30', 2, 11, NULL),
  (23, '2026-12-06 00:30', '2026-12-06 03:00', 2, 12, NULL);

INSERT INTO consome (id_ingresso, id_produto, data_hora, quantidade) VALUES
  ( 1, 1, '2026-06-13 22:45', 2),
  ( 1, 4, '2026-06-14 00:10', 1),
  ( 2, 1, '2026-06-13 23:00', 3),
  ( 2, 5, '2026-06-14 01:00', 2),
  ( 3, 2, '2026-06-13 23:10', 1),
  ( 3, 1, '2026-06-14 00:30', 2),
  ( 5, 3, '2026-06-13 23:00', 2),
  ( 6, 4, '2026-06-13 23:30', 2),
  ( 6, 5, '2026-06-14 01:30', 1),
  ( 7, 1, '2026-06-14 00:00', 4),
  ( 8, 6, '2026-06-14 00:40', 1),
  ( 8, 4, '2026-06-14 02:00', 2),
  (10, 2, '2026-06-13 22:50', 2),
  (11, 1, '2026-06-14 00:20', 3),
  (11, 5, '2026-06-14 01:45', 2),
  (12, 1, '2026-06-14 01:00', 2),
  (14, 4, '2026-06-14 01:15', 3),
  (14, 3, '2026-06-14 02:30', 1);