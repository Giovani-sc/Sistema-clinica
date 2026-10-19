package com.clinicavet.clinica.dto;

import java.time.LocalDate;

public record AnimalDTO(
    Long id,
    String nome,
    String especie,
    String raca,
    LocalDate dataNascimento,
    String observacoes,
    String sexo,
    byte[] prontuario,
    Long idCliente
) {}