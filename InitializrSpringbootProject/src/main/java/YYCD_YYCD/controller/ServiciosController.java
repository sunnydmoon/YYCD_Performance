package YYCD_YYCD.controller;

import YYCD_YYCD.domain.Vehiculo;
import YYCD_YYCD.service.VehiculoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import org.springframework.http.HttpStatus;

@RestController
@RequestMapping("/api/vehiculos")
public class VehiculoController {

    @Autowired
    private VehiculoService vehiculoService;

    // Obtener todos los vehículos 
    @GetMapping("/")
    public ResponseEntity<List<Vehiculo>> getVehiculos(@RequestParam(required = false) Boolean disponibles) {
        List<Vehiculo> vehiculos;
        if (disponibles != null) {
            vehiculos = vehiculoService.getVehiculos(disponibles);
        } else {
            vehiculos = vehiculoService.getVehiculos(false); // O devuelve todos si no se especifica
        }
        return ResponseEntity.ok(vehiculos);
    }

    // Obtener un vehículo por su ID
    @GetMapping("/{id}")
    public ResponseEntity<Vehiculo> getVehiculo(@PathVariable Long id) {
        Vehiculo vehiculo = vehiculoService.getVehiculoById(id);
        if (vehiculo != null) {
            return ResponseEntity.ok(vehiculo);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    // Guardar un vehículo
    @PostMapping("/")
    public ResponseEntity<Void> saveVehiculo(@RequestBody Vehiculo vehiculo) {
        vehiculoService.save(vehiculo);
        return ResponseEntity.status(HttpStatus.CREATED).build();
    }

    // Eliminar un vehículo por su ID
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteVehiculo(@PathVariable Long id) {
        vehiculoService.deleteById(id);
        return ResponseEntity.noContent().build();
    }

    // Buscar vehículos por marca y modelo
    @GetMapping("/buscar")
    public ResponseEntity<List<Vehiculo>> buscarPorMarcaYModelo(
            @RequestParam String marca,
            @RequestParam String modelo) {
        List<Vehiculo> vehiculos = vehiculoService.buscarPorMarcaYModelo(marca, modelo);
        return ResponseEntity.ok(vehiculos);
    }

    // Buscar vehículos por rango de precios
    @GetMapping("/precio")
    public ResponseEntity<List<Vehiculo>> buscarPorPrecio(
            @RequestParam double precioMin,
            @RequestParam double precioMax) {
        List<Vehiculo> vehiculos = vehiculoService.buscarPorPrecio(precioMin, precioMax);
        return ResponseEntity.ok(vehiculos);
    }
}