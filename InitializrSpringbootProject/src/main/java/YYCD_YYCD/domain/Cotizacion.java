package YYCD_YYCD.domain;

import jakarta.validation.constraints.*;     // import validaciones

public class Cotizacion {                    // clase de cotización

    private Long idCotizacion;               // id de la cotización

    @NotBlank(message = "El nombre es obligatorio")
    private String nombre;                   // nombre del cliente

    @NotBlank(message = "El correo electrónico es obligatorio")
    @Email(message = "Formato de correo electrónico inválido")
    private String email;                    // email del cliente

    @NotBlank(message = "La marca del vehículo es obligatoria")
    private String marcaVehiculo;            // marca del vehículo

    @NotBlank(message = "El modelo del vehículo es obligatorio")
    private String modeloVehiculo;           // modelo del vehículo

    @NotNull(message = "El año del vehículo es obligatorio")
    @Min(value = 1900, message = "Año del vehículo inválido")
    @Max(value = 2030, message = "Año del vehículo inválido")
    private Integer anio;                    // año del vehículo

    // obtiene el id de la cotización
    public Long getIdCotizacion() {
        return idCotizacion;
    }

    // asigna el id de la cotización
    public void setIdCotizacion(Long idCotizacion) {
        this.idCotizacion = idCotizacion;
    }

    // obtiene el nombre
    public String getNombre() {
        return nombre;
    }

    // asigna el nombre
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    // obtiene el email
    public String getEmail() {
        return email;
    }

    // asigna el email
    public void setEmail(String email) {
        this.email = email;
    }

    // obtiene la marca del vehículo
    public String getMarcaVehiculo() {
        return marcaVehiculo;
    }

    // asigna la marca del vehículo
    public void setMarcaVehiculo(String marcaVehiculo) {
        this.marcaVehiculo = marcaVehiculo;
    }

    // obtiene el modelo del vehículo
    public String getModeloVehiculo() {
        return modeloVehiculo;
    }

    // asigna el modelo del vehículo
    public void setModeloVehiculo(String modeloVehiculo) {
        this.modeloVehiculo = modeloVehiculo;
    }

    // obtiene el año del vehículo
    public Integer getAnio() {
        return anio;
    }

    // asigna el año del vehículo
    public void setAnio(Integer anio) {
        this.anio = anio;
    }
}
