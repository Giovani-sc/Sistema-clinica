package com.clinicavet.clinica.service;

import com.clinicavet.clinica.dto.AnimalDTO;
import com.clinicavet.clinica.model.Animal;
import com.clinicavet.clinica.model.Cliente;
import com.clinicavet.clinica.repository.AnimalRepository;
import com.clinicavet.clinica.repository.ClienteRepository;

import jakarta.transaction.Transactional;
import java.util.List;

import org.springframework.stereotype.Service;

@Service
public class AnimalService {

    private final AnimalRepository rep;
    private final ClienteRepository clienteRepository;

    public AnimalService(AnimalRepository rep, ClienteRepository clienteRepository) {
        this.rep = rep;
        this.clienteRepository = clienteRepository;
    }

    // Cadastrar / Salvar animal via DTO
    @Transactional
    public Animal saveByDTO(AnimalDTO dto) {
        Cliente cliente = clienteRepository.findById(dto.idCliente())
                .orElseThrow(() -> new RuntimeException("Cliente não encontrado para o ID: " + dto.idCliente()));

        Animal animal = new Animal();
        animal.setNome(dto.nome());
        animal.setEspecie(dto.especie());
        animal.setRaca(dto.raca());
        animal.setDataNascimento(dto.dataNascimento());
        animal.setObservacoes(dto.observacoes());
        animal.setSexo(dto.sexo());
        animal.setProntuario(dto.prontuario());
        animal.setCliente(cliente);

        return rep.save(animal);
    }

    // Listar animais
    public List<Animal> listAll() {
        return rep.findAll();
    }

    // Buscar por ID
    public Animal listById(Long id) {
        return rep.findById(id)
                .orElseThrow(() ->
                        new RuntimeException(
                                "Animal não encontrado para o ID: " + id
                        )
                );
    }

    // Atualizar animal
    @Transactional
    public Animal update(Long id, AnimalDTO dto) {
        Animal animal = listById(id);

        Cliente cliente = clienteRepository.findById(dto.idCliente())
                .orElseThrow(() -> new RuntimeException("Cliente não encontrado para o ID: " + dto.idCliente()));

        animal.setNome(dto.nome());
        animal.setEspecie(dto.especie());
        animal.setRaca(dto.raca());
        animal.setDataNascimento(dto.dataNascimento());
        animal.setObservacoes(dto.observacoes());
        animal.setSexo(dto.sexo());
        animal.setProntuario(dto.prontuario());
        animal.setCliente(cliente);

        return rep.save(animal);
    }

    // Excluir animal
    @Transactional
    public void deleteById(Long id) {
        Animal animal = listById(id);
        rep.delete(animal);
    }
}