<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nexared - Soluciones Integrales en Red</title>
    <link href="css/design.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
 <div class="app-container">
    <!-- Header con gradiente -->
    <header class="main-header">
        <div class="header-content">
            <div class="logo">
                <i class="fas fa-network-wired"></i>
                <span>Nexared</span>
            </div>
            <nav class="main-nav">
                <a href="user_products.jsp"><i class="fas fa-server"></i> Productos</a>
                <a href="user_category.jsp"><i class="fas fa-network-wired"></i> Categorias filtradas</a>
                <a href="charge.jsp"><i class="fas fa-headset"></i> Soporte</a>
                <a href="user_login.jsp" class="login-btn"><i class="fas fa-sign-in-alt"></i> Acceso</a>
            </nav>
        </div>
    </header>

    <!-- Hero Section con gradiente -->
    <section class="hero-section">
        <div class="hero-overlay"></div>
        <div class="hero-content">
            <h1>Conectividad <span>de Alto Rendimiento</span></h1>
            <p class="subtitle">Infraestructura de red escalable para negocios en crecimiento</p>
        </div>
    </section>

    <!-- Tarjetas de Beneficios -->
    <section class="benefits-section">
        <div class="section-header">
            <h2>¿Por qué elegir Nexared?</h2>
            <div class="divider"></div>
        </div>
        <div class="benefits-grid">
            <div class="benefit-card">
                <div class="card-icon" style="background-color: rgba(67, 97, 238, 0.1);">
                    <i class="fas fa-tachometer-alt" style="color: #4361ee;"></i>
                </div>
                <h3>Rendimiento Óptimo</h3>
                <p>Redes diseñadas para operar al máximo nivel incluso bajo carga pesada</p>
            </div>
            <div class="benefit-card">
                <div class="card-icon" style="background-color: rgba(86, 11, 173, 0.1);">
                    <i class="fas fa-shield-alt" style="color: #560bad;"></i>
                </div>
                <h3>Seguridad Integral</h3>
                <p>Protección multicapa para tus datos sensibles</p>
            </div>
            <div class="benefit-card">
                <div class="card-icon" style="background-color: rgba(114, 9, 183, 0.1);">
                    <i class="fas fa-expand" style="color: #7209b7;"></i>
                </div>
                <h3>Escalabilidad</h3>
                <p>Crecimiento sin preocupaciones por capacidad</p>
            </div>
        </div>
    </section>

    <!-- Mapa + Información -->
    <section class="map-info-section">
        <div class="map-container">
            <iframe src="https://www.google.com/maps/d/embed?mid=1Sa0FhfQCGNkiGXeqWm93lpHiI_KDRBU&ehbc=2E312F" width="100%" height="100%" style="border:0;" allowfullscreen="" loading="lazy"></iframe>
        </div>
        <div class="info-container">
            <h2>Nuestra Presencia Global</h2>
            <div class="divider"></div>
            <p>Conectamos empresas en más de 15 países con soluciones de red adaptadas a cada mercado:</p>
            <ul class="features-list">
                <li><i class="fas fa-check" style="color: #4361ee;"></i> Soporte técnico 24/7 localizado</li>
                <li><i class="fas fa-check" style="color: #560bad;"></i> Implementación rápida y sin problemas</li>
                <li><i class="fas fa-check" style="color: #7209b7;"></i> Cumplimiento regulatorio regional</li>
            </ul>
            <a href="charge.jsp" class="learn-more-btn">Ver cobertura completa <i class="fas fa-arrow-right"></i></a>
        </div>
    </section>

    <!-- Footer -->
    <footer class="main-footer">
        <div class="footer-content">
            <div class="footer-brand">
                <i class="fas fa-network-wired"></i>
                <span>Nexared</span>
                <p>Revolucionando la conectividad desde 2025</p>
            </div>
            <div class="footer-links">
                <div class="link-group">
                    <h4>Soluciones</h4>
                    <a href="user_products.jsp">Productos</a>
                    <a href="user_category.jsp">Filtrar productos</a>
                </div>
                <div class="link-group">
                    <h4>Compañía</h4>
                    <a href="https://github.com/EonSoulCout">Nosotros</a>

                </div>
                <div class="link-group">
                    <h4>Contacto</h4>
                    <a href="tel:+123456789"><i class="fas fa-phone"></i> +593 984041911</a>
                    <a href="mailto:info@nexared.com"><i class="fas fa-envelope"></i> mateo1995espinosa@gmail.com</a>
                    <a href="#"><i class="fas fa-map-marker-alt"></i> Ubicaciones</a>
                </div>
            </div>
        </div>
        <div class="footer-bottom">
            <div class="social-links">
                <a href="https://www.facebook.com/SoulRhagnaros" style="background-color: #4361ee;"><i class="fab fa-facebook-f"></i></a>
                <a href="https://www.linkedin.com/in/mateo-espinosa-51955b361/" style="background-color: #560bad;"><i class="fab fa-linkedin-in"></i></a>
                <a href="#" style="background-color: #7209b7;"><i class="fab fa-twitter"></i></a>
            </div>
            <div class="copyright">
                <p>&copy; 2025 Nexared Technologies. Todos los derechos reservados.</p>
            </div>
        </div>
    </footer>
 </div>
</body>
</html>