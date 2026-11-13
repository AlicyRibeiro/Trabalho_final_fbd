
# Sistema de Adoção e Acompanhamento de Animais 🐾

Projeto final desenvolvido para a disciplina de Fundamentos de Banco de Dados (QXD0011) do curso de Engenharia de Computação da Universidade Federal do Ceará (UFC) - Campus Quixadá.

##  Sobre o Projeto
É um sistema relacional modelado para auxiliar organizações e abrigos na gestão de animais resgatados no estado do Ceará. O banco de dados garante a rastreabilidade completa do histórico do animal, registrando desde o seu resgate, passagem por abrigos temporários, atendimentos veterinários, até o processo de adoção e eventuais devoluções.

## Tecnologias Utilizadas
* **SGBD:** PostgreSQL (Modelagem, DDL, DML e DQL)
* **Linguagem Auxiliar:** Python (Uso da biblioteca `Faker` para geração de massa de dados simulada e coerente com a região do Ceará)
* **Ferramentas:** pgAdmin 4, psql (CLI), Git/GitHub

##  Estrutura do Repositório
* `/sql`: Contém os scripts SQL sequenciais para criação do esquema (DDL), popularização de dados (DML - 130 registros por tabela) e consultas avançadas (DQL - JOINs e Subconsultas).
* `/scripts`: Contém o script Python utilizado para automação e popularização massiva do banco.
* `/docs`: Relatórios de modelagem e implementação do projeto.

##  Como Executar
1. Clone o repositório:
   ```
   git clone [https://github.com/AlicyRibeiro/Trabalho_final_fbd.git](https://github.com/AlicyRibeiro/Trabalho_final_fbd.git)
   ```

2. Acesse o PostgreSQL via pgAdmin ou terminal (`psql`).
3. Crie o banco de dados: `CREATE DATABASE acolhepet;`
4. Execute os scripts da pasta `/sql` na ordem numérica (DDL -> DML -> DQL).

##  Equipe

* Ana Alicy 
* Andressa Pereira 
* Kaylane Castro 
* Rafaela Gomes 
* Riquellne Ferreira 
