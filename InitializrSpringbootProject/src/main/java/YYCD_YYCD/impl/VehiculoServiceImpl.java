package YYCD_YYCD.impl;

import YYCD_YYCD.dao.VehiculoDao;
import YYCD_YYCD.domain.Vehiculo;
import YYCD_YYCD.service.VehiculoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class VehiculoServiceImpl implements VehiculoService {

    @Autowired
    private VehiculoDao vehiculoDao;

    @Override
    @Transactional(readOnly = true)
    public List<Vehiculo> getVehiculos(boolean disponibles) {
        var lista = vehiculoDao.findAll();
        if (disponibles) {
            lista.removeIf(e -> !e.isDisponible());
        }
        return lista;
    }

    @Override
    @Transactional(readOnly = true)
    public Vehiculo getVehiculoById(Long id) {
        return vehiculoDao.findById(id).orElse(null);
    }

    @Override
    @Transactional
    public void save(Vehiculo vehiculo) {
        vehiculoDao.save(vehiculo);
    }

    @Override
    @Transactional
    public void deleteById(Long id) {
        vehiculoDao.deleteById(id);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Vehiculo> buscarPorMarcaYModelo(String marca, String modelo) {
        return vehiculoDao.findByMarcaAndModelo(marca, modelo);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Vehiculo> buscarPorPrecio(double precioMin, double precioMax) {
        return vehiculoDao.findByPrecioBetween(precioMin, precioMax);
    }
}