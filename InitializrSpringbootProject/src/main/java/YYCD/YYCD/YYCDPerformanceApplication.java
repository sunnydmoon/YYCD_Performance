package YYCD.YYCD;

import org.springframework.boot.SpringApplication;               // Importa clase para iniciar Spring Boot
import org.springframework.boot.autoconfigure.SpringBootApplication; // Importa anotación para configurar Spring Boot

@SpringBootApplication                   // Marca esta clase como aplicación Spring Boot
public class YYCDPerformanceApplication {

    public static void main(String[] args) { 
        // Arranca la aplicación Spring Boot
        SpringApplication.run(YYCDPerformanceApplication.class, args);
    }
}
