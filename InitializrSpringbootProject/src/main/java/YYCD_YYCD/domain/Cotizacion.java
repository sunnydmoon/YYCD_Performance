package YYCD_YYCD.domain;

import jakarta.validation.constraints.*;

public class Cotizacion {

    private Long idCotizacion;

    @NotBlank(message = "El nombre es obligatorio")
    private String nombre;

    @NotBlank(message = "El correo electrónico es obligatorio")
    @Email(message = "Formato de correo electrónico inválido")
    private String email;

    @NotBlank(message = "La marca del vehículo es obligatoria")
    private String marcaVehiculo;

    @NotBlank(message = "El modelo del vehículo es obligatorio")
    private String modeloVehiculo;

    @NotNull(message = "El año del vehículo es obligatorio")
    @Min(value = 1900, message = "Año del vehículo inválido")
    @Max(value = 2030, message = "Año del vehículo inválido")
    private Integer anio;

    // Getters y setters

    public Long getIdCotizacion() {
        return idCotizacion;
    }

    public void setIdCotizacion(Long idCotizacion) {
        this.idCotizacion = idCotizacion;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMarcaVehiculo() {
        return marcaVehiculo;
    }

    public void setMarcaVehiculo(String marcaVehiculo) {
        this.marcaVehiculo = marcaVehiculo;
    }

    public String getModeloVehiculo() {
        return modeloVehiculo;
    }

    public void setModeloVehiculo(String modeloVehiculo) {
        this.modeloVehiculo = modeloVehiculo;
    }

    public Integer getAnio() {
        return anio;
    }

    public void setAnio(Integer anio) {
        this.anio = anio;
    }
}
