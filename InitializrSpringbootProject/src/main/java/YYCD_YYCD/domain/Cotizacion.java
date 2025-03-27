
package YYCD_YYCD.domain;
import jakarta.persistence.*;
import lombok.Data;
@Entity
@Table(name = "cotizaciones")
public class Cotizacion {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String modeloAuto;
    private String servicioRequerido; 
    private String contacto;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getModeloAuto() {
        return modeloAuto;
    }

    public void setModeloAuto(String modeloAuto) {
        this.modeloAuto = modeloAuto;
    }

    public String getServicioRequerido() {
        return servicioRequerido;
    }

    public void setServicioRequerido(String servicioRequerido) {
        this.servicioRequerido = servicioRequerido;
    }

    public String getContacto() {
        return contacto;
    }

    public void setContacto(String contacto) {
        this.contacto = contacto;
    }
    
}