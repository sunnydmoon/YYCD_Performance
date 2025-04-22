package YYCD_YYCD.impl;

import org.springframework.stereotype.Service;
import YYCD_YYCD.service.CotizacionService;
import YYCD_YYCD.domain.Cotizacion;

import java.util.concurrent.atomic.AtomicLong;

@Service
public class CotizacionServiceImpl implements CotizacionService {

    private AtomicLong contador = new AtomicLong(1);

    @Override
    public Cotizacion crearCotizacion(Cotizacion cotizacion) {
        cotizacion.setIdCotizacion(contador.getAndIncrement());
        
        return cotizacion;
    }
}
