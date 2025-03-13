package YYCD_YYCD.dao;

import YYCD_YYCD.domain.Vehiculo;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface VehiculoDao extends JpaRepository<Vehiculo, Long> {

    List<Vehiculo> findByMarcaAndModeloAndAño(String marca, String modelo, int año);

    List<Vehiculo> findByMarcaAndModelo(String marca, String modelo);

    List<Vehiculo> findByPrecioBetween(double precioMin, double precioMax);

    List<Vehiculo> findByEstado(String estado);

    List<Vehiculo> findByCategoriaNombre(String nombreCategoria);
}