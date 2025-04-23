
package YYCD_YYCD.dao;

import YYCD_YYCD.domain.Review;      // importa la entidad Servicio
import org.springframework.data.jpa.repository.JpaRepository; // importa JPA para CRUD
import java.util.List;                 // importa List (para usar en consultas, si hace falta)

public interface ReviewDao extends JpaRepository<Review, Long>{
    
}
