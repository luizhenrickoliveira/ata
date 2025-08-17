-- queries.sql - Consultas para PetShop
USE petshop;

-- 1) Listar pets com dono
SELECT p.id AS pet_id, p.nome AS pet, p.especie, p.raca, c.id AS cliente_id, c.nome AS dono
FROM pets p
JOIN clientes c ON p.cliente_id = c.id;

-- 2) Próximos agendamentos
SELECT a.id, a.data_horario, s.descricao AS servico, p.nome AS pet, c.nome AS dono, a.status
FROM agendamentos a
JOIN servicos s ON a.servico_id = s.id
JOIN pets p ON a.pet_id = p.id
JOIN clientes c ON p.cliente_id = c.id
WHERE a.data_horario >= NOW()
ORDER BY a.data_horario;

-- 3) Total vendido por dia
SELECT DATE(v.data_venda) AS dia, SUM(v.total) AS total_vendido
FROM vendas v
GROUP BY DATE(v.data_venda)
ORDER BY dia DESC;

-- 4) Top 5 produtos mais vendidos
SELECT pr.id, pr.nome, SUM(vi.quantidade) AS qtd_vendida
FROM venda_itens vi
JOIN produtos pr ON vi.produto_id = pr.id
GROUP BY pr.id
ORDER BY qtd_vendida DESC
LIMIT 5;

-- 5) Histórico de compras de um cliente
SELECT v.id AS venda_id, v.data_venda, pr.nome AS produto, vi.quantidade, vi.preco_unit
FROM vendas v
JOIN venda_itens vi ON v.id = vi.venda_id
JOIN produtos pr ON vi.produto_id = pr.id
WHERE v.cliente_id = 1
ORDER BY v.data_venda DESC;

-- 6) Inserir venda (transação)
START TRANSACTION;
INSERT INTO vendas (cliente_id, total, forma_pagamento, funcionario_id) VALUES (2, 149.80, 'dinheiro', 1);
SET @v_id = LAST_INSERT_ID();
INSERT INTO venda_itens (venda_id, produto_id, quantidade, preco_unit) VALUES (@v_id, 2, 3, 49.90);
COMMIT;

-- 7) Atualizar status de agendamento
UPDATE agendamentos SET status = 'concluido' WHERE id = 1;

-- 8) Produtos com pouco estoque
SELECT id, nome, estoque FROM produtos WHERE estoque < 10 ORDER BY estoque ASC;

-- 9) Receita estimada por serviço
SELECT s.id, s.descricao, COUNT(a.id) AS atendimentos_realizados, (COUNT(a.id) * s.preco) AS receita_estimativa
FROM servicos s
LEFT JOIN agendamentos a ON a.servico_id = s.id AND a.status = 'concluido'
GROUP BY s.id;

-- 10) View vendas detalhadas
CREATE OR REPLACE VIEW vw_vendas_detalhes AS
SELECT v.id, v.data_venda, c.nome AS cliente, SUM(vi.quantidade * vi.preco_unit) AS total_calc
FROM vendas v
LEFT JOIN clientes c ON v.cliente_id = c.id
LEFT JOIN venda_itens vi ON vi.venda_id = v.id
GROUP BY v.id;
