package YYCD_YYCD.impl;

import YYCD_YYCD.dao.ServicioDao;               // acceso a datos de servicios
import YYCD_YYCD.domain.Servicio;               // entidad Servicio
import YYCD_YYCD.service.ServicioService;       // interfaz del servicio
import org.springframework.beans.factory.annotation.Autowired;  // inyecta dependencias
import org.springframework.stereotype.Service;               // marca como servicio Spring
import org.springframework.transaction.annotation.Transactional; // habilita transacciones

@Service                                       // registra este Bean como servicio
public class ServicioServiceImpl implements ServicioService {

    @Autowired                                 // inyecta el DAO de servicios
    private ServicioDao serviciodao;

    @Override                                  // implementa método de la interfaz
    public List<Servicio> listarServicios() {
        return serviciodao.findAll();          // retorna lista de servicios
    }
}
