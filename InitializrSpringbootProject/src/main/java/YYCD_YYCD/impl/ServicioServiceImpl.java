package YYCD_YYCD.impl;

import java.util.List;                         // ← añade esta línea
import YYCD_YYCD.dao.ServicioDao;              
import YYCD_YYCD.domain.Servicio;              
import YYCD_YYCD.service.ServicioService;      
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ServicioServiceImpl implements ServicioService {

    @Autowired
    private ServicioDao serviciodao;

    @Override
    public List<Servicio> listarServicios() {
        return serviciodao.findAll();
    }
}
