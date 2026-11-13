-- =========================================================================
-- 1- Retorna os nomes, espécies e raças da tabela Animal, listando apenas aqueles que estão disponíveis para adoção, ordenados alfabeticamente pelo nome. 
-- =========================================================================

SELECT nome, especie, raca, porte
FROM Animal
WHERE situacao_atual = 'Disponível'
ORDER BY nome ASC;


-- =========================================================================
-- 2 - Retorna os registros da tabela Permanencia_Abrigo onde os animais ainda se encontram no abrigo (ou seja, a data de saída ainda não foi preenchida). 
-- =========================================================================

SELECT an.nome AS nome_animal, ab.nome AS nome_abrigo, pa.data_entrada, pa.data_saida
FROM Permanencia_Abrigo pa, Animal an, Abrigo ab
WHERE pa.id_animal = an.id_animal
AND pa.id_abrigo = ab.id_abrigo
AND pa.data_saida IS NOT NULL;


-- =========================================================================
-- 3 - Filtra os registros da tabela Animal, retornando o nome, a espécie e a raça de todos os animais cujos nomes começam com a letra 'B'. 
-- =========================================================================

SELECT nome, especie, raca
FROM Animal
WHERE nome LIKE 'B%';

-- =========================================================================
-- 4 - Seleciona da tabela Resgate todos os resgates que aconteceram durante o primeiro semestre do ano de 2025. 
-- =========================================================================

SELECT id_resgate, data_resgate, situacao_encontrada
FROM Resgate
WHERE data_resgate BETWEEN '2025-01-01' AND '2025-06-30';


-- =========================================================================
-- 5 -Retorna uma lista consolidada e sem repetições de todas as espécies e suas respectivas raças cadastradas na tabela Animal.
-- =========================================================================

SELECT DISTINCT especie, raca
FROM Animal
ORDER BY especie, raca;

-- =========================================================================
-- 6 - Mostra o nome dos animais da tabela Animal juntamente com o procedimento e o diagnóstico recebido na tabela Atendimento_Veterinario. 
-- =========================================================================

SELECT Animal.nome, Atendimento_Veterinario.diagnostico, Atendimento_Veterinario.procedimento
FROM Animal, Atendimento_Veterinario
WHERE Animal.id_animal = Atendimento_Veterinario.id_animal;


-- =========================================================================
-- 7 - Retorna um relatório detalhado de resgates, cruzando a tabela Resgate, a tabela Animal e a tabela Responsavel para mostrar quando ocorreu, a situação, qual foi o animal e quem fez o resgate. 
-- =========================================================================

SELECT Resgate.data_resgate, Resgate.situacao_encontrada, Animal.nome AS nome_animal, Responsavel.nome AS nome_responsavel
FROM Resgate, Animal, Responsavel
WHERE Resgate.id_animal = Animal.id_animal 
AND Resgate.id_responsavel = Responsavel.id_responsavel;

-- =========================================================================
-- 8 - Retorna uma única linha contendo a capacidade máxima, mínima e a média geral de capacidade de todos os registros da tabela Abrigo. 
-- =========================================================================

SELECT MAX(capacidade) AS max_capacidade, MIN(capacidade) AS min_capacidade, AVG(capacidade) AS media_capacidade
FROM Abrigo;

-- =========================================================================
-- 9 - Retorna a contagem de resgates agrupada pelo tipo de situação (como 'Fuga', 'Maus tratos', etc.) presente na tabela Resgate.
-- =========================================================================

SELECT situacao_encontrada, COUNT(*) AS quantidade_resgates
FROM Resgate
GROUP BY situacao_encontrada;


-- =========================================================================
-- 10 - Conta os abrigos da tabela Abrigo agrupados por cidade, mas exibe apenas as cidades que possuem mais de 5 unidades. 
-- =========================================================================

SELECT cidade, COUNT(*) AS total_abrigos
FROM Abrigo
GROUP BY cidade
HAVING COUNT(*) > 5;

-- =========================================================================
-- 11 - Lista o nome e a raça dos animais na tabela Animal que realizaram procedimentos específicos (neste caso, "Castração") pesquisando essa informação através de uma subconsulta na tabela Atendimento_Veterinario. 
-- =========================================================================

SELECT nome, raca
FROM Animal
WHERE id_animal IN (
    SELECT id_animal 
    FROM Atendimento_Veterinario 
    WHERE procedimento = 'Castração'
);


-- =========================================================================
-- 12 - Retorna os nomes, cidades e as capacidades dos abrigos na tabela Abrigo que possuem uma capacidade superior à média de capacidade calculada de todos os abrigos do banco. 
-- =========================================================================

SELECT nome, capacidade, cidade
FROM Abrigo
WHERE capacidade > (
    SELECT AVG(capacidade) 
    FROM Abrigo
);

