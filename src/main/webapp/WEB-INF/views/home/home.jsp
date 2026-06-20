<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en" class="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AuraWear — Premium Streetwear & Fashion</title>
    <meta name="description" content="AuraWear — Bold drops. Curated collections. Premium streetwear for Men & Women.">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800;900&family=Inter:wght@400;500;600&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${ctx}/assets/css/home.css">
    <style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
            vertical-align: middle;
        }
        /* Toast notification styling */
        #aw-toast {
            position: fixed;
            bottom: 40px;
            right: 40px;
            background: var(--border-color-solid);
            color: var(--bg-color);
            padding: 16px 28px;
            font-size: 11px;
            font-weight: 800;
            letter-spacing: 2px;
            z-index: 99999;
            text-transform: uppercase;
            box-shadow: 6px 6px 0px var(--accent-color);
            border: 2px solid var(--border-color-solid);
            transform: translateY(20px);
            opacity: 0;
            pointer-events: none;
            transition: all 0.3s cubic-bezier(0.2, 0.8, 0.2, 1);
        }
        #aw-toast.show {
            transform: translateY(0);
            opacity: 1;
            pointer-events: auto;
        }
    </style>
</head>
<body>
    <c:set var="isHome" value="true" scope="request" />
    <jsp:include page="../partials/navbar.jsp" />

    <!-- Hero Section -->
    <section class="hero-section">
        <img alt="High-fashion editorial streetwear" class="hero-bg-img" src="${ctx}/assets/images/hero-main.jpg" onerror="this.src='${ctx}/assets/images/fallback.jpg'"/>
        <div class="hero-overlay"></div>
        <div class="hero-content">
            <p class="hero-eyebrow">AW '25 — NEW ARRIVAL</p>
            <h1 class="hero-title">Essential Silhouettes. Refined for the Everyday.</h1>
            <div class="hero-buttons">
                <a href="${ctx}/products" class="btn btn-primary">Explore Collection</a>
            </div>
        </div>
    </section>

    <!-- Category Tiles -->
    <section class="category-section">
        <div class="category-grid">
            <!-- MEN -->
            <a class="category-tile group" href="${ctx}/products?gender=Men">
                <img alt="Men's Collection" class="category-img" src="${ctx}/assets/images/over1.jpg" onerror="this.src='${ctx}/assets/images/fallback.jpg'"/>
                <div class="category-overlay">
                    <span class="category-label">Men</span>
                </div>
            </a>
            <!-- WOMEN -->
            <a class="category-tile group" href="${ctx}/products?gender=Women">
                <img alt="Women's Collection" class="category-img" src="${ctx}/assets/images/over3.jpg" onerror="this.src='${ctx}/assets/images/fallback.jpg'"/>
                <div class="category-overlay">
                    <span class="category-label">Women</span>
                </div>
            </a>
            <!-- FOOTWEAR -->
            <a class="category-tile group" href="${ctx}/products?category=Footwear">
                <img alt="Footwear" class="category-img" src="${ctx}/assets/images/sneak1.jpg" onerror="this.src='${ctx}/assets/images/fallback.jpg'"/>
                <div class="category-overlay">
                    <span class="category-label">Footwear</span>
                </div>
            </a>
            <!-- ACCESSORIES -->
            <a class="category-tile group" href="${ctx}/products?category=Accessories">
                <img alt="Accessories" class="category-img" src="${ctx}/assets/images/bag1.jpg" onerror="this.src='${ctx}/assets/images/fallback.jpg'"/>
                <div class="category-overlay">
                    <span class="category-label">Accessories</span>
                </div>
            </a>
        </div>
    </section>

    <!-- Featured Products -->
    <section class="products-section">
        <h2 class="section-title">New Drops</h2>
        <div class="products-grid">
            <c:forEach var="p" items="${products}">
                <div class="product-card ${p.stockQuantity == 0 ? 'oos-card' : ''}" 
                     onclick="goToProduct('${p.id}')"
                     data-id="${p.id}" data-name="${p.name}" data-price="${p.price}" data-size="M">
                     <div class="product-image-container">
                        <img class="product-image" 
                             src="<c:choose><c:when test="${fn:startsWith(p.image, 'http')}">${p.image}</c:when><c:otherwise>${ctx}/assets/images/${p.image}</c:otherwise></c:choose>"
                             onerror="this.src='${ctx}/assets/images/fallback.jpg'"
                             alt="${p.name}">
                        
                        <c:choose>
                            <c:when test="${p.stockQuantity == 0}">
                                <div class="product-badge badge-oos">OUT OF STOCK</div>
                            </c:when>
                            <c:when test="${p.stockQuantity <= 5}">
                                <div class="product-badge badge-low-stock">🔥 ONLY ${p.stockQuantity} LEFT!</div>
                            </c:when>
                            <c:otherwise>
                                <div class="product-badge badge-new">NEW</div>
                            </c:otherwise>
                        </c:choose>

                        <button class="wishlist-btn ${not empty wishlistNames and wishlistNames.contains(p.id) ? 'active' : ''}" 
                                data-id="${p.id}"
                                onclick="toggleWishlist(event, this)">
                            <span class="material-symbols-outlined" style="${not empty wishlistNames and wishlistNames.contains(p.id) ? 'font-variation-settings: \'FILL\' 1;' : ''}">favorite</span>
                        </button>
                        
                        <button class="add-to-bag-btn ${p.stockQuantity == 0 ? 'disabled' : ''}" 
                                data-id="${p.id}" 
                                data-size="M" 
                                data-price="${p.price}" 
                                onclick="quickAdd(event)"
                                ${p.stockQuantity == 0 ? 'disabled' : ''}>
                            ${p.stockQuantity == 0 ? 'OUT OF STOCK' : '+ ADD TO BAG'}
                        </button>
                    </div>
                    <div class="product-info">
                        <p class="product-category">${p.category}</p>
                        <div class="product-title-row">
                            <h4 class="product-name">${p.name}</h4>
                            <span class="product-price">₹<fmt:formatNumber value="${p.price}" maxFractionDigits="0"/></span>
                        </div>
                        <div class="product-rating">
                            <span class="material-symbols-outlined">star</span>
                            <span class="rating-value">(${p.rating} ★)</span>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </section>

    <!-- Trust Badges -->
    <section class="trust-badges-section">
        <div class="trust-badges-container">
            <span class="trust-badge-item">Complimentary Global Shipping</span>
            <span class="trust-badge-dot"></span>
            <span class="trust-badge-item">90-Day Returns</span>
            <span class="trust-badge-dot"></span>
            <span class="trust-badge-item">Secured Checkout</span>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer-section">
        <div class="footer-container">
            <div class="footer-brand-col">
                <div class="footer-logo">AURAWEAR</div>
                <p class="footer-desc">
                    PREMIUM STREETWEAR FOR THE BOLD. DEFINING THE AESTHETIC OF THE NEW ERA.
                </p>
                <div class="footer-socials">
                    <a href="#">INSTAGRAM</a>
                    <a href="#">TIKTOK</a>
                </div>
            </div>
            <div class="footer-links-col">
                <h5 class="footer-heading">SHOP</h5>
                <ul class="footer-links-list">
                    <li><a href="${ctx}/products?gender=Men">MEN</a></li>
                    <li><a href="${ctx}/products?gender=Women">WOMEN</a></li>
                    <li><a href="${ctx}/products?category=Accessories">ACCESSORIES</a></li>
                    <li><a href="${ctx}/collections">COLLECTIONS</a></li>
                </ul>
            </div>
            <div class="footer-links-col">
                <h5 class="footer-heading">ACCOUNT</h5>
                <ul class="footer-links-list">
                    <li><a href="${ctx}/profile">PROFILE</a></li>
                    <li><a href="${ctx}/my-orders">ORDERS</a></li>
                    <li><a href="${ctx}/wishlist">WISHLIST</a></li>
                    <li><a href="${ctx}/cart">CART</a></li>
                </ul>
            </div>
            <div class="footer-links-col">
                <h5 class="footer-heading">HELP</h5>
                <ul class="footer-links-list">
                    <li><a href="${ctx}/my-orders">SHIPPING &amp; RETURNS</a></li>
                    <li><a href="javascript:void(0)" onclick="openSizeGuide()">SIZE GUIDE</a></li>
                    <li><a href="mailto:support@aurawear.com">CONTACT</a></li>
                </ul>
            </div>
        </div>
        <div class="footer-bottom-row">
            <p class="footer-copyright">© 2025 AURAWEAR. ALL RIGHTS RESERVED.</p>
        </div>
    </footer>

    <!-- TOAST -->
    <div id="aw-toast"></div>

    <script>
    const ctx = "${ctx}";

    window.addEventListener('scroll', () => {
        const nav = document.querySelector('.navbar');
        if (nav) nav.classList.toggle('scrolled', window.scrollY > 60);
    });

    function goToProduct(id) {
        window.location.href = ctx + "/product?id=" + id;
    }

    function toggleWishlist(e, el) {
        e.stopPropagation();
        const id = el.getAttribute("data-id");
        fetch(ctx + "/wishlist-toggle?id=" + id, {
            method: "GET",
            credentials: "include"
        })
        .then(res => {
            if (res.status === 401) { window.location.href = ctx + "/login"; return; }
            if (!res.ok) throw new Error("Server error");
            return res.text();
        })
        .then(status => {
            if (!status) return;
            const icon = el.querySelector("span");
            if (status.trim() === "added") {
                el.classList.add("active");
                if (icon) { icon.style.fontVariationSettings = "'FILL' 1"; }
                showToast("Added to wishlist ♡");
            } else {
                el.classList.remove("active");
                if (icon) { icon.style.fontVariationSettings = "'FILL' 0"; }
                showToast("Removed from wishlist");
            }
        })
        .catch(() => {
            showToast("Could not update wishlist. Try again.");
        });
    }

    function quickAdd(e) {
        e.stopPropagation();
        const btn = e.currentTarget;
        const id = btn.getAttribute("data-id");
        const size = btn.getAttribute("data-size");
        const price = btn.getAttribute("data-price");
        btn.disabled = true;
        btn.innerText = "Adding...";
        fetch(ctx + "/add-to-cart?id=" + id + "&size=" + encodeURIComponent(size || "M") + "&price=" + price, {
            credentials: "include"
        })
        .then(res => {
            if (res.status === 401) { window.location.href = ctx + "/login"; return; }
            if (!res.ok) throw new Error();
            return res.json();
        })
        .then(data => {
            if (!data) return;
            if (data.success) {
                btn.innerText = "Added ✓";
                showToast("Added to bag!");
                updateCartCount();
            } else {
                btn.innerText = "OUT OF STOCK";
                showToast(data.message || "Out of stock!");
            }
            setTimeout(() => {
                btn.disabled = !data.success;
                btn.innerText = data.success ? "+ ADD TO BAG" : "OUT OF STOCK";
            }, 1600);
        })
        .catch(() => {
            btn.disabled = false;
            btn.innerText = "+ ADD TO BAG";
        });
    }

    function updateCartCount() {
        fetch(ctx + "/cart-count", { credentials: "include" })
            .then(r => r.text())
            .then(c => { const el = document.getElementById("cart-count"); if (el) el.innerText = c; })
            .catch(() => {});
    }

    // Parallax effect on hero image
    window.addEventListener('scroll', () => {
        const scrolled = window.pageYOffset;
        const heroImg = document.querySelector('.hero-bg-img');
        if (heroImg) {
            heroImg.style.transform = `translateY(${scrolled * 0.05}px)`;
        }
    });

    function showToast(msg) {
        const t = document.getElementById("aw-toast");
        t.innerText = msg;
        t.classList.add("show");
        setTimeout(() => t.classList.remove("show"), 2800);
    }
    window.showToast = showToast;

    document.addEventListener("DOMContentLoaded", updateCartCount);
    </script>
    <script src="${ctx}/assets/js/app-interactions.js?v=11"></script>
</body>
</html>
