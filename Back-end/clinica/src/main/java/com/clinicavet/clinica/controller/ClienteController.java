package com.clinicavet.clinica.controller;

import com.clinicavet.clinica.dto.ClienteDTO;
import com.clinicavet.clinica.model.Cliente;
import com.clinicavet.clinica.service.ClienteService;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.bind.annotation.RequestBody;


@Controller 
public class ClienteController {
    
    private final ClienteService service;

    public ClienteController(ClienteService service) {
        this.service = service;
    }


//Cadastrar cliente
@GetMapping ("/cadastrarCliente")
public String cadastrarCliente(Model model) {

    model.addAttribute("titulo", "cadastro de cliente");

    model.addAttribute(
        "clienteDTO",
        new ClienteDTO(null, "", "", null, "", "")
    );

    return "novo-cliente";
}

//salvar/atualizar cliente
@PostMapping("/cadastrarCliente")
    public String salvarCliente(
            @ModelAttribute("clienteDTO") ClienteDTO dto,
            RedirectAttributes redirectAttributes) {

        if (dto.id() != null) {

            service.update(dto.id(), dto);

            redirectAttributes.addFlashAttribute(
                    "mensagem",
                    "Cliente atualizado com sucesso!"
            );

        } else {

            service.saveByDTO(dto);

            redirectAttributes.addFlashAttribute(
                    "mensagem",
                    "Cliente salvo com sucesso!"
            );
        }

        return "redirect:/clientes";
    }

    // =========================
    // LISTAR CLIENTES
    // =========================

    @GetMapping("/clientes")
    public String listarClientes(Model model) {

        List<Cliente> clientes = service.listAll();

        model.addAttribute("clientes", clientes);

        return "listarClientes";
    }

    // =========================
    // EXCLUIR CLIENTE
    // =========================

    @PostMapping("/clientes/excluir/{id}")
    public String excluirCliente(
            @PathVariable Long id,
            RedirectAttributes redirectAttributes) {

        service.deleteById(id);

        redirectAttributes.addFlashAttribute(
                "mensagem",
                "Cliente excluído com sucesso!"
        );

        return "redirect:/clientes";
    }

    // =========================
    // EDITAR CLIENTE
    // =========================

    @GetMapping("/clientes/editar/{id}")
    public String editarCliente(
            @PathVariable Long id,
            Model model) {

        Cliente cliente = service.listById(id);

        ClienteDTO dto = new ClienteDTO(
                cliente.getId(),
                cliente.getNome(),
                cliente.getCpf(),
                cliente.getDataNascimento(),
                cliente.getEmail(),
                cliente.getObservacoesGerais()
        );

        model.addAttribute("titulo", "Editar Cliente");
        model.addAttribute("clienteDTO", dto);

        return "editar-cliente";
    }
}

