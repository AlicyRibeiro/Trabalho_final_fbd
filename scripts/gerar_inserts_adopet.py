from faker import Faker
import random
from datetime import datetime, timedelta

# Configura o Faker para o Brasil
fake = Faker('pt_BR')
Faker.seed(2026)
random.seed(2026)

NUM_REGISTROS = 130
ARQUIVO_SAIDA = 'inserts_adopet.sql'

# Dados customizados para regionalizar a aplicação
cidades_ce = ['Quixadá', 'Fortaleza', 'Sobral', 'Juazeiro do Norte', 'Quixeramobim', 'Iguatu', 'Crato', 'Baturité']
bairros_ce = ['Centro', 'Campo Novo', 'Baviera', 'Planalto Universitário', 'Aldeota', 'Benfica', 'Meireles', 'Combate']
ruas_ce = ['Av. Plácido Castelo', 'Rua José de Alencar', 'Av. Bezerra de Menezes', 'Rua 13 de Maio', 'Av. Washington Soares', 'Rua Tenente Cravo']
nomes_abrigos = ['Abrigo São Lázaro', 'SOS Patas', 'Refúgio Animal', 'Lar dos Focinhos', 'Instituto Protege', 'Patas Solidárias', 'Acolhe Bicho', 'Arca de Noé', 'Cão Feliz', 'Amor em Patas']

def str_sql(texto):
    """Escapa aspas simples do PostgreSQL e retorna com aspas para o comando SQL"""
    if texto is None:
        return "NULL"
    return f"'{str(texto).replace(chr(39), chr(39)+chr(39))}'"

def data_aleatoria(ano_inicio=2024, ano_fim=2026):
    inicio = datetime(ano_inicio, 1, 1)
    fim = datetime(ano_fim, 12, 31)
    return inicio + timedelta(days=random.randint(0, (fim - inicio).days))

with open(ARQUIVO_SAIDA, 'w', encoding='utf-8') as f:
    f.write("-- SCRIPT DML: INSERÇÃO DE DADOS (POSTGRESQL)\n\n")

    # 1. TABELAS FORTES
    f.write("-- 1. Tabela Animal\n")
    for i in range(1, NUM_REGISTROS + 1):
        nome = fake.first_name()
        especie = random.choice(['Canino', 'Felino'])
        raca = 'SRD' if random.random() > 0.4 else fake.word().capitalize()
        sexo = random.choice(['M', 'F'])
        idade = random.randint(1, 12)
        porte = random.choice(['Pequeno', 'Médio', 'Grande'])
        caracteristicas = f"Animal de pelagem {random.choice(['curta', 'longa, escura', 'clara'])}."
        situacao = random.choice(['Em Abrigo', 'Adotado', 'Em Tratamento', 'Disponível'])
        
        f.write(f"INSERT INTO Animal (id_animal, nome, especie, raca, sexo, idade_aproximada, porte, caracteristicas, situacao_atual) "
                f"VALUES ({i}, {str_sql(nome)}, {str_sql(especie)}, {str_sql(raca)}, {str_sql(sexo)}, {idade}, {str_sql(porte)}, {str_sql(caracteristicas)}, {str_sql(situacao)});\n")

    f.write("\n-- 2. Tabela Responsavel\n")
    for i in range(1, NUM_REGISTROS + 1):
        f.write(f"INSERT INTO Responsavel (id_responsavel, cpf, nome, email) "
                f"VALUES ({i}, {str_sql(fake.cpf())}, {str_sql(fake.name())}, {str_sql(fake.email())});\n")

    f.write("\n-- 3. Tabela Abrigo\n")
    for i in range(1, NUM_REGISTROS + 1):
        nome_abrigo = f"{random.choice(nomes_abrigos)} - Unidade {i}"
        f.write(f"INSERT INTO Abrigo (id_abrigo, nome, rua, numero, bairro, cidade, capacidade, email) "
                f"VALUES ({i}, {str_sql(nome_abrigo)}, {str_sql(random.choice(ruas_ce))}, {random.randint(10, 1500)}, "
                f"{str_sql(random.choice(bairros_ce))}, {str_sql(random.choice(cidades_ce))}, {random.randint(30, 150)}, {str_sql(fake.company_email())});\n")

    f.write("\n-- 4. Tabela Veterinario\n")
    for i in range(1, NUM_REGISTROS + 1):
        f.write(f"INSERT INTO Veterinario (id_veterinario, crmv, nome, email) "
                f"VALUES ({i}, {str_sql(str(random.randint(1000, 99999)) + '-CE')}, {str_sql(fake.name())}, {str_sql(fake.email())});\n")

    f.write("\n-- 5. Tabela Adotante\n")
    for i in range(1, NUM_REGISTROS + 1):
        f.write(f"INSERT INTO Adotante (id_adotante, cpf, nome, rua, numero, bairro, cidade, cep, email) "
                f"VALUES ({i}, {str_sql(fake.cpf())}, {str_sql(fake.name())}, {str_sql(random.choice(ruas_ce))}, "
                f"{random.randint(1, 2000)}, {str_sql(random.choice(bairros_ce))}, {str_sql(random.choice(cidades_ce))}, {str_sql(fake.postcode())}, {str_sql(fake.email())});\n")

    # 2. TABELAS MULTIVALORADAS (TELEFONES)
    f.write("\n-- TABELAS MULTIVALORADAS\n")
    for tabela, fk in [('Telefone_Responsavel', 'id_responsavel'), ('Telefone_Abrigo', 'id_abrigo'), 
                       ('Telefone_Veterinario', 'id_veterinario'), ('Telefone_Adotante', 'id_adotante')]:
        f.write(f"\n-- {tabela}\n")
        for i in range(1, NUM_REGISTROS + 1):
            f.write(f"INSERT INTO {tabela} ({fk}, numero) VALUES ({i}, {str_sql(fake.cellphone_number())});\n")

    # 3. TABELAS DE RELACIONAMENTO (CHAVES ESTRANGEIRAS)
    f.write("\n-- TABELAS DE RELACIONAMENTOS\n")

    f.write("\n-- 6. Tabela Resgate\n")
    situacoes_resgate = ['Maus tratos', 'Abandono em via pública', 'Fuga', 'Atropelamento']
    for i in range(1, NUM_REGISTROS + 1):
        data = data_aleatoria(2024, 2025).strftime('%Y-%m-%d')
        f.write(f"INSERT INTO Resgate (id_resgate, data_resgate, local_resgate, situacao_encontrada, id_animal, id_responsavel) "
                f"VALUES ({i}, '{data}', {str_sql(random.choice(ruas_ce))}, {str_sql(random.choice(situacoes_resgate))}, {random.randint(1, NUM_REGISTROS)}, {random.randint(1, NUM_REGISTROS)});\n")

    f.write("\n-- 7. Tabela Permanencia_Abrigo\n")
    for i in range(1, NUM_REGISTROS + 1):
        data_ent = data_aleatoria(2025, 2025)
        data_sai = data_ent + timedelta(days=random.randint(5, 90))
        f.write(f"INSERT INTO Permanencia_Abrigo (id_permanencia, data_entrada, data_saida, id_animal, id_abrigo) "
                f"VALUES ({i}, '{data_ent.strftime('%Y-%m-%d')}', '{data_sai.strftime('%Y-%m-%d')}', {random.randint(1, NUM_REGISTROS)}, {random.randint(1, NUM_REGISTROS)});\n")

    f.write("\n-- 8. Tabela Atendimento_Veterinario\n")
    procedimentos = ['Consulta de Triagem', 'Vacinação Antirrábica', 'Castração', 'Curativo']
    for i in range(1, NUM_REGISTROS + 1):
        data = data_aleatoria(2025, 2026).strftime('%Y-%m-%d')
        f.write(f"INSERT INTO Atendimento_Veterinario (id_atendimento, data_atendimento, procedimento, diagnostico, observacoes, id_animal, id_veterinario) "
                f"VALUES ({i}, '{data}', {str_sql(random.choice(procedimentos))}, 'Diagnóstico Clínico', 'Sem complicações', {random.randint(1, NUM_REGISTROS)}, {random.randint(1, NUM_REGISTROS)});\n")

    f.write("\n-- 9. Tabela Adocao\n")
    for i in range(1, NUM_REGISTROS + 1):
        data = data_aleatoria(2025, 2026).strftime('%Y-%m-%d')
        f.write(f"INSERT INTO Adocao (id_adocao, data_adocao, observacoes, id_animal, id_adotante) "
                f"VALUES ({i}, '{data}', 'Contrato assinado em via física.', {random.randint(1, NUM_REGISTROS)}, {random.randint(1, NUM_REGISTROS)});\n")

    f.write("\n-- 10. Tabela Devolucao\n")
    motivos = ['Alergia na família', 'Mudança de imóvel', 'Incompatibilidade com outro animal', 'Problemas financeiros']
    for i in range(1, NUM_REGISTROS + 1):
        data = data_aleatoria(2026, 2026).strftime('%Y-%m-%d')
        # A relação é 1:1, então cada devolução se liga exatamente a uma adoção gerada
        f.write(f"INSERT INTO Devolucao (id_devolucao, data_devolucao, motivo, situacao_pos_retorno, id_adocao) "
                f"VALUES ({i}, '{data}', {str_sql(random.choice(motivos))}, 'Reintegrado ao abrigo', {i});\n")

print(f"Arquivo '{ARQUIVO_SAIDA}' criado com sucesso com 130 registros por tabela.")