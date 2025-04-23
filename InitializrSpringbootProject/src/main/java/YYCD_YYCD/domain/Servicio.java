package YYCD_YYCD.domain;

import jakarta.persistence.*;                   // import JPA
import lombok.Data;                              // import Lombok (no usado aquí)
import java.util.List;                           // import List (no usado aquí)

@Entity                                         // marca clase como entidad JPA
@Table(name = "servicios")                      // asocia con tabla "servicios"
public class Servicio {
    @Id                                         // define clave primaria
    @GeneratedValue(strategy = GenerationType.IDENTITY) // auto-incrementa ID
    private Long id;                             // identificador del servicio

    private String nombre;                       // nombre del servicio
    private String descripcion;                  // descripción del servicio
    private String imagenUrl;                    // URL de la imagen

    public Long getId() {                        // obtiene el id
        return id;
    }

    public void setId(Long id) {                 // fija el id
        this.id = id;
    }

    public String getNombre() {                  // obtiene el nombre
        return nombre;
    }

    public void setNombre(String nombre) {       // fija el nombre
        this.nombre = nombre;
    }

    public String getDescripcion() {             // obtiene la descripción
        return descripcion;
    }

    public void setDescripcion(String descripcion) { // fija la descripción
        this.descripcion = descripcion;
    }
}
