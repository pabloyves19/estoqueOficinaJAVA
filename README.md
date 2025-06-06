Sistema de Gerenciamento de Estoque de Oficina

![Java](https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=java&logoColor=white)
![Servlet](https://img.shields.io/badge/Java%20Servlets-007396?style=for-the-badge&logo=java&logoColor=white)
![JSP](https://img.shields.io/badge/JSP-blue?style=for-the-badge)
![MySQL](https://img.shields.io/badge/MySQL-00758F?style=for-the-badge&logo=mysql&logoColor=white)
![Bootstrap](https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white)
![PDF Generator](https://img.shields.io/badge/PDF-iText-red?style=for-the-badge)

Sistema web completo para controle de estoque de oficina mecânica. Com cadastro de produtos, movimentações de entrada/saída, histórico e relatórios em PDF.

🔧 Tecnologias Utilizadas

- Java (Servlets + JSP)
- HTML5 + CSS3
- Bootstrap 5 (layout responsivo)
- MySQL
- JDBC
- Apache Tomcat
- iText (geração de PDFs)

📚 Funcionalidades

- Cadastro, edição e exclusão de produtos
- Login, cadastro de login
- Registro de entradas e saídas
- Histórico de movimentações
- Consulta de saldo por produto
- Categorias de produtos (opcional)
- Trigger no MySQL para atualização automática
- Geração de relatórios por tipo
- Exportação em PDF

📄 Relatórios em PDF

Geração de relatórios automáticos com filtros e exportação:

- Apenas entradas ou apenas saídas
- Exportação em formato PDF (iText)

🚀 Como Executar o Projeto
1. Clone o repositório
bash
Copiar código
git clone https://github.com/seu-usuario/estoque-oficina.git
2. Abra no NetBeans
Abra o NetBeans IDE

Vá em File > Open Project

Selecione a pasta do projeto clonado

O NetBeans deve identificar como um projeto Web Application

3. Configure o Banco de Dados
Acesse seu MySQL (via Workbench, phpMyAdmin ou terminal)

Crie o banco de dados:

sql
Copiar código
Execute o script database.sql (se houver) para criar as tabelas e triggers

4. Atualize os dados de conexão
No arquivo ConnectionFactory.java, atualize com seus dados do MySQL:

java
Copiar código
private static final String URL = "jdbc:mysql://localhost:3306/estoque";
private static final String USER = "root";
private static final String PASS = "sua_senha";
5. Configure o Apache Tomcat no NetBeans
Vá em Tools > Servers

Adicione o Apache Tomcat

Aponte para a pasta de instalação

Configure a porta (normalmente 8080)

6. Execute o projeto
Clique com o botão direito no projeto > Run

O NetBeans irá compilar e abrir o navegador automaticamente

7. Acesse o sistema
bash
Copiar código
http://localhost:8080/nome-do-projeto
Substitua nome-do-projeto pelo nome real definido no web.xml ou na pasta do projeto.
