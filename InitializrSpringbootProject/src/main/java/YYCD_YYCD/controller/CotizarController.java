package YYCD_YYCD.controller;

import YYCD_YYCD.domain.Cotizacion;
import YYCD_YYCD.service.CotizacionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.validation.Valid;

@Controller
public class CotizarController {

    @Autowired
    private CotizacionService cotizacionService;

    @GetMapping("/cotizar")
    public String mostrarFormulario(Model model) {
        model.addAttribute("cotizacion", new Cotizacion());
        return "templates.apariencia/cotizar";
    }

    @PostMapping("/cotizar")
    public String procesarCotizacion(
            @Valid @ModelAttribute("cotizacion") Cotizacion cotizacion,
            BindingResult result,
            RedirectAttributes redirect) {

        if (result.hasErrors()) {
            return "templates.apariencia/cotizar";
        }

        Cotizacion nueva = cotizacionService.crearCotizacion(cotizacion);
        redirect.addAttribute("id", nueva.getIdCotizacion());
        return "redirect:/cotizacion-enviada";
    }

    @GetMapping("/cotizacion-enviada")
    public String mostrarConfirmacion(@RequestParam("id") Long id, Model model) {
        model.addAttribute("mensaje", "Tu cotización fue enviada con éxito. ID: " + id);
        return "templates.apariencia/cotizacion-enviada";
    }
}
