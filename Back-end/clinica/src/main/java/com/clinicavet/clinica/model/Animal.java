package com.clinicavet.clinica.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.time.LocalDate;

@Entity
@Table(name = "animal")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Animal {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_animal")
    private Long id;

    @Column(name = "nome", nullable = false, length = 100)
    private String nome;

    @Column(name = "especie", nullable = false, length = 100)
    private String especie;

    @Column(name = "raca", length = 100)
    private String raca;

    @Column(name = "data_nascimento")
    private LocalDate dataNascimento;

    @Column(name = "observacoes", columnDefinition = "TEXT")
    private String observacoes;

    @Column(name = "id_prontuario")
    private Integer idProntuario;

    @Column(name = "sexo", nullable = false)
    private String sexo; // ou Enum se preferir

    @Lob
    @Column(name = "prontuario", columnDefinition = "LONGBLOB")
    private byte[] prontuario;

    // Relacionamento com a tabela Cliente através de id_cliente
    @ManyToOne
    @JoinColumn(name = "id_cliente", nullable = false)
    private Cliente cliente;
}
