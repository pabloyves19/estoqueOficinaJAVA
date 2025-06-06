/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model;

import com.controler.Categoria;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
/**
 *
 * @author vagco
 */
public class CategoriaDAO extends DAO {

    public void inserir(Categoria categoria) {
        try {
            abrirBanco();
            String query = "INSERT INTO categorias (nome) VALUES(?)";
            pst = (PreparedStatement) con.prepareStatement(query);
            pst.setString(1, categoria.getNome());
            pst.execute();
            fecharBanco();
        } catch (Exception e) {
            System.out.println("Erro ao inserir categoria: " + e.getMessage());
        }
    }
    
    public ArrayList<Categoria> listarTodas() {
    ArrayList<Categoria> listaCategoria = new ArrayList<Categoria>();
    try {
        abrirBanco();
        String query = "SELECT id, nome FROM categorias ORDER BY nome ASC";
        pst = con.prepareStatement(query);
        ResultSet rs = pst.executeQuery();
        Categoria categoria;
        while (rs.next()) {
            categoria = new Categoria();
            categoria.setId(rs.getInt("id"));
            categoria.setNome(rs.getString("nome"));
            listaCategoria.add(categoria);
        }
        fecharBanco();
    } catch (Exception e) {
        System.out.println("Erro ao listar categorias: " + e.getMessage());
    }
    return listaCategoria;
}
public ArrayList<Categoria> pesquisarTudo() {
    ArrayList<Categoria> listaCategoria = new ArrayList<>();
    try {
        abrirBanco();
        String query = "SELECT id, nome FROM categorias ORDER BY id DESC";
        pst = con.prepareStatement(query);
        ResultSet rs = pst.executeQuery();
        Categoria categoria;
        while (rs.next()) {
            categoria = new Categoria();
            categoria.setId(rs.getInt("id"));
            categoria.setNome(rs.getString("nome"));
            listaCategoria.add(categoria);
        }
        fecharBanco();
    } catch (Exception e) {
        System.out.println("Erro " + e.getMessage());
    }
    return listaCategoria;
}
public void alterar(Categoria categoria) {
    try {
        abrirBanco();
        String query = "UPDATE categorias SET nome = ? WHERE id = ?";
        pst = con.prepareStatement(query);
        pst.setString(1, categoria.getNome());
        pst.setInt(2, categoria.getId());
        pst.executeUpdate();
        fecharBanco();
        System.out.println(">>> Categoria atualizada com sucesso!");
    } catch (Exception e) {
        System.out.println("Erro ao atualizar categoria: " + e.getMessage());
    }
}
public void deletar(Categoria categoria) {
    String query = "DELETE FROM categorias WHERE id = ?";

    try {
        abrirBanco();
        try (PreparedStatement pst = con.prepareStatement(query)) {
            pst.setInt(1, categoria.getId());  // Usa 'getId()' conforme sua classe Categoria

            int linhasAfetadas = pst.executeUpdate();

            if (linhasAfetadas > 0) {
                System.out.println(">>> Categoria deletada com sucesso!");
            } else {
                System.out.println(">>> Nenhuma categoria encontrada com o ID informado.");
            }
        }
    } catch (Exception e) {
        System.out.println("Erro ao deletar categoria: " + e.getMessage());
        e.printStackTrace();
    } finally {
        try {
            fecharBanco();
        } catch (Exception ex) {
            System.out.println("Erro ao fechar conexão: " + ex.getMessage());
        }
    }
}


}
