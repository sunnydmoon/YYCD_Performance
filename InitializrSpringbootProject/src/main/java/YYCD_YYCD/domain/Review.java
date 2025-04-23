package YYCD_YYCD.domain;

import jakarta.persistence.*;               // import JPA

@Entity                                      // marca clase como entidad
@Table(name = "review")                      // asocia con tabla "review"
public class Review {
    @Id                                      // clave primaria
    @GeneratedValue(strategy = GenerationType.IDENTITY) // autogenera valor
    private Long id;                         // id del review

    private String cliente;                  // nombre del cliente
    private String comentario;               // texto del comentario
    private int puntuacion;                  // puntuación del review

    public Long getId() {                    // obtiene el id
        return id;
    }

    public void setId(Long id) {             // asigna el id
        this.id = id;
    }

    public String getCliente() {             // obtiene cliente
        return cliente;
    }

    public void setCliente(String cliente) { // asigna cliente
        this.cliente = cliente;
    }

    public String getComentario() {          // obtiene comentario
        return comentario;
    }

    public void setComentario(String comentario) { // asigna comentario
        this.comentario = comentario;
    }

    public int getPuntuacion() {             // obtiene puntuación
        return puntuacion;
    }

    public void setPuntuacion(int puntuacion) { // asigna puntuación
        this.puntuacion = puntuacion;
    }
}
