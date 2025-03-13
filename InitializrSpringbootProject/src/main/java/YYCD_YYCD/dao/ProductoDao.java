

package YYCD_YYCD.dao;

import YYCD_YYCD.domain.Producto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface ProductoDao extends JpaRepository <Producto, Long> {

}
