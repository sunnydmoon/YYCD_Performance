package YYCD_YYCD.service;               // define paquete del servicio

import YYCD_YYCD.domain.Cotizacion;      // importa la entidad Cotizacion

public interface CotizacionService {    // declara interfaz para cotización
    Cotizacion crearCotizacion(Cotizacion cotizacion); // método que crea una cotización
}
