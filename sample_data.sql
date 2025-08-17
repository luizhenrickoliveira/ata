-- sample_data.sql - Dados de exemplo para PetShop
USE petshop;

-- clientes
INSERT INTO clientes (nome, email, telefone, endereco) VALUES
('João Silva', 'joao@example.com', '41999990000', 'Rua A, 123'),
('Maria Souza', 'maria@example.com', '41988880000', 'Av B, 456');

-- funcionarios
INSERT INTO funcionarios (nome, cargo, telefone, data_admissao) VALUES
('Ana Pereira','Atendente','41977770000','2023-02-10'),
('Carlos Mendes','Veterinário','41966660000','2022-08-01');

-- fornecedores
INSERT INTO fornecedores (nome, contato, telefone) VALUES
('PetFoods LTDA','contato@petfoods.com','41955550000');

-- categorias
INSERT INTO categorias_produto (nome, descricao) VALUES
('Rações','Rações para cães e gatos'),
('Acessórios','Brinquedos, coleiras, etc');

-- produtos
INSERT INTO produtos (nome, descricao, preco, estoque, fornecedor_id, categoria_id) VALUES
('Ração Cães Adultos 10kg','Ração completa', 159.90, 20, 1, 1),
('Coleira Retrátil','Coleira 3m', 49.90, 50, 1, 2);

-- pets
INSERT INTO pets (nome, especie, raca, data_nascimento, cliente_id) VALUES
('Bolt','Cão','SRD','2019-05-01',1),
('Luna','Gato','Siamês','2021-09-12',2);

-- servicos
INSERT INTO servicos (descricao, duracao_min, preco) VALUES
('Banho e Tosa', 90, 89.90),
('Consulta Veterinária', 45, 120.00);

-- agendamentos
INSERT INTO agendamentos (data_horario, pet_id, servico_id, funcionario_id, status) VALUES
('2025-08-20 10:00:00', 1, 1, 1, 'agendado'),
('2025-08-21 14:00:00', 2, 2, 2, 'agendado');

-- vendas
INSERT INTO vendas (cliente_id, total, forma_pagamento, funcionario_id) VALUES
(1, 159.90, 'cartao', 1);

-- venda_itens
INSERT INTO venda_itens (venda_id, produto_id, quantidade, preco_unit) VALUES
(1, 1, 1, 159.90);
