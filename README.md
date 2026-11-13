
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

---

### 3. Comandos para Enviar ao GitHub
Abra o seu terminal Linux na pasta `~/banco de dados/projeto final` e execute a sequência de comandos abaixo para inicializar o repositório, salvar os arquivos e enviá-los para a nuvem:


#### 1. Inicializa o repositório Git na pasta (caso ainda não tenha feito)
```
git init
```

#### 2. Adiciona todos os arquivos e pastas organizadas

```
git add .
```

#### 3. Cria o commit com uma mensagem clara
```
git commit -m "feat: estrutura inicial do banco AdoPet com scripts DDL, DML, DQL e documentação"
```


#### 4. Muda o nome da branch principal para main (padrão do GitHub)
```
git branch -M main
```

#### 5. Conecta sua pasta local ao seu repositório remoto
```
git remote add origin https://github.com/AlicyRibeiro/Trabalho_final_fbd.git
```

#### 6. Envia os arquivos para o GitHub
```
git push -u origin main
```

> Se der algum aviso de "remote origin already exists" no passo 5, significa que você já conectou antes. Nesse caso, pule o passo 5 e vá direto para o 6.
