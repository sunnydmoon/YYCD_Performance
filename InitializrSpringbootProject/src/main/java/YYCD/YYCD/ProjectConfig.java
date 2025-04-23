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

    @Bean
    public LocaleResolver localeResolver() {
        var slr = new SessionLocaleResolver();
        slr.setDefaultLocale(Locale.getDefault());
        slr.setLocaleAttributeName("session.current.locale");
        slr.setTimeZoneAttributeName("session.current.timezone");
        return slr;
    }

    @Bean
    public LocaleChangeInterceptor localeChangeInterceptor() {
        var lci = new LocaleChangeInterceptor();
        lci.setParamName("lang");
        return lci;
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(localeChangeInterceptor());
    }

    @Bean("messageSource")
    public MessageSource messageSource() {
        var ms = new ResourceBundleMessageSource();
        ms.setBasenames("messages");
        ms.setDefaultEncoding("UTF-8");
        return ms;
    }

    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        // Enlaza tus URLs directamente a los HTML estáticos en /static
        registry.addViewController("/").setViewName("forward:/index.html");
        registry.addViewController("/index").setViewName("forward:/index.html");
        registry.addViewController("/login").setViewName("forward:/LogIn.html");
        registry.addViewController("/registro/nuevo").setViewName("forward:/registro.html");
        registry.addViewController("/servicios").setViewName("forward:/servicios.html");
        registry.addViewController("/reviews").setViewName("forward:/review.html");
        registry.addViewController("/nosotros").setViewName("forward:/nosotros.html");
        registry.addViewController("/contacto").setViewName("forward:/contacto.html");
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .authorizeHttpRequests(auth -> auth
                // permite acceso a tus páginas estáticas y al formulario de login
                .requestMatchers(
                    "/", "/index", "/login", "/LogIn.html", "/perform_login",
                    "/registro/**", "/servicios/**", "/reviews/**",
                    "/nosotros/**", "/contacto/**",
                    "/js/**", "/static.img/**"
                ).permitAll()
                // resto de reglas de seguridad
                .requestMatchers(
                    "/usuario/nuevo", "/usuario/guardar",
                    "/usuario/modificar/**", "/usuario/eliminar/**",
                    "/reportes/**"
                ).hasRole("ADMIN")
                .requestMatchers("/usuario/listado").hasAnyRole("ADMIN", "VENDEDOR")
                .requestMatchers("/facturar/carrito").hasRole("USER")
                .anyRequest().authenticated()
            )
            .formLogin(form -> form
                .loginPage("/login")
                .loginProcessingUrl("/perform_login")
                .defaultSuccessUrl("/index", true)
                .failureUrl("/login?error")
                .permitAll()
            )
            .logout(logout -> logout
                .logoutUrl("/logout")
                .logoutSuccessUrl("/index")
                .permitAll()
            );
        return http.build();
    }

    @Bean
    public UserDetailsService users() {
        UserDetails admin = User.builder()
            .username("juan").password("{noop}123")
            .roles("USER","VENDEDOR","ADMIN").build();
        UserDetails sales = User.builder()
            .username("rebeca").password("{noop}456")
            .roles("USER","VENDEDOR").build();
        UserDetails user  = User.builder()
            .username("david").password("{noop}123")
            .roles("USER").build();
        return new InMemoryUserDetailsManager(user, sales, admin);
    }
}
