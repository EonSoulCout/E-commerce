<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Productos - Nexared</title>
    <link href="css/des_products.css" rel="stylesheet" type="text/css">
</head>
<body>
<main>
    <nav>
        <a href="index.jsp">Inicio</a>
<!--       <a href="products.jsp" class="active">Productos</a> -->
        <a href="charge.jsp">Servicios</a>
        <a href="charge.jsp">Login</a>
        <a href="charge.jsp">Sobre nosotros</a>
        <a href="charge.jsp">Ubicación</a>
    </nav>

    <div class="layout">
        <aside class="filters">
            <h3>Filtrar productos</h3>
            <form action="products.jsp" method="get">
                <div class="filter-group">
                    <h4>Categoría</h4>
                    <label><input type="checkbox" name="category" value="Cables"> Cables</label>
                    <label><input type="checkbox" name="category" value="Conectores"> Conectores</label>
                    <label><input type="checkbox" name="category" value="Hubs"> Hubs</label>
                </div>
                <div class="filter-group">
                    <h4>Clasificación</h4>
                    <label><input type="checkbox" name="classification" value="Alta"> Alta</label>
                    <label><input type="checkbox" name="classification" value="Media"> Media</label>
                    <label><input type="checkbox" name="classification" value="Baja"> Baja</label>
                </div>
                <button type="submit">Aplicar filtros</button>
            </form>
        </aside>

        <section class="products">
            <h3>Productos</h3>
            <div class="products-container">
                <div class="product-card" data-category="Cables" data-classification="Alta">
                    <img src="images/product1.jpg" alt="Producto 1">
                    <h4>Producto 1</h4>
                    <p>Descripción del producto 1.</p>
                    <span>$10.00</span>
                    <button>Agregar al carrito</button>
                </div>
                <div class="product-card" data-category="Conectores" data-classification="Media">
                    <img src="images/product2.jpg" alt="Producto 2">
                    <h4>Producto 2</h4>
                    <p>Descripción del producto 2.</p>
                    <span>$15.00</span>
                    <button>Agregar al carrito</button>
                </div>
                <div class="product-card" data-category="Hubs" data-classification="Baja">
                    <img src="images/product3.jpg" alt="Producto 3">
                    <h4>Producto 3</h4>
                    <p>Descripción del producto 3.</p>
                    <span>$20.00</span>
                    <button>Agregar al carrito</button>
                </div>
                <div class="product-card" data-category="Cables" data-classification="Alta">
                    <img src="images/product4.jpg" alt="Producto 4">
                    <h4>Producto 4</h4>
                    <p>Descripción del producto 4.</p>
                    <span>$25.00</span>
                    <button>Agregar al carrito</button>
                </div>
                <div class="product-card" data-category="Conectores" data-classification="Alta">
                    <img src="images/product5.jpg" alt="Producto 5">
                    <h4>Producto 5</h4>
                    <p>Descripción del producto 5.</p>
                    <span>$30.00</span>
                    <button>Agregar al carrito</button>
                </div>
                <div class="product-card" data-category="Hubs" data-classification="Media">
                    <img src="images/product6.jpg" alt="Producto 6">
                    <h4>Producto 6</h4>
                    <p>Descripción del producto 6.</p>
                    <span>$35.00</span>
                    <button>Agregar al carrito</button>
                </div>
                <div class="product-card" data-category="Cables" data-classification="Baja">
                    <img src="images/product7.jpg" alt="Producto 7">
                    <h4>Producto 7</h4>
                    <p>Descripción del producto 7.</p>
                    <span>$40.00</span>
                    <button>Agregar al carrito</button>
                </div>
                <div class="product-card" data-category="Conectores" data-classification="Alta">
                    <img src="images/product8.jpg" alt="Producto 8">
                    <h4>Producto 8</h4>
                    <p>Descripción del producto 8.</p>
                    <span>$45.00</span>
                    <button>Agregar al carrito</button>
                </div>
            </div>
        </section>
    </div>

    <footer>
        <ul>
            <li><a href="#">Facebook</a></li>
            <li><a href="#">Instagram</a></li>
            <li><a href="#">Twitter</a></li>
        </ul>
    </footer>
</main>

<script>
    const filtersForm = document.querySelector('form');
    const productCards = document.querySelectorAll('.product-card');

    filtersForm.addEventListener('submit', function(event) {
        event.preventDefault();
        const selectedCategories = Array.from(filtersForm.querySelectorAll('input[name="category"]:checked')).map(input => input.value);
        const selectedClassifications = Array.from(filtersForm.querySelectorAll('input[name="classification"]:checked')).map(input => input.value);

        productCards.forEach(card => {
            const cardCategory = card.getAttribute('data-category');
            const cardClassification = card.getAttribute('data-classification');

            const matchesCategory = selectedCategories.length === 0 || selectedCategories.includes(cardCategory);
            const matchesClassification = selectedClassifications.length === 0 || selectedClassifications.includes(cardClassification);

            card.style.display = (matchesCategory && matchesClassification) ? 'block' : 'none';
        });
    });
</script>
</body>
</html>
