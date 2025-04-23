package YYCD_YYCD.service;

import YYCD_YYCD.domain.Servicio; // importa la entidad Servicio
import java.util.List; // importa la interfaz List

public interface ServicioService { // define operaciones de servicio
    List<Servicio> listarServicios(); // método para listar todos los servicios
}
