/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.bean;

import com.controler.Produto;
import com.model.ProdutoDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author pablo
 */
public class ServletCadastrarProduto extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
    System.out.println(">>> ServletCadastrarProduto foi chamada");

    String idUsuarioParam = request.getParameter("idUsuario");
    String nomeProduto = request.getParameter("nome");
    String quantidadeParam = request.getParameter("quantidade");
    String precoParam = request.getParameter("preco");
    String categoriaParam = request.getParameter("categoria");

    System.out.println("idUsuarioParam: " + idUsuarioParam);
System.out.println("nomeProduto: " + nomeProduto);
System.out.println("quantidadeParam: " + quantidadeParam);
System.out.println("precoParam: " + precoParam);
System.out.println("categoriaParam: " + categoriaParam);

    
    // Validação de campos obrigatórios
    if (idUsuarioParam == null || idUsuarioParam.isEmpty() ||
        nomeProduto == null || nomeProduto.isEmpty() ||
        quantidadeParam == null || quantidadeParam.isEmpty() ||
        precoParam == null || precoParam.isEmpty() ||
        categoriaParam == null || categoriaParam.isEmpty()) {

        System.out.println(">>> Campos obrigatórios não preenchidos.");
        request.setAttribute("erro", "Todos os campos são obrigatórios.");
        request.getRequestDispatcher("index.jsp").forward(request, response);
        return;
    }

    try {
        int idUsuario = Integer.parseInt(idUsuarioParam);
        int quantidade = Integer.parseInt(quantidadeParam);
        double preco = Double.parseDouble(precoParam.replace(".", "").replace(",", "."));
        int categoriaId = Integer.parseInt(categoriaParam);

        // Log para depuração
        System.out.println("ID do usuário: " + idUsuario);
        System.out.println("Nome do produto: " + nomeProduto);
        System.out.println("Quantidade: " + quantidade);
        System.out.println("Preço: " + preco);
        System.out.println("Categoria ID: " + categoriaId);

        // Criação e inserção do produto
        Produto produto = new Produto();
        produto.setIdUsuario(idUsuario);
        produto.setNome(nomeProduto);
        produto.setQuantidade(quantidade);
        produto.setPreco(preco);
        produto.setCategoriaId(categoriaId);

        ProdutoDAO produtoDAO = new ProdutoDAO();
        produtoDAO.inserir(produto);

        System.out.println(">>> Redirecionando para index.jsp após inserção");
        request.setAttribute("sucesso", "Produto cadastrado com sucesso!");
        request.getRequestDispatcher("index.jsp").forward(request, response);

    } catch (NumberFormatException e) {
        System.err.println("Erro ao converter número: " + e.getMessage());
        request.setAttribute("erro", "Erro nos dados numéricos. Verifique os campos e tente novamente.");
        request.getRequestDispatcher("index.jsp").forward(request, response);

    } catch (Exception e) {
        System.err.println("Erro ao cadastrar produto: " + e.getMessage());
        e.printStackTrace();
        request.setAttribute("erro", "Erro ao cadastrar produto: " + e.getMessage());
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

} catch (IOException e) {
    e.printStackTrace();
    throw new ServletException("Erro ao processar requisição: " + e.getMessage());
}

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
