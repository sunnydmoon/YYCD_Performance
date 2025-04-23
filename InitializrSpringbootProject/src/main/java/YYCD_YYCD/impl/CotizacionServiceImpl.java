package YYCD_YYCD.impl;

import org.springframework.stereotype.Service;        // importa anotación Service
import YYCD_YYCD.service.CotizacionService;          // importa interfaz de servicio
import YYCD_YYCD.domain.Cotizacion;                  // importa entidad Cotizacion

import java.util.concurrent.atomic.AtomicLong;        // importa contador atómico

@Service                                      // marca esta clase como servicio
public class CotizacionServiceImpl implements CotizacionService {

    private AtomicLong contador = new AtomicLong(1);  // contador de IDs

    @Override
    public Cotizacion crearCotizacion(Cotizacion cotizacion) {
        cotizacion.setIdCotizacion(contador.getAndIncrement()); // asigna ID único
        return cotizacion;                                     // devuelve objeto
    }
}
