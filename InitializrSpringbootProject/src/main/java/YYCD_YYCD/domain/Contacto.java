package YYCD_YYCD.domain;

import jakarta.persistence.*;               // anotaciones JPA

@Entity                                      // marca clase como entidad
@Table(name = "contactos")                   // asocia con tabla "contactos"
public class Contacto {

    @Id                                      // clave primaria
    @GeneratedValue(strategy = GenerationType.IDENTITY) // genera valor automático
    private Long id;                         // ID del contacto

    private String nombre;                   // nombre del contacto
    private String email;                    // correo del contacto
    private String mensaje;                  // mensaje enviado

    public Long getId() {                    // obtiene el ID
        return id;
    }

    public void setId(Long id) {             // asigna el ID
        this.id = id;
    }

    public String getNombre() {              // obtiene el nombre
        return nombre;
    }

    public void setNombre(String nombre) {   // asigna el nombre
        this.nombre = nombre;
    }

    public String getEmail() {               // obtiene el email
        return email;
    }

    public void setEmail(String email) {     // asigna el email
        this.email = email;
    }

    public String getMensaje() {             // obtiene el mensaje
        return mensaje;
    }

    public void setMensaje(String mensaje) { // asigna el mensaje
        this.mensaje = mensaje;
    }
}
