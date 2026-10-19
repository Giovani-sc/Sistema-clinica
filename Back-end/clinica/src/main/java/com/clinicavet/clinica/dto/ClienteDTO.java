package com.clinicavet.clinica.dto;

import java.time.LocalDate;

public record ClienteDTO(
    Long id,
    String nome,
    String cpf,
    LocalDate dataNascimento,
    String email,
    String observacoesGerais
) {   
}