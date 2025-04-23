package YYCD_YYCD.controller;

import YYCD_YYCD.domain.Review;
import YYCD_YYCD.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class ReviewController {

    private final ReviewService reviewService;

    @Autowired
    public ReviewController(ReviewService reviewService) {
        this.reviewService = reviewService;
    }

    // Mostrar la página de reviews
    @GetMapping("/review")
    public String showReviewPage(Model model) {
        List<Review> reviews = reviewService.getAllReviews();
        model.addAttribute("reviews", reviews);
        return "review";
    }

    // Procesar el formulario de review
    @PostMapping("/procesar-review")
    public String processReview(@RequestParam("rating") int rating,
                               @RequestParam("hp_before") String hpBefore,
                               @RequestParam("hp_after") String hpAfter,
                               @RequestParam("comment") String comment) {
        
        Review review = new Review();
        review.setPuntuacion(rating);
        // Construir un comentario que incluya los HP antes y después
        String comentarioCompleto = "HP Anterior: " + hpBefore + " | HP Resultado: " + hpAfter + " - " + comment;
        review.setComentario(comentarioCompleto);
        // Puedes asignar un valor por defecto al cliente o modificar el formulario para recolectar esta información
        review.setCliente("Cliente");
        
        reviewService.saveReview(review);
        
        // Redirigir de vuelta a la página de reviews
        return "redirect:/review";
    }

    // REST API para obtener todos los reviews (opcional, para uso con JavaScript/AJAX)
    @GetMapping("/api/reviews")
    @ResponseBody
    public ResponseEntity<List<Review>> getAllReviews() {
        List<Review> reviews = reviewService.getAllReviews();
        return new ResponseEntity<>(reviews, HttpStatus.OK);
    }
    
    // REST API para crear un nuevo review (opcional, para uso con JavaScript/AJAX)
    @PostMapping("/api/reviews")
    @ResponseBody
    public ResponseEntity<Review> createReview(@RequestBody Review review) {
        Review savedReview = reviewService.saveReview(review);
        return new ResponseEntity<>(savedReview, HttpStatus.CREATED);
    }
}