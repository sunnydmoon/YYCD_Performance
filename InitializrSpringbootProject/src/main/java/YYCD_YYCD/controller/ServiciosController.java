package YYCD_YYCD.controller;

import YYCD_YYCD.domain.Servicio;          // importa la entidad Servicio
import YYCD_YYCD.service.ServicioService;  // importa el servicio de Servicios
import org.springframework.beans.factory.annotation.Autowired;  // para inyección de dependencias
import org.springframework.stereotype.Controller;               // marca la clase como controlador
import org.springframework.ui.Model;                            // para pasar datos a la vista
import org.springframework.web.bind.annotation.GetMapping;      // mapea peticiones GET
import org.springframework.web.bind.annotation.RequestMapping;  // mapea ruta base

@Controller                                  // declara controlador MVC
@RequestMapping("/servicios")                // ruta base "/servicios"
public class ServiciosController {

    private final ServicioService servicioService;  // servicio para datos

    @Autowired                               // inyecta el servicio
    public ServiciosController(ServicioService servicioService) {
        this.servicioService = servicioService;   // asigna servicio
    }

    @GetMapping                              // maneja GET en "/servicios"
    public String mostrarServicios(Model model) {
        model.addAttribute("servicios", servicioService.listarServicios()); // añade lista de servicios
        return "servicios/servicios";          // devuelve vista de servicios
    }
}
