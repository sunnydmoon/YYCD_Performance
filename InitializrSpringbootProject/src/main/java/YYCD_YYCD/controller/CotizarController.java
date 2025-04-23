package YYCD_YYCD.controller;

import YYCD_YYCD.domain.Cotizacion;      // Entidad Cotizacion
import YYCD_YYCD.service.CotizacionService; // Servicio de Cotizacion
import org.springframework.beans.factory.annotation.Autowired; // Inyección de dependencias
import org.springframework.stereotype.Controller; // Marca la clase como controlador
import org.springframework.ui.Model;        // Para pasar datos a la vista
import org.springframework.validation.BindingResult; // Para validar formularios
import org.springframework.web.bind.annotation.*; // Anotaciones de mapeo
import org.springframework.web.servlet.mvc.support.RedirectAttributes; // Para redirecciones

import jakarta.validation.Valid;          // Para validación de datos

@Controller                             // Declara controlador MVC
public class CotizarController {

    @Autowired                          // Inyecta servicio de cotización
    private CotizacionService cotizacionService;

    @GetMapping("/cotizar")             // Muestra formulario de cotizar
    public String mostrarFormulario(Model model) {
        model.addAttribute("cotizacion", new Cotizacion()); // Agrega objeto vacío
        return "templates.apariencia/cotizar"; // Vista del formulario
    }

    @PostMapping("/cotizar")            // Procesa envío del formulario
    public String procesarCotizacion(
            @Valid @ModelAttribute("cotizacion") Cotizacion cotizacion, // Valida datos
            BindingResult result,       // Resultados de validación
            RedirectAttributes redirect) { // Para enviar atributos al redirect

        if (result.hasErrors()) {       // Si hay errores de validación
            return "templates.apariencia/cotizar"; // Regresa al formulario
        }

        Cotizacion nueva = cotizacionService.crearCotizacion(cotizacion); // Guarda cotización
        redirect.addAttribute("id", nueva.getIdCotizacion()); // Pasa ID a la URL
        return "redirect:/cotizacion-enviada"; // Redirige a página de confirmación
    }

    @GetMapping("/cotizacion-enviada")  // Muestra confirmación de envío
    public String mostrarConfirmacion(@RequestParam("id") Long id, Model model) {
        model.addAttribute("mensaje", "Tu cotización fue enviada con éxito. ID: " + id); // Mensaje
        return "templates.apariencia/cotizacion-enviada"; // Vista de confirmación
    }
}
