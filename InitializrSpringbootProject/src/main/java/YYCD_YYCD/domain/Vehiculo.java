package YYCD_YYCD.domain;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
public class Vehiculo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String marca;
    private String modelo;
    private int año;
    private double precio;
    private double kilometraje;
    private String caracteristicas;
    private String estado;
    private String fotoUrl;
    private boolean disponible;

   @ManyToOne
    @JoinColumn(name = "categoria_id")
    private Categoria categoria;

    public boolean isDisponible() {
        return disponible;
    }

    public void setDisponible(boolean disponible) {
        this.disponible = disponible;
    }
}
