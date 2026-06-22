<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />



<link rel="stylesheet" href="${ctx}/assets/css/navbar.css?v=122">
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" rel="stylesheet" />

<div class="top-strip">
    <div>Shipping on all orders above ₹999</div>
    <div class="top-right">
        <a href="${ctx}/my-orders">Track Order</a>
        <a href="${ctx}/my-orders">Returns</a>
        <a href="javascript:void(0)" onclick="openSizeGuide()">Size Guide</a>
        <a href="mailto:support@aurawear.com">Contact</a>
    </div>
</div>

<!-- NAVBAR -->
<nav class="navbar">
    <div class="navbar-container">
        <!-- Brand Logo -->
        <div class="brand">
            <a href="${ctx}/home">AuraWear</a>
        </div>

        <!-- Center Navigation Links -->
        <c:set var="reqServletPath" value="${requestScope['jakarta.servlet.forward.servlet_path']}" />
        <c:set var="isProductsView" value="${reqServletPath == '/WEB-INF/views/products/products.jsp' || reqServletPath == '/WEB-INF/views/product-detail.jsp'}" />
        <c:set var="isCollectionsView" value="${reqServletPath == '/WEB-INF/views/collections/collections.jsp'}" />
        
        <div class="nav-links">
            <a href="${ctx}/products" class="${isProductsView && empty param.category && empty param.gender ? 'active' : ''}">Shop All</a>
            <a href="${ctx}/products?gender=Men" class="${isProductsView && param.gender == 'Men' ? 'active' : ''}">New Arrivals</a>
            <a href="${ctx}/products?category=Accessories" class="${isProductsView && param.category == 'Accessories' ? 'active' : ''}">Essentials</a>
            <a href="${ctx}/collections" class="${isCollectionsView ? 'active' : ''}">Collections</a>
        </div>

        <!-- Right Side Utility Icons -->
        <div class="nav-icons">
            <div class="search-box">
                <form action="${ctx}/products" method="get">
                    <button type="submit" aria-label="Search">
                        <span class="material-symbols-outlined">search</span>
                    </button>
                    <input type="text" name="keyword" placeholder="Search" value="${param.keyword}" autocomplete="off">
                </form>
            </div>
            
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <a href="${ctx}/wishlist" title="Wishlist">
                        <span class="material-symbols-outlined">favorite</span>
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="#" onclick="openLoginModal(); return false;" title="Wishlist">
                        <span class="material-symbols-outlined">favorite</span>
                    </a>
                </c:otherwise>
            </c:choose>

            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <a href="${ctx}/cart" class="cart-link" title="Cart">
                        <div class="nav-icon-wrap">
                            <span class="material-symbols-outlined">shopping_bag</span>
                            <span id="cart-count" class="cart-badge">0</span>
                        </div>
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="#" onclick="openLoginModal(); return false;" class="cart-link" title="Cart">
                        <div class="nav-icon-wrap">
                            <span class="material-symbols-outlined">shopping_bag</span>
                            <span id="cart-count" class="cart-badge">0</span>
                        </div>
                    </a>
                </c:otherwise>
            </c:choose>

            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <a href="${ctx}/profile" title="Account">
                        <span class="material-symbols-outlined">person</span>
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="#" onclick="openLoginModal(); return false;" title="Account">
                        <span class="material-symbols-outlined">person</span>
                    </a>
                </c:otherwise>
            </c:choose>

            <!-- Mobile Menu Hamburger Trigger -->
            <a href="#" class="menu-trigger-btn mobile-menu-trigger" onclick="openMenuOverlay(); return false;" title="Open Menu" aria-label="Menu">
                <span class="menu-icon-bars">
                    <span class="bar bar-1"></span>
                    <span class="bar bar-2"></span>
                    <span class="bar bar-3"></span>
                </span>
            </a>
        </div>
    </div>
</nav>

<!-- LUXURY OVERLAY MENU -->
<div class="menu-overlay" id="menuOverlay">
    <div class="menu-header">
        <div class="menu-logo">AW</div>
        <button class="menu-close-btn" onclick="closeMenuOverlay()"><i class="fa-solid fa-xmark"></i></button>
    </div>
    
    <!-- MOBILE-ONLY SEARCH BOX IN OVERLAY -->
    <div class="mobile-search-box">
        <form action="${ctx}/products" method="get">
            <input type="text" name="keyword" placeholder="Search for products..." value="${param.keyword}">
            <button type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
        </form>
    </div>

    <div class="menu-grid">
        <div class="menu-col">
            <h4>Collections</h4>
            <div class="menu-list">
                <a href="${ctx}/collections" class="menu-item">Noir Drop</a>
                <a href="${ctx}/collections" class="menu-item">Minimalist</a>
                <a href="${ctx}/collections" class="menu-item">Street Uniform</a>
                <a href="${ctx}/products" class="menu-item-sub">&rarr; Browse Lookbook</a>
            </div>
        </div>
        <div class="menu-col">
            <h4>Store Catalog</h4>
            <div class="menu-list">
                <a href="${ctx}/products" class="menu-item">Shop All</a>
                <a href="${ctx}/products?gender=Men" class="menu-item">Men's Wear</a>
                <a href="${ctx}/products?gender=Women" class="menu-item">Women's Wear</a>
                <a href="${ctx}/products?category=Footwear" class="menu-item-sub">Footwear</a>
                <a href="${ctx}/products?category=Accessories" class="menu-item-sub">Accessories</a>
            </div>
        </div>
        <div class="menu-col">
            <h4>Atmosphere</h4>
            <p class="menu-poetics">
                AW '25 drop redefines street luxury through structural silhouettes, textured weight, and dynamic aura identities.
            </p>
            <div class="menu-list">
                <a href="${ctx}/profile" class="menu-item-sub">My Profile</a>
                <a href="${ctx}/my-orders" class="menu-item-sub">Order Tracking</a>
                <a href="${ctx}/wishlist" class="menu-item-sub">Wishlist</a>
            </div>
            <div class="menu-footer">
                <span>© 2025 AuraWear</span>
                <a href="#">Instagram</a>
                <a href="#">X.com</a>
            </div>
        </div>
    </div>
</div>





<!-- HIGH-END ANALOGUE FILM GRAIN NOISE OVERLAY -->
<div class="noise-overlay"></div>

<!-- LOGIN MODAL -->
<jsp:include page="/WEB-INF/views/partials/login-modal.jsp" />

<!-- SIZE GUIDE MODAL -->
<div class="size-overlay" id="sizeOverlay" onclick="closeSizeGuide(event)">
    <div class="size-modal" id="sizeModal">
        <button class="modal-close" onclick="closeSizeGuide()">
            <i class="fa-solid fa-xmark"></i>
        </button>

        <div class="modal-brand">
            <span class="modal-brand-logo">AW</span>
            <div>
                <div class="modal-brand-name">AURAWEAR</div>
                <div class="modal-brand-sub">SIZE GUIDE MATRIX</div>
            </div>
        </div>

        <h2 class="modal-title">Size Guide</h2>
        <p class="modal-sub">Find your perfect fit. Our silhouettes are designed to be modern, relaxed, and slightly oversized.</p>

        <div class="size-tabs">
            <button class="size-tab-btn active" onclick="switchSizeTab('tops', this)">Tops / Outerwear</button>
            <button class="size-tab-btn" onclick="switchSizeTab('bottoms', this)">Bottoms</button>
            <button class="size-tab-btn" onclick="switchSizeTab('footwear', this)">Footwear</button>
        </div>

        <!-- Tops Table -->
        <div class="size-tab-content active" id="tab-tops">
            <table class="size-table">
                <thead>
                    <tr>
                        <th>Size</th>
                        <th>Chest (in)</th>
                        <th>Length (in)</th>
                        <th>Shoulder (in)</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><strong>S</strong></td>
                        <td>38 - 40</td>
                        <td>27.5</td>
                        <td>19.0</td>
                    </tr>
                    <tr>
                        <td><strong>M</strong></td>
                        <td>40 - 42</td>
                        <td>28.5</td>
                        <td>19.5</td>
                    </tr>
                    <tr>
                        <td><strong>L</strong></td>
                        <td>42 - 44</td>
                        <td>29.5</td>
                        <td>20.0</td>
                    </tr>
                    <tr>
                        <td><strong>XL</strong></td>
                        <td>44 - 46</td>
                        <td>30.5</td>
                        <td>20.5</td>
                    </tr>
                    <tr>
                        <td><strong>XXL</strong></td>
                        <td>46 - 48</td>
                        <td>31.5</td>
                        <td>21.0</td>
                    </tr>
                </tbody>
            </table>
        </div>

        <!-- Bottoms Table -->
        <div class="size-tab-content" id="tab-bottoms">
            <table class="size-table">
                <thead>
                    <tr>
                        <th>Size</th>
                        <th>Waist (in)</th>
                        <th>Inseam (in)</th>
                        <th>Outseam (in)</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><strong>S (30)</strong></td>
                        <td>28 - 30</td>
                        <td>30.0</td>
                        <td>40.0</td>
                    </tr>
                    <tr>
                        <td><strong>M (32)</strong></td>
                        <td>30 - 32</td>
                        <td>31.0</td>
                        <td>41.0</td>
                    </tr>
                    <tr>
                        <td><strong>L (34)</strong></td>
                        <td>32 - 34</td>
                        <td>31.5</td>
                        <td>42.0</td>
                    </tr>
                    <tr>
                        <td><strong>XL (36)</strong></td>
                        <td>34 - 36</td>
                        <td>32.0</td>
                        <td>43.0</td>
                    </tr>
                </tbody>
            </table>
        </div>

        <!-- Footwear Table -->
        <div class="size-tab-content" id="tab-footwear">
            <table class="size-table">
                <thead>
                    <tr>
                        <th>US Size</th>
                        <th>UK Size</th>
                        <th>EU Size</th>
                        <th>Foot Length (cm)</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><strong>7</strong></td>
                        <td>6</td>
                        <td>40</td>
                        <td>25.0</td>
                    </tr>
                    <tr>
                        <td><strong>8</strong></td>
                        <td>7</td>
                        <td>41</td>
                        <td>26.0</td>
                    </tr>
                    <tr>
                        <td><strong>9</strong></td>
                        <td>8</td>
                        <td>42</td>
                        <td>27.0</td>
                    </tr>
                    <tr>
                        <td><strong>10</strong></td>
                        <td>9</td>
                        <td>43</td>
                        <td>28.0</td>
                    </tr>
                    <tr>
                        <td><strong>11</strong></td>
                        <td>10</td>
                        <td>44</td>
                        <td>29.0</td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div class="modal-perks size-guide-modal-perks">
            <span>📐 Oversized Fit Guarantee</span>
            <span>⚡ Order standard size for a premium relaxed drape</span>
            <span>🌌 Size down for a classic, traditional fit</span>
        </div>
    </div>
</div>

<script>


function updateCartCount() {
    fetch("${ctx}/cart-count", { credentials: "include" })
        .then(res => res.text())
        .then(count => {
            const el = document.getElementById("cart-count");
            if (el) el.innerText = count;
        });
}

function openMenuOverlay() {
    const el = document.getElementById("menuOverlay");
    if (el) {
        el.classList.add("active");
        document.body.style.overflow = "hidden";
    }
}

function closeMenuOverlay() {
    const el = document.getElementById("menuOverlay");
    if (el) {
        el.classList.remove("active");
        document.body.style.overflow = "";
    }
}

function initAuraInteractive() {



    // ── Update Cart Count
    updateCartCount();



    // ── Aura Click Ripple
    document.addEventListener("click", (e) => {
        if (e.button !== 0) return; // Only left clicks
        
        const ripple = document.createElement("div");
        ripple.className = "click-aura-ripple";
        ripple.style.left = e.clientX + "px";
        ripple.style.top = e.clientY + "px";
        document.body.appendChild(ripple);
        
        ripple.addEventListener("animationend", () => {
            ripple.remove();
        });
    });

    // ── Scroll Reveal Intersection Observer Setup
    const revealObserver = new IntersectionObserver((entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add("reveal-active");
                observer.unobserve(entry.target);
            }
        });
    }, {
        threshold: 0.1,
        rootMargin: "0px 0px -40px 0px"
    });

    const setupScrollObserver = () => {
        const elms = document.querySelectorAll("[data-scroll-reveal]:not(.observed)");
        elms.forEach(el => {
            el.classList.add("observed");
            revealObserver.observe(el);
        });
    };
    setupScrollObserver();

    // ── Typographical Entrance Reveal
    setTimeout(() => {
        const firstFoldElements = document.querySelectorAll(
            ".hero [data-scroll-reveal], .cat-panels [data-scroll-reveal], .statement [data-scroll-reveal]"
        );
        firstFoldElements.forEach(el => {
            el.classList.add("reveal-active");
        });
    }, 0);

    // Re-bind scroll reveal for dynamically parsed elements
    const scrollMutationObserver = new MutationObserver(setupScrollObserver);
    scrollMutationObserver.observe(document.body, { childList: true, subtree: true });
}

if (document.readyState === "loading") {
    window.addEventListener("DOMContentLoaded", initAuraInteractive);
} else {
    initAuraInteractive();
}

// ── SIZE GUIDE MODAL FUNCTIONS ───────────────────────────
function openSizeGuide() {
    const el = document.getElementById("sizeOverlay");
    if (el) {
        el.classList.add("active");
        document.body.style.overflow = "hidden";
    }
}

function closeSizeGuide(e) {
    if (e && e.target !== document.getElementById("sizeOverlay")) return;
    const el = document.getElementById("sizeOverlay");
    if (el) {
        el.classList.remove("active");
        document.body.style.overflow = "";
    }
}

function switchSizeTab(tabId, btn) {
    if (btn) {
        const buttons = btn.parentElement.querySelectorAll('.size-tab-btn');
        buttons.forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
    }
    
    const contents = document.querySelectorAll('.size-tab-content');
    contents.forEach(c => c.classList.remove('active'));
    
    const activeContent = document.getElementById('tab-' + tabId);
    if (activeContent) {
        activeContent.classList.add('active');
    }
}

document.addEventListener("keydown", function(e) {
    if (e.key === "Escape") {
        const sizeOverlay = document.getElementById("sizeOverlay");
        if (sizeOverlay && sizeOverlay.classList.contains("active")) {
            sizeOverlay.classList.remove("active");
            document.body.style.overflow = "";
        }
    }
});



// ── DYNAMIC GLOBAL FAVICON INJECTION ──────────────────────────
(function() {
    let link = document.querySelector("link[rel*='icon']");
    if (!link) {
        link = document.createElement('link');
        link.rel = 'icon';
        document.head.appendChild(link);
    }
    link.type = 'image/svg+xml';
    link.href = 'data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32"><circle cx="16" cy="16" r="16" fill="%230d0d0d"/><text x="50%" y="58%" dominant-baseline="middle" text-anchor="middle" font-family="%27Outfit%27, sans-serif" font-weight="900" font-size="13" fill="%23ede4dd" letter-spacing="-0.5">AW</text></svg>';
})();
</script>
