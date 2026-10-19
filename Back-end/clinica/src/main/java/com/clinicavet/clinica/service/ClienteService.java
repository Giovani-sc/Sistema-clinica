package com.clinicavet.clinica.service;

import com.clinicavet.clinica.dto.ClienteDTO;
import com.clinicavet.clinica.model.Cliente;
import com.clinicavet.clinica.repository.ClienteRepository;

import jakarta.transaction.Transactional;

import java.util.List;

import org.springframework.stereotype.Service;

@Service 
public class ClienteService {

    private ClienteRepository rep;

    public ClienteService(ClienteRepository rep) {
        this.rep = rep;
    }


@Transactional 
public Cliente saveByDTO (ClienteDTO dto) {

    Cliente cliente = new Cliente();

    cliente.setNome(dto.nome());
    cliente.setCpf(dto.cpf());
    cliente.setDataNascimento(dto.dataNascimento());
    cliente.setEmail(dto.email());
    cliente.setObservacoesGerais(dto.observacoesGerais());

    return rep.save(cliente);
}

public List<Cliente> listAll() {
        return rep.findAll();
    }

public Cliente listById(Long id) {
        return rep.findById(id)
                .orElseThrow(() ->
                    new RuntimeException("Cliente não encontrado para o ID: " + id)
                );
    }

@Transactional 
public Cliente update(Long id, ClienteDTO dto) {

    Cliente cliente = listById(id);

    cliente.setNome(dto.nome());
    cliente.setCpf(dto.cpf());
    cliente.setDataNascimento(dto.dataNascimento());
    cliente.setEmail(dto.email());
    cliente.setObservacoesGerais(dto.observacoesGerais());

    return rep.save(cliente);
}

@Transactional
public void deleteById(Long id) {
    Cliente cliente = listById(id);
    rep.delete(cliente);
}

}