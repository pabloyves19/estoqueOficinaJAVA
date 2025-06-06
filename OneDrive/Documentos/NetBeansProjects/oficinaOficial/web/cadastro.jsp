<%-- 
    Document   : cadastro
    Created on : 05/11/2020, 10:32:00
    Author     : Danilo Miranda
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Portal de Notícias - Cadastro</title>
        <link rel="stylesheet" href="assets/css/style.css" />
        <script src="https://kit.fontawesome.com/a81368914c.js"></script>
        <link
            href="https://fonts.googleapis.com/css2?family=Open+Sans&display=swap"
            rel="stylesheet"
            />
    </head>

    <body>
        <img class="wave" src="assets/img/wave3.png" />
        <div class="container">
            <div class="img">
                <img src="assets/img/login-mobile.svg" />
            </div>
            <div class="login-container">
                <form action="ServletCadastroLogin" method="POST">
                    <h2>Cadastre-se</h2>
                    <div class="input-div two">
                        <div class="i">
                            <i class="fas fa-envelope"></i>
                        </div>
                        <div>
                            <h5>E-mail</h5>
                            <input class="input" type="text" name="email" id="email" required>
                        </div>
                    </div>
                    <div class="input-div one">
                        <div class="i">
                            <i class="fas fa-key"></i>
                        </div>
                        <div>
                            <h5>Senha</h5>
                            <input class="input" type="password" name="senha" id="senha" required>
                        </div>
                    </div>

                    <div>
                        <input type="checkbox" class="custom-control-input" id="customSwitches" required>
                        <label class="custom-control-label" for="customSwitches">Aceito os termos de uso do portal. </label>
                    </div>
                    <input type="submit" class="btn" value="Cadastrar" />
                    <div class="account">
                        <p>Já possuí conta ?</p>
                        <a href="login.jsp">Entrar</a>
                    </div>
                </form>
            </div>
        </div>

        <script type="text/javascript" src="assets/js/main.js"></script>
    </body>
</html>
