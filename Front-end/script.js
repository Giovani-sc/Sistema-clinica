document.addEventListener('DOMContentLoaded', () => {

  // -------------------------------------------------------------
  // 1. TELA: CONTATE O ADM (esqueci.html)
  // -------------------------------------------------------------
  const formAdm = document.getElementById('form-contato-adm');
  const msgSucesso = document.getElementById('mensagem-sucesso');

  if (formAdm) {
    formAdm.addEventListener('submit', (e) => {
      e.preventDefault();
      if (msgSucesso) {
        msgSucesso.classList.remove('hidden');
      }
      formAdm.reset();
    });
  }

  // -------------------------------------------------------------
  // 2. TELA: LOGIN (index.html / main.html)
  // -------------------------------------------------------------
  const formLogin = document.querySelector('.login-form');
  const emailInput = document.getElementById('email');
  const rememberCheckbox = document.getElementById('remember');

  if (formLogin && !formAdm) {
    const savedEmail = localStorage.getItem('clinivet_remembered_email');
    if (savedEmail && emailInput && rememberCheckbox) {
      emailInput.value = savedEmail;
      rememberCheckbox.checked = true;
    }

    formLogin.addEventListener('submit', (e) => {
      e.preventDefault();

      if (rememberCheckbox && rememberCheckbox.checked) {
        localStorage.setItem('clinivet_remembered_email', emailInput.value);
      } else {
        localStorage.removeItem('clinivet_remembered_email');
      }

      window.location.href = 'painel.html';
    });
  }

  // -------------------------------------------------------------
  // 3. TELA: NOVO CLIENTE (novo-cliente.html) - MÁSCARAS E CEP
  // -------------------------------------------------------------
  const formCliente = document.getElementById('formNovoCliente') || document.querySelector('.client-form-card');
  
  if (formCliente) {
    formCliente.addEventListener('submit', (e) => {
      e.preventDefault();
      alert('Cliente cadastrado com sucesso!');
      window.location.href = 'clientes.html';
    });

    const inputCpf = document.getElementById('cpf');
    const inputCep = document.getElementById('cep');
    const inputTel1 = document.getElementById('telefone');
    const inputTel2 = document.getElementById('telefone2');
    const inputWhats = document.getElementById('whatsapp');

    if (inputCpf) {
      inputCpf.addEventListener('input', (e) => {
        let v = e.target.value.replace(/\D/g, '');
        v = v.replace(/(\d{3})(\d)/, '$1.$2');
        v = v.replace(/(\d{3})(\d)/, '$1.$2');
        v = v.replace(/(\d{3})(\d{1,2})$/, '$1-$2');
        e.target.value = v.substring(0, 14);
      });
    }

    if (inputCep) {
      inputCep.addEventListener('input', (e) => {
        let v = e.target.value.replace(/\D/g, '');
        v = v.replace(/^(\d{5})(\d)/, '$1-$2');
        e.target.value = v.substring(0, 9);
      });

      inputCep.addEventListener('blur', async () => {
        const cepLimpo = inputCep.value.replace(/\D/g, '');
        if (cepLimpo.length === 8) {
          try {
            const res = await fetch(`https://viacep.com.br/ws/${cepLimpo}/json/`);
            const data = await res.json();
            if (!data.erro) {
              const inputLogradouro = document.getElementById('logradouro');
              const inputBairro = document.getElementById('bairro');
              const selectCidade = document.getElementById('cidade');
              const inputEstado = document.getElementById('estado');

              if (inputLogradouro) inputLogradouro.value = data.logradouro || '';
              if (inputBairro) inputBairro.value = data.bairro || '';
              if (inputEstado) inputEstado.value = 'DF';

              // Seleção inteligente da RA de Brasília
              if (selectCidade && data.bairro) {
                const bairroApi = data.bairro.toLowerCase();
                Array.from(selectCidade.options).forEach(opt => {
                  if (opt.value && bairroApi.includes(opt.value.toLowerCase())) {
                    selectCidade.value = opt.value;
                  }
                });
              }

              const inputNumero = document.getElementById('numero');
              if (inputNumero) inputNumero.focus();
            }
          } catch (err) {
            console.error("Erro ao buscar CEP:", err);
          }
        }
      });
    }

    const mascaraTelefone = (input) => {
      if (!input) return;
      input.addEventListener('input', (e) => {
        let v = e.target.value.replace(/\D/g, '');
        v = v.replace(/^(\d{2})(\d)/g, '($1) $2');
        v = v.replace(/(\d)(\d{4})$/, '$1-$2');
        e.target.value = v.substring(0, 15);
      });
    };

    mascaraTelefone(inputTel1);
    mascaraTelefone(inputTel2);
    mascaraTelefone(inputWhats);
  }

  // -------------------------------------------------------------
  // 4. TELA: LISTA DE CLIENTES (clientes.html) - BUSCA EM TEMPO REAL
  // -------------------------------------------------------------
  const searchInput = document.getElementById('searchClient');
  const tableBody = document.getElementById('clientTableBody');

  if (searchInput && tableBody) {
    searchInput.addEventListener('input', (e) => {
      const term = e.target.value.toLowerCase();
      const rows = tableBody.getElementsByTagName('tr');

      Array.from(rows).forEach(row => {
        const text = row.textContent.toLowerCase();
        row.style.display = text.includes(term) ? '' : 'none';
      });
    });
  }

});

// -------------------------------------------------------------
// 5. FUNÇÃO GLOBAL: ABRIR/FECHAR MENU DE NOTIFICAÇÕES
// -------------------------------------------------------------
function toggleNotifications() {
  const menu = document.getElementById('notificationMenu');
  if (menu) {
    menu.classList.toggle('hidden');
  }
}