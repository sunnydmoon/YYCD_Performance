
package YYCD_YYCD.service;

import YYCD_YYCD.domain.Review;
import java.util.List;

public interface ReviewService {
    // Guardar un nuevo review
    Review saveReview(Review review);
    
    // Obtener todos los reviews
    List<Review> getAllReviews();
    
    // Obtener un review por su ID
    Review getReviewById(Long id);
    
    // Actualizar un review existente
    Review updateReview(Review review);
    
    // Eliminar un review por su ID
    void deleteReview(Long id);
}