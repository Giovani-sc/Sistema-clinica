package com.clinicavet.clinica.controller;

import com.clinicavet.clinica.dto.AnimalDTO;
import com.clinicavet.clinica.model.Animal;
import com.clinicavet.clinica.service.AnimalService;
import com.clinicavet.clinica.service.ClienteService;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class AnimalController {

    private final AnimalService animalService;
    private final ClienteService clienteService;

    public AnimalController(AnimalService animalService, ClienteService clienteService) {
        this.animalService = animalService;
        this.clienteService = clienteService;
    }

// cadastrar animal
    @GetMapping("/cadastrarAnimal")
    public String cadastrarAnimal(Model model) {
        model.addAttribute("titulo", "Cadastro de Animal");
        model.addAttribute(
            "animalDTO",
            new AnimalDTO(null, "", "", "", null, "", "", null, null)
        );
        model.addAttribute("clientes", clienteService.listAll());
        return "novo-cliente";
    }


    // SAlvar / Atualizar animal
    @PostMapping("/cadastrarAnimal")
    public String salvarAnimal(
            @ModelAttribute("animalDTO") AnimalDTO dto,
            RedirectAttributes redirectAttributes) {

        animalService.saveByDTO(dto);

        if (dto.id() != null) {
            redirectAttributes.addFlashAttribute(
                    "mensagem",
                    "Animal atualizado com sucesso!"
            );
        } else {
            redirectAttributes.addFlashAttribute(
                    "mensagem",
                    "Animal salvo com sucesso!"
            );
        }

        return "redirect:/clientes";
    }


    // Listar animais
    @GetMapping("/animais")
    public String listarAnimais(Model model) {
        List<Animal> animais = animalService.listAll();
        model.addAttribute("animais", animais);
        return "listarAnimais";
    }

// Excluir animal
    @PostMapping("/animais/excluir/{id}")
    public String excluirAnimal(
            @PathVariable Long id,
            RedirectAttributes redirectAttributes) {

        animalService.deleteById(id);

        redirectAttributes.addFlashAttribute(
                "mensagem",
                "Animal excluído com sucesso!"
        );

        return "redirect:/clientes";
    }

// editar animal
    @GetMapping("/animais/editar/{id}")
    public String editarAnimal(
            @PathVariable Long id,
            Model model) {

        Animal animal = animalService.listById(id);

        AnimalDTO dto = new AnimalDTO(
                animal.getId(),
                animal.getNome(),
                animal.getEspecie(),
                animal.getRaca(),
                animal.getDataNascimento(),
                animal.getObservacoes(),
                animal.getSexo(),
                animal.getProntuario(),
                animal.getCliente() != null ? animal.getCliente().getId() : null
        );

        model.addAttribute("titulo", "Editar Animal");
        model.addAttribute("animalDTO", dto);
        model.addAttribute("clientes", clienteService.listAll());

        return "novo-cliente";
    }
}