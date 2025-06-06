package com.model;

import com.controler.Produto;
import com.controler.Categoria;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ProdutoDAO extends DAO {

    public void inserir(Produto produto) throws SQLException, Exception {
        String query = "INSERT INTO produtos(idUsuario, nome, quantidade, preco, criado_em, categoria_id) VALUES(?, ?, ?, ?, ?, ?)";

        abrirBanco();
        try (PreparedStatement pst = con.prepareStatement(query)) {
            pst.setInt(1, produto.getIdUsuario());
            pst.setString(2, produto.getNome());
            pst.setInt(3, produto.getQuantidade());
            pst.setDouble(4, produto.getPreco());
            pst.setTimestamp(5, new java.sql.Timestamp(System.currentTimeMillis()));
            pst.setInt(6, produto.getCategoriaId());

            int linhasAfetadas = pst.executeUpdate();

            if (linhasAfetadas > 0) {
                System.out.println(">>> Produto inserido com sucesso!");
            } else {
                System.out.println(">>> Nenhuma linha foi inserida.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            fecharBanco();
        }
    }

    public ArrayList<Produto> pesquisarTudo() {
        ArrayList<Produto> listaProduto = new ArrayList<>();
        try {
            abrirBanco();
            String query = 
    "SELECT p.id, p.nome, p.preco, p.idUsuario, " +
    "DATE_FORMAT(p.criado_em, '%d/%m/%Y') AS criado_em, " +
    "p.categoria_id, c.nome AS nome_categoria " +
    "FROM produtos p " +
    "LEFT JOIN categorias c ON p.categoria_id = c.id " +
    "ORDER BY p.id DESC";
            pst = con.prepareStatement(query);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                Produto produto = new Produto();
                produto.setCodigo(rs.getInt("id"));
                produto.setNome(rs.getString("nome"));
                produto.setPreco(rs.getDouble("preco"));
                produto.setIdUsuario(rs.getInt("idUsuario"));
                produto.setCriadoEm(rs.getString("criado_em"));
                produto.setCategoriaId(rs.getInt("categoria_id"));

                // Montar categoria
                Categoria categoria = new Categoria();
                categoria.setId(rs.getInt("categoria_id"));
                categoria.setNome(rs.getString("nome_categoria"));
                produto.setCategoria(categoria); // novo método, veja abaixo

                listaProduto.add(produto);
            }
            fecharBanco();
        } catch (Exception e) {
            System.out.println("Erro " + e.getMessage());
        }
        return listaProduto;
    }

    public void deletar(Produto produto) {
        String query = "DELETE FROM produtos WHERE id = ?";

        try {
            abrirBanco();
            try (PreparedStatement pst = con.prepareStatement(query)) {
                pst.setInt(1, produto.getCodigo());
                int linhasAfetadas = pst.executeUpdate();

                if (linhasAfetadas > 0) {
                    System.out.println(">>> Produto deletado com sucesso!");
                } else {
                    System.out.println(">>> Nenhum produto encontrado com o ID informado.");
                }
            }
        } catch (Exception e) {
            System.out.println("Erro ao deletar produto: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                fecharBanco();
            } catch (Exception ex) {
                System.out.println("Erro ao fechar conexão: " + ex.getMessage());
            }
        }
    }

    public void alterar(Produto produto) {
        try {
            abrirBanco();
            String query = "UPDATE produtos SET nome = ?, quantidade = ?, preco = ?, categoria_id = ? WHERE id = ?";
            pst = con.prepareStatement(query);
            pst.setString(1, produto.getNome());
            pst.setInt(2, produto.getQuantidade());
            pst.setDouble(3, produto.getPreco());
            pst.setInt(4, produto.getCategoriaId());
            pst.setInt(5, produto.getCodigo());
            pst.executeUpdate();
            fecharBanco();
            System.out.println(">>> Produto atualizado com sucesso!");
        } catch (Exception e) {
            System.out.println("Erro ao atualizar produto: " + e.getMessage());
        }
    }
}
