package YYCD_YYCD.controller;

import YYCD_YYCD.domain.Servicio;
import YYCD_YYCD.service.ServicioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/servicios")
public class ServiciosController {

    private final ServicioService servicioService;

    @Autowired
    public ServiciosController(ServicioService servicioService) {
        this.servicioService = servicioService;
    }

    @GetMapping
    public String mostrarServicios(Model model) {
        model.addAttribute("servicios", servicioService.listarServicios());
        return "servicios/servicios"; 
    }
}