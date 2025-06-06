/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Danilo Miranda
 */
public class DAO {

    Connection con;
    PreparedStatement pst;
    ResultSet rs;
//?
    public void abrirBanco() throws SQLException {
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url = "jdbc:mysql://localhost/sistema_produtos?useTimezone=true&serverTimezone=UTC";
        String user = "root";
        String senha = "";
        con = DriverManager.getConnection(url, user, senha);
        con.setAutoCommit(true);
        System.out.println("Conectado ao banco de dados ");
    } catch (ClassNotFoundException ex) {
        System.out.println("Classe não encontrada, adicione o driver nas bibliotecas.");
        Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
    } catch (SQLException e) {
        System.out.println(e);
        throw new RuntimeException(e);
    }
}


    public void fecharBanco() {
    try {
        if (pst != null && !pst.isClosed()) {
            pst.close();
            System.out.println("Execução da Query fechada\n");
        }
        if (con != null && !con.isClosed()) {
            con.close();
            System.out.println("Conexão com banco fechada\n");
        }
    } catch (SQLException e) {
        System.out.println("Erro ao fechar conexão: " + e.getMessage());
    }
}

}
