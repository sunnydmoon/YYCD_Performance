package YYCD.YYCD;

import java.util.Locale;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

@Configuration
public class ProjectConfig implements WebMvcConfigurer {

    // Crea y configura el locale por sesión
    @Bean
    public LocaleResolver localeResolver() {
        var slr = new SessionLocaleResolver();             // Usa sesión para locale
        slr.setDefaultLocale(Locale.getDefault());          // Fija idioma por defecto
        slr.setLocaleAttributeName("session.current.locale");    // Nombre atributo locale
        slr.setTimeZoneAttributeName("session.current.timezone"); // Nombre atributo zona
        return slr;
    }

    // Crea interceptor que lee parámetro "lang"
    @Bean
    public LocaleChangeInterceptor localeChangeInterceptor() {
        var lci = new LocaleChangeInterceptor();           // Intercepta cambio de idioma
        lci.setParamName("lang");                          // Parámetro para cambiar
        return lci;
    }

    // Registra el interceptor de idioma
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(localeChangeInterceptor()); // Añade interceptor a la cadena
    }

    // Carga archivos de mensajes para internacionalización
    @Bean("messageSource")
    public MessageSource messageSource() {
        ResourceBundleMessageSource messageSource = new ResourceBundleMessageSource();
        messageSource.setBasenames("messages");             // Nombre base de archivos
        messageSource.setDefaultEncoding("UTF-8");          // Codificación de archivos
        return messageSource;
    }

    // Asigna rutas simples a vistas sin lógica adicional
    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/").setViewName("index");                // Home
        registry.addViewController("/index").setViewName("index");          // Index
        registry.addViewController("/login").setViewName("login");          // Login
        registry.addViewController("/registro/nuevo").setViewName("registro/nuevo"); // Registro
        registry.addViewController("/servicios").setViewName("servicios/servicios"); // Servicios
        registry.addViewController("/reviews").setViewName("review/review");         // Reviews
        registry.addViewController("/nosotros").setViewName("nosotros/nosotros");    // Nosotros
        registry.addViewController("/contacto").setViewName("contacto/contacto");    // Contacto
    }

    // Define reglas de seguridad y acceso HTTP
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .authorizeHttpRequests((request) -> request
                .requestMatchers(
                    "/", "/index", "/errores/**",
                    "/js/**", "/webjars/**", "/registro/**",
                    "/servicios/**", "/reviews/**", "/nosotros/**", "/contacto/**"
                ).permitAll()                             // Rutas públicas
                .requestMatchers(
                    "/usuario/nuevo", "/usuario/guardar",
                    "/usuario/modificar/**", "/usuario/eliminar/**",
                    "/reportes/**"
                ).hasRole("ADMIN")                        // Solo ADMIN
                .requestMatchers("/usuario/listado")
                    .hasAnyRole("ADMIN", "VENDEDOR")      // ADMIN o VENDEDOR
                .requestMatchers("/facturar/carrito")
                    .hasRole("USER")                      // Solo USER
                .anyRequest().authenticated()             // Resto requiere login
            )
            .formLogin((form) -> form
                .loginPage("/login").permitAll()         // Página de login
            )
            .logout((logout) -> logout.permitAll());    // Permite logout
        return http.build();
    }

    // Usuarios en memoria (temporal hasta usar BD)
    @Bean
    public UserDetailsService users() {
        UserDetails admin = User.builder()
            .username("juan")                         // Usuario admin
            .password("{noop}123")                    // Contraseña sin encriptar
            .roles("USER", "VENDEDOR", "ADMIN")       // Roles completos
            .build();
        UserDetails sales = User.builder()
            .username("rebeca")                       // Usuario vendedor
            .password("{noop}456")
            .roles("USER", "VENDEDOR")
            .build();
        UserDetails user = User.builder()
            .username("david")                        // Usuario normal
            .password("{noop}123")
            .roles("USER")
            .build();
        return new InMemoryUserDetailsManager(user, sales, admin); // Gestiona usuarios
    }
}
