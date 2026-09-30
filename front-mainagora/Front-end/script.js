document.addEventListener('DOMContentLoaded', () => {

  // Busca nas tabelas
  const searchInputs = document.querySelectorAll('.search-input');

  searchInputs.forEach(input => {

    input.addEventListener('keyup', (e) => {

      const term = e.target.value.toLowerCase();

      const tableRows = document.querySelectorAll(
        '.agenda-table tbody tr'
      );

      tableRows.forEach(row => {

        const text = row.textContent.toLowerCase();

        if (text.includes(term)) {
          row.style.display = '';
        } else {
          row.style.display = 'none';
        }

      });

    });

  });


  // Formulários
  const forms = document.querySelectorAll('form');

  forms.forEach(form => {

    form.addEventListener('submit', () => {
      console.log('Formulário enviado com sucesso!');
    });

  });

});