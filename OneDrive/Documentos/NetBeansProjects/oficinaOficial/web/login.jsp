<!DOCTYPE html>
<html lang="pt-br">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Login - Oficina Mecânica</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <style>
      /* Loader styles */
      #loader {
        position: fixed;
        top: 0;
        left: 0;
        width: 100vw;
        height: 100vh;
        background-color: white;
        z-index: 9999;
        display: flex;
        align-items: center;
        justify-content: center;
      }

      .spinner-border {
        width: 4rem;
        height: 4rem;
        color: #db4b23;
      }

      body {
        background: linear-gradient(to right, #2c3e50, #4ca1af);
        height: 100vh;
        margin: 0;
        display: flex;
        align-items: center;
        justify-content: center;
        font-family: 'Segoe UI', sans-serif;
      }

      .login-card {
        background-color: #ffffff;
        padding: 2.5rem;
        border-radius: 20px;
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.25);
        width: 100%;
        max-width: 400px;
        animation: fadeIn 0.8s ease-in-out;
        display: none; /* Oculta o formulário até o carregamento completo */
      }

      .garage-header {
        font-weight: 700;
        color: #db4b23;
        text-align: center;
        margin-bottom: 1rem;
      }

      .btn-orange {
        background-color: #db4b23;
        color: white;
        transition: 0.3s ease;
      }

      .btn-orange:hover {
        background-color: #c1411d;
      }
      .login-card:hover {
  transform: scale(1.02);
  box-shadow: 0 12px 30px rgba(0, 0, 0, 0.35);
  transition: all 0.3s ease-in-out;
}


      @keyframes fadeIn {
        from {
          opacity: 0;
          transform: translateY(30px);
        }
        to {
          opacity: 1;
          transform: translateY(0);
        }
      }
    </style>
  </head>
  <body>
    <!-- Loader -->
    <div id="loader">
      <div class="spinner-border" role="status">
        <span class="visually-hidden">Carregando...</span>
      </div>
    </div>

    <!-- Formulário -->
    <div class="login-card" id="loginCard">
      <h2 class="garage-header">Oficina Login</h2>
      <p class="text-center mb-4">Bem-vindo de volta ao sistema da sua oficina!</p>
      <form action="ServletLogin" method="POST">
        <div class="mb-3">
          <label for="email" class="form-label">E-mail</label>
          <input
            type="email"
            class="form-control"
            id="email"
            name="email"
            required
          />
        </div>
        <div class="mb-3">
          <label for="senha" class="form-label">Senha</label>
          <input
            type="password"
            class="form-control"
            id="senha"
            name="senha"
            required
          />
        </div>
        <div class="d-grid">
          <button type="submit" class="btn btn-orange">Entrar</button>
        </div>
      </form>
      <hr />
      <div class="text-center">
        <p class="mb-1">OU</p>
        <p>
          Ainda não possui conta?
          <a href="cadastro.jsp">Cadastre-se</a>
        </p>
      </div>
    </div>

    <script>
      // Esconde o loader e mostra o formulário quando a página estiver carregada
      window.addEventListener("load", () => {
        document.getElementById("loader").style.display = "none";
        document.getElementById("loginCard").style.display = "block";
      });
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
