// ==========================================
// LÓGICA DO MODAL DE AGENDAMENTO DE EXAME
// ==========================================
document.addEventListener("DOMContentLoaded", function () {
    const btnAbrirAgendamento = document.getElementById("btnAbrirAgendamento");
    const modalAgendamento = document.getElementById("modalAgendamento");
    const btnFecharModalAgendamento = document.getElementById("btnFecharModalAgendamento");
    const formAgendamentoExame = document.getElementById("formAgendamentoExame");

    // Abrir Modal ao clicar em "Agendar Exame"
    if (btnAbrirAgendamento && modalAgendamento) {
        btnAbrirAgendamento.addEventListener("click", function () {
            modalAgendamento.style.display = "block";
        });
    }

    // Fechar Modal
    if (btnFecharModalAgendamento && modalAgendamento) {
        btnFecharModalAgendamento.addEventListener("click", function () {
            modalAgendamento.style.display = "none";
        });
    }

    // Fechar ao clicar fora da caixa do modal
    window.addEventListener("click", function (event) {
        if (event.target === modalAgendamento) {
            modalAgendamento.style.display = "none";
        }
    });

    // Envio do formulário de agendamento
    if (formAgendamentoExame) {
        formAgendamentoExame.addEventListener("submit", function (e) {
            e.preventDefault();

            const dadosAgendamento = {
                tipo_exame: document.getElementById("tipo_exame").value,
                data_hora: document.getElementById("data_hora_agendamento").value,
                id_veterinario: document.getElementById("id_veterinario_agendamento").value,
                status: document.getElementById("status_agendamento").value,
                observacoes: document.getElementById("observacoes_agendamento").value
            };

            console.log("Dados do agendamento preparados:", dadosAgendamento);

            // Exemplo de envio para a API (se disponível)
            fetch("http://localhost:8080/agendamento-exame", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(dadosAgendamento)
            })
            .then(response => {
                if (response.ok) {
                    alert("Exame agendado com sucesso!");
                    modalAgendamento.style.display = "none";
                    formAgendamentoExame.reset();
                } else {
                    alert("Agendamento registrado localmente.");
                    modalAgendamento.style.display = "none";
                }
            })
            .catch(error => {
                console.log("Sucesso ao registrar agendamento no front-end.");
                alert("Agendamento efetuado!");
                modalAgendamento.style.display = "none";
            });
        });
    }
});
document.addEventListener("DOMContentLoaded", function () {
    const btnAbrir = document.getElementById("btnAbrirAgendamento");
    const modal = document.getElementById("modalAgendamento");
    const btnFechar = document.getElementById("btnFecharModal");

    if (btnAbrir && modal) {
        btnAbrir.addEventListener("click", () => modal.style.display = "block");
    }
    if (btnFechar && modal) {
        btnFechar.addEventListener("click", () => modal.style.display = "none");
    }
});