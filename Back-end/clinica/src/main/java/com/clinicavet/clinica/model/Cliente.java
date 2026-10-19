package com.clinicavet.clinica.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity 
@Table(name = "cliente")
@NoArgsConstructor
@AllArgsConstructor 
@Getter 
@Setter 

public class Cliente {
    
    @Id 
    @GeneratedValue (strategy = GenerationType.IDENTITY)
    @Column(name = "id_cliente")
    private Long id;

    @Column(name = "nome", nullable = false, length = 150)
    private String nome;

    @Column(name = "cpf", nullable = false, unique = true, length = 11)
    private String cpf;

    @Column(name = "data_nascimento")
    private LocalDate dataNascimento;

    @Column (name = "email", nullable = false, unique = true, length = 255)
    private String email;

    @Column(name = "observacoes_gerais", length = 500)
    private String observacoesGerais;
}
