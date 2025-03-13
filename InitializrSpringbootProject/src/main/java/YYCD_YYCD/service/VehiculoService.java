package YYCD_YYCD.service;

import YYCD_YYCD.domain.Vehiculo;
import java.util.List;

public interface VehiculoService {

    List<Vehiculo> getVehiculos(boolean disponibles);

    public Vehiculo getVehiculoById(Long id);

    public void save(Vehiculo vehiculo);

    public void deleteById(Long id);

    public List<Vehiculo> buscarPorMarcaYModelo(String marca, String modelo);

    public List<Vehiculo> buscarPorPrecio(double precioMin, double precioMax);
}
