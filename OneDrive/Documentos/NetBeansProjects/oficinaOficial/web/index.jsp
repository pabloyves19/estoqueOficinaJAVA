<%-- 
    Document   : home
    Created on : 05/11/2020, 11:25:08
    Author     : Danilo Miranda
--%>

<%@page import="java.util.List"%>
<%@page import="com.controler.Categoria"%>
<%@page import="com.controler.Produto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.model.ProdutoDAO"%>
<%@page import="java.text.DecimalFormat"%>
'
<%
    boolean logado = session.getAttribute("email") == null ? false : true;
    String idUsuarioLogado = String.valueOf(session.getAttribute("id"));
%>


<!DOCTYPE html>
<html>
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">

        <!-- FontAwesome -->
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>

        <title>Estoque Oficina - Home </title>

        <style>
         html, body {
  height: 100%;
  margin: 0;
  padding: 0;
}

body { 
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  background: linear-gradient(135deg, #f7f9fc 0%, #eaeef3 100%);
  color: #2c3e50;
  margin: 0;
  padding: 0;
  
  /* Novo: layout flex para sticky footer */
  display: flex;
  flex-direction: column;
  min-height: 100vh;
}

/* Envolva todo o conteúdo da página dentro de .page-container no HTML */
.page-container {
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
}

/* Seu CSS navbar, tables, etc continuam iguais... */

/* Footer atualizado: remove position sticky, usa margin-top auto */
footer {
  background-color: #db4b23;
  color: white;
  text-align: center;
  padding: 15px 20px;
  font-weight: 600;
  font-size: 0.9rem;
  border-top-left-radius: 16px;
  border-top-right-radius: 16px;
  box-shadow: 0 -4px 15px rgba(219, 75, 35, 0.6);

  /* Flexbox sticky footer */
  margin-top: auto;
  width: 100%;
  z-index: 10;
}

footer a {
  color: #fff9f6;
  text-decoration: underline;
  transition: color 0.3s ease;
}

footer a:hover {
  color: #ffe5db;
  text-decoration: none;
}

</style>

        </style>
    </head>

    <body>
        <div class="page-container">
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container">
                <a class="navbar-brand" href="login.jsp">
                    <i class="far fa-newspaper fa-2x"></i>
                </a>

                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                    <ul class="navbar-nav ml-auto mt-2 mt-lg-0">
                        <li class="nav-item active">
                            <% if (logado) {%>
                            <a class="nav-link" href="ServletDeslogar">Sair</a>
                            <%} else {%>
                            <a class="nav-link" href="login.jsp">Entrar</a>
                            <%} %>
                        </li>
                    </ul>
                </div> 
            </div>
        </nav>

        <div class="container vh-100">
            <% if (logado) {%>
            <div class="mt-5 mb-4 d-flex flex-column">

                <p class="alert alert-success" role="alert"> Bem vindo!  <strong><%=session.getAttribute("email")%></strong></p>

                <a href="#" data-toggle="modal" data-target="#modalCadastrar"  class="btn btn-primary ml-auto">Cadastrar novo Produto</a><br>
                <a href="#" data-toggle="modal" data-target="#modalCadastrarCategoria"  class="btn btn-primary ml-auto">Cadastrar nova Categoria</a>
            </div>
            <% } else {%>


            <div class="my-4">
                <div class="alert alert-danger" role="alert">
                    Autentique-se para gerenciar seus produtos !
                </div>

            </div>
            <% }%>


            <table class="table table-striped">
                <thead>
                    <tr>
                       <th scope="col">Produto <i class="fas fa-rss"></i></th>
        <th scope="col">Categoria <i class="fas fa-tags"></i></th> <!-- NOVO -->
        <th scope="col" class="text-center">Valor <i class="fas fa-hand-holding-usd"></i></th>
        <th scope="col" class="text-center">Data <i class="far fa-calendar-alt"></i></th>
        <th scope="col" class="text-center">Editar <i class="fas fa-edit"></i></th>
                    </tr>
                </thead>

                <%
                    ProdutoDAO produtoDAO = new ProdutoDAO();
                    Produto produto = new Produto();

                    ArrayList<Produto> listaProdutos = produtoDAO.pesquisarTudo();
                    DecimalFormat df = new DecimalFormat("#,##0.00");

                    for (int i = 0; i < listaProdutos.size(); i++) {
                        produto = listaProdutos.get(i);
                %>

               <tr>
    <td class="align-middle"><%= produto.getNome() %></td>
    <td class="align-middle"><%= produto.getCategoria().getNome() %></td> <!-- nova coluna -->
    <td class="text-center align-middle"><%= df.format(produto.getPreco()) %></td>
    <td class="text-center align-middle"><%= produto.getCriadoEm() %></td>

    <td class="text-center align-middle">
        <% if (String.valueOf(produto.getIdUsuario()).equals(idUsuarioLogado)) { %>
           <a href="#" class="btn btn-light"
              onclick='abrirModalEditar({
                  codigo: <%= produto.getCodigo() %>,
                  nome: "<%= produto.getNome() %>",
                  preco: "<%= produto.getPreco() %>",
                  quantidade: <%= produto.getQuantidade() %>
              })'
              data-toggle="tooltip" data-placement="top" title="Editar">
               <i class="fas fa-pen-nib"></i>
           </a>

           <a href="ServletDeletarProduto?codigo=<%= produto.getCodigo() %>"
              onclick="return confirm('Tem certeza que deseja apagar esse produto? Esta ação não poderá ser desfeita.')"
              class="btn btn-outline-danger"
              data-toggle="tooltip" data-placement="top" title="Apagar">
               <i class="fas fa-trash-alt"></i>
           </a>
        <% } else { %>
           <a href="#" class="btn btn-light"
              data-toggle="tooltip" data-placement="top" title="Bloqueado">
               <i class="fas fa-ban"></i>
           </a>
        <% } %>
    </td>
</tr>



                <%}
                %>
            </table>
            
            <%-- Tabela Categorias --%>
<h3 class="mt-5 mb-3">Categorias</h3>
<table class="table table-striped">
    <thead>
        <tr>
            <th scope="col">Categoria <i class="fas fa-tags"></i></th>
            <th scope="col" class="text-center">Editar <i class="fas fa-edit"></i></th>
        </tr>
    </thead>

    <%
        // Instancia o DAO das categorias e busca as categorias do usuário logado
        com.model.CategoriaDAO categoriaDAO = new com.model.CategoriaDAO();
        List<Categoria> listaCategorias = categoriaDAO.pesquisarTudo(); // Ajuste esse método para buscar as categorias do usuário se precisar

        for (Categoria categoria : listaCategorias) {
    %>

   <tr>
    <td class="align-middle"><%= categoria.getNome() %></td>
    <td class="text-center align-middle">
        <!-- Removido o if que dava erro -->
        <a href="#" class="btn btn-light"
           onclick='abrirModalEditarCategoria({
               id: <%= categoria.getId() %>,
               nome: "<%= categoria.getNome() %>"
           })'
           data-toggle="tooltip" data-placement="top" title="Editar">
            <i class="fas fa-pen-nib"></i>
        </a>

        <a href="ServletDeletarCategoria?id=<%= categoria.getId() %>"
           onclick="return confirm('Tem certeza que deseja apagar essa categoria? Esta ação não poderá ser desfeita.')"
           class="btn btn-outline-danger"
           data-toggle="tooltip" data-placement="top" title="Apagar">
            <i class="fas fa-trash-alt"></i>
        </a>
    </td>
</tr>


    <% } %>
</table>
            
        </div>


      <!-- Modal Editar -->
<div class="modal fade" id="modalEditar" tabindex="-1" role="dialog" aria-labelledby="modalEditar" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header bg-light" style="border-bottom: none;">
                <h5 class="modal-title" id="exampleModalLongTitle">
                    <i class="fas fa-cube mr-2"></i>Editar produto
                </h5>

                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>

            <div class="modal-body">
                <form method="POST" action="ServletEditarProduto">
                    <div class="form-group mt-3">
                        <label for="nome">Nome do Produto</label>
                        <input class="form-control" type="text" name="nome" id="editarNome" />
                    </div>

                    <div class="form-group mt-3">
                        <label for="preco">Preço</label>
                        <input class="form-control" type="text" name="preco" id="editarPreco" />
                    </div>

                    <div class="form-group mt-3">
                        <label for="quantidade">Quantidade</label>
                        <input class="form-control" type="number" name="quantidade" id="editarQuantidade" />
                    </div>
                    
                    <div class="form-group mt-3">
    <label for="categoria">Categoria</label>
    <select class="form-control" name="categoria" id="editarCategoria">
        <!-- Essas opções devem ser carregadas dinamicamente -->
        <option value="">Selecione</option>
        <option value="1">Categoria 1</option>
        <option value="2">Categoria 2</option>
        <!-- ... -->
    </select>
</div>


                    <input type="hidden" name="codigo" id="editarCodigo" />

                    <div class="form-group mt-5 d-flex justify-content-end">
                        <a href="#" class="btn-close text-dark mr-3 mt-2" data-dismiss="modal">
                            Fechar
                        </a>
                        <button type="submit" class="btn btn-light">Salvar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>



     <!-- Modal Cadastrar -->
<div class="modal fade" id="modalCadastrar" tabindex="-1" role="dialog" aria-labelledby="modalCadastrar" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header bg-light" style="border-bottom: none;">
                <h5 class="modal-title" id="exampleModalLongTitle">
                    <i class="fas fa-cube mr-2"></i>Cadastrar Novo Produto
                </h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>

            <div class="modal-body">
                <form method="POST" action="ServletCadastrarProduto">
                    
                    <% 
                        Object idSessao = session.getAttribute("id");
                        if (idSessao != null) {
                    %>
                        <input type="hidden" value="<%= idSessao.toString() %>" name="idUsuario">
                    <% 
                        } else {
                    %>
                        <div class="alert alert-danger">
                            Sessão expirada! Faça login novamente.
                        </div>
                    <% 
                        } 
                    %>

                    <div class="form-group mt-3">
                        <label for="nome">Produto</label>
                        <textarea class="form-control" name="nome" rows="1" id="nome"></textarea>
                    </div>

<div class="form-group mt-3">
    <label for="categoria_id">Categoria</label>
    <select class="form-control" name="categoria" id="categoria">
    <option value="">Selecione uma categoria</option>
    <%
        List<Categoria> categorias = (List<Categoria>) request.getAttribute("categorias");
        if (categorias != null) {
            for (Categoria cat : categorias) {
    %>
        <option value="<%= cat.getId() %>"><%= cat.getNome() %></option>
    <%
            }
        }
    %>
</select>

</div>


                    <div class="form-group mt-3">
                        <label for="quantidade">Quantidade</label>
                        <input class="form-control" type="number" name="quantidade" id="quantidade" min="0" value="0" />
                    </div>

                    <div class="form-group mt-3">
                        <label for="preco">Valor</label>
                        <input class="form-control" type="text" name="preco" id="preco">
                    </div>

                    <div class="form-group mt-5 d-flex justify-content-end">
                        <a href="#" class="btn-close text-dark mr-3 mt-2" data-dismiss="modal">
                            Fechar
                        </a>
                        <button type="submit" class="btn btn-light">Cadastrar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

                        
                        <!-- Modal Cadastrar Categoria -->
<div class="modal fade" id="modalCadastrarCategoria" tabindex="-1" role="dialog" aria-labelledby="modalCadastrarCategoria" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header bg-light" style="border-bottom: none;">
                <h5 class="modal-title">
                    <i class="fas fa-tags mr-2"></i>Cadastrar Nova Categoria
                </h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>

            <div class="modal-body">
                <form method="POST" action="ServletCadastrarCategoria">
                    <div>
                        <input type="hidden" value="<%= session.getAttribute("id") %>" name="idUsuario">
                    </div>

                    <div class="form-group mt-3">
                        <label for="nomeCategoria">Nome da Categoria</label>
                        <input class="form-control" type="text" name="nome" id="nomeCategoria" required>
                    </div>

                    <div class="form-group mt-5 d-flex justify-content-end">
                        <a href="#" class="btn-close text-dark mr-3 mt-2" data-dismiss="modal">
                            Fechar
                        </a>
                        <button type="submit" class="btn btn-light">Cadastrar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
                    <!-- Modal Editar Categoria -->
<div class="modal fade" id="modalEditarCategoria" tabindex="-1" role="dialog" aria-labelledby="modalEditarCategoriaLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header bg-light" style="border-bottom: none;">
                <h5 class="modal-title" id="modalEditarCategoriaLabel">
                    <i class="fas fa-tags mr-2"></i>Editar Categoria
                </h5>

                <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>

            <div class="modal-body">
                <form method="POST" action="ServletEditarCategoria">
                    <div class="form-group mt-3">
                        <label for="editarNomeCategoria">Nome da Categoria</label>
                        <input class="form-control" type="text" name="nome" id="editarNomeCategoria" required />
                    </div>

                    <input type="hidden" name="id" id="editarIdCategoria" />

                    <div class="form-group mt-5 d-flex justify-content-end">
                        <a href="#" class="btn-close text-dark mr-3 mt-2" data-dismiss="modal">
                            Fechar
                        </a>
                        <button type="submit" class="btn btn-light">Salvar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
   
</div>

    </div>
    </body>

    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

    <!-- jQuery Mask -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.min.js" integrity="sha512-pHVGpX7F/27yZ0ISY+VVjyULApbDlD0/X0rgGbTqCE7WFW5MezNTWG/dnhtbBuICzsd0WQPgpE4REBLv+UqChw==" crossorigin="anonymous"></script>

    <script>
                               function abrirModalEditar(produto) {
        document.getElementById('editarCodigo').value = produto.codigo;
        document.getElementById('editarNome').value = produto.nome;
        document.getElementById('editarPreco').value = produto.preco;
        document.getElementById('editarQuantidade').value = produto.quantidade;

        $('#modalEditar').modal('show');
    }
    function abrirModalEditarCategoria(categoria) {
    document.getElementById('editarIdCategoria').value = categoria.id;
    document.getElementById('editarNomeCategoria').value = categoria.nome;

    $('#modalEditarCategoria').modal('show');
    
    function preencherModalEditar(produto) {
    document.getElementById("editarNome").value = produto.nome;
    document.getElementById("editarPreco").value = produto.preco;
    document.getElementById("editarQuantidade").value = produto.quantidade;
    document.getElementById("editarCodigo").value = produto.codigo;
    document.getElementById("editarCategoria").value = produto.categoriaId; // NOVO
}

}



    </script>
 
</html>
