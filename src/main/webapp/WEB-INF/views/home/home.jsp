<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c"   uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn"  uri="jakarta.tags.functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html class="scroll-smooth" lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>AuraWear - High-End Minimalist Apparel</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800;900&family=Inter:wght@400;500;600&family=JetBrains+Mono:wght@400&family=Cormorant+Garamond:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <script id="tailwind-config">
        tailwind.config = {
          darkMode: "class",
          theme: {
            extend: {
              "colors": {
                      "on-secondary-fixed-variant": "#3d4b32",
                      "surface-dim": "#dcd9d9",
                      "surface": "#fcf9f8",
                      "surface-container-lowest": "#ffffff",
                      "on-error": "#ffffff",
                      "error": "#ba1a1a",
                      "surface-container": "#f0eded",
                      "on-error-container": "#93000a",
                      "on-background": "#1c1b1b",
                      "primary-fixed-dim": "#c6c6c6",
                      "inverse-on-surface": "#f3f0ef",
                      "on-primary-fixed-variant": "#474747",
                      "primary-fixed": "#e2e2e2",
                      "surface-container-highest": "#e5e2e1",
                      "primary": "#000000",
                      "on-tertiary": "#ffffff",
                      "secondary-container": "#d5e5c3",
                      "tertiary-container": "#1b1b1b",
                      "outline-variant": "#cfc4c5",
                      "surface-bright": "#fcf9f8",
                      "on-primary": "#ffffff",
                      "secondary": "#546348",
                      "inverse-primary": "#c6c6c6",
                      "on-tertiary-fixed-variant": "#474747",
                      "surface-container-high": "#eae7e7",
                      "surface-container-low": "#f6f3f2",
                      "secondary-fixed": "#d8e8c6",
                      "on-secondary-container": "#59674c",
                      "on-primary-container": "#848484",
                      "inverse-surface": "#313030",
                      "primary-container": "#1b1b1b",
                      "background": "#fcf9f8",
                      "tertiary-fixed": "#e2e2e2",
                      "error-container": "#ffdad6",
                      "on-secondary-fixed": "#131f0a",
                      "tertiary": "#000000",
                      "surface-variant": "#e5e2e1",
                      "outline": "#7e7576",
                      "on-surface-variant": "#4c4546",
                      "on-primary-fixed": "#1b1b1b",
                      "tertiary-fixed-dim": "#c6c6c6",
                      "on-tertiary-container": "#848484",
                      "on-secondary": "#ffffff",
                      "on-surface": "#1c1b1b",
                      "secondary-fixed-dim": "#bcccab",
                      "on-tertiary-fixed": "#1b1b1b",
                      "surface-tint": "#5e5e5e"
              },
              "borderRadius": {
                      "DEFAULT": "0.125rem",
                      "lg": "0.25rem",
                      "xl": "0.5rem",
                      "full": "0.75rem"
              },
              "spacing": {
                      "margin-desktop": "80px",
                      "container-max": "1440px",
                      "gutter": "24px",
                      "stack-lg": "32px",
                      "section-gap-mobile": "64px",
                      "section-gap": "160px",
                      "margin-mobile": "20px",
                      "stack-sm": "8px",
                      "stack-md": "16px"
              },
              "fontFamily": {
                      "headline-md": ["Outfit"],
                      "headline-sm": ["Outfit"],
                      "display-lg-mobile": ["Outfit"],
                      "label-md": ["Inter"],
                      "label-caps": ["Inter"],
                      "display-lg": ["Outfit"],
                      "body-md": ["Inter"],
                      "body-lg": ["Inter"],
                      "mono": ["JetBrains Mono"]
              },
              "fontSize": {
                      "headline-md": ["32px", {"lineHeight": "1.3", "letterSpacing": "-0.01em", "fontWeight": "400"}],
                      "headline-sm": ["24px", {"lineHeight": "1.4", "fontWeight": "400"}],
                      "display-lg-mobile": ["40px", {"lineHeight": "1.2", "letterSpacing": "-0.01em", "fontWeight": "500"}],
                      "label-md": ["14px", {"lineHeight": "1.4", "fontWeight": "500"}],
                      "label-caps": ["12px", {"lineHeight": "1.0", "letterSpacing": "0.08em", "fontWeight": "600"}],
                      "display-lg": ["64px", {"lineHeight": "1.1", "letterSpacing": "-0.02em", "fontWeight": "500"}],
                      "body-md": ["16px", {"lineHeight": "1.6", "fontWeight": "400"}],
                      "body-lg": ["18px", {"lineHeight": "1.6", "fontWeight": "400"}]
              }
            },
          },
        }
    </script>
    <style>
        body {
            background-color: theme('colors.surface');
            color: theme('colors.on-surface');
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 300, 'GRAD' 0, 'opsz' 24;
        }
        /* Soft slow transitions for editorial feel */
        a, button, img {
            transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
        }
        /* Toast notification styling */
        #aw-toast {
            position: fixed;
            bottom: 40px;
            right: 40px;
            background: #1c1b1b;
            color: #fcf9f8;
            padding: 16px 28px;
            font-size: 11px;
            font-weight: 800;
            letter-spacing: 2px;
            z-index: 99999;
            text-transform: uppercase;
            box-shadow: 6px 6px 0px #546348;
            border: 2px solid #1c1b1b;
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
        
        /* Wishlist button active state */
        .wishlist-btn.active span {
            font-variation-settings: 'FILL' 1 !important;
            color: #ba1a1a !important;
        }
    </style>
</head>
<body class="min-h-screen flex flex-col bg-surface">
    <c:set var="isHome" value="true" scope="request" />
    <jsp:include page="../partials/navbar.jsp" />

    <main class="flex-grow">
        <!-- Hero Section -->
        <section class="relative w-full h-[90vh] flex items-center justify-center overflow-hidden">
            <video autoplay loop muted playsinline class="absolute inset-0 w-full h-full object-cover object-center z-0 scale-105 hero-bg-video">
                <source src="${ctx}/assets/images/hero-main.webm?v=1.0.0" type="video/webm">
            </video>
            <div class="absolute inset-0 bg-black/15 z-10"></div>
            <div class="relative z-20 text-center px-margin-mobile flex flex-col items-center select-none">
                <h1 class="text-white font-light tracking-[0.05em] uppercase mb-4 leading-[0.85] text-center" style="font-family: 'Cormorant Garamond', serif; font-size: clamp(80px, 15vw, 220px);">
                    AURA
                </h1>
                <p class="font-sans text-white text-xs sm:text-sm md:text-base tracking-[0.45em] uppercase mb-12 font-light">
                    AUTUMN / WINTER 2026
                </p>
                <a class="inline-flex items-center justify-center px-8 py-3.5 md:px-12 md:py-4 border border-white text-white font-sans text-xs md:text-sm tracking-[0.2em] uppercase rounded-none bg-transparent hover:bg-white hover:text-black transition-all duration-500 ease-in-out" href="${ctx}/products">
                    DISCOVER COLLECTION
                </a>
            </div>
        </section>

        <!-- Brand Philosophy Section -->
        <section class="py-section-gap px-margin-mobile md:px-margin-desktop bg-surface-container-low">
            <div class="max-w-4xl mx-auto text-center space-y-stack-md">
                <span class="font-label-caps text-label-caps text-on-surface-variant tracking-[0.2em] uppercase">Ethos</span>
                <h2 class="font-display-lg-mobile md:text-[48px] md:leading-[1.2] text-primary">
                    Architectural Wardrobes designed with Technical Purity.
                </h2>
                <div class="w-12 h-[1px] bg-outline-variant mx-auto my-stack-lg"></div>
                <p class="font-body-lg text-on-surface-variant max-w-2xl mx-auto leading-relaxed">
                    We believe clothing is the primary architecture of the human experience. Our focus remains on textile clarity and essential geometric forms.
                </p>
            </div>
        </section>

        <!-- Material Innovation Highlight -->
        <section class="grid grid-cols-1 md:grid-cols-2 min-h-[700px]">
            <div class="bg-surface-container-highest overflow-hidden">
                <img alt="Macro fabric texture" class="w-full h-full object-cover hover:scale-110 duration-[2000ms]" src="${ctx}/assets/images/innovation-macro.jpg" onerror="this.src='${ctx}/assets/images/fallback.jpg'"/>
            </div>
            <div class="flex flex-col justify-center p-margin-mobile md:p-32 bg-white">
                <span class="font-label-caps text-label-caps text-on-surface-variant tracking-[0.2em] uppercase mb-stack-md">Innovation</span>
                <h3 class="font-headline-md text-headline-md mb-stack-lg">V-01 Technical Weave</h3>
                <p class="font-body-md text-on-surface-variant leading-relaxed mb-12">
                    Our signature V-01 Technical Weave utilizes high-density organic polymers cross-stitched for maximum structural integrity without compromising weight. The result is a fabric that maintains its silhouette while adapting to atmospheric moisture and body heat.
                </p>
                <div class="grid grid-cols-2 gap-8 border-t border-outline-variant pt-8">
                    <div>
                        <p class="font-mono text-[10px] uppercase text-on-surface-variant mb-1">Weight</p>
                        <p class="font-mono text-xs text-primary">240 GSM / Ultra-light</p>
                    </div>
                    <div>
                        <p class="font-mono text-[10px] uppercase text-on-surface-variant mb-1">Breathability</p>
                        <p class="font-mono text-xs text-primary">15,000 g/m²/24h</p>
                    </div>
                    <div>
                        <p class="font-mono text-[10px] uppercase text-on-surface-variant mb-1">Composition</p>
                        <p class="font-mono text-xs text-primary">82% Organic, 18% Polymer</p>
                    </div>
                    <div>
                        <p class="font-mono text-[10px] uppercase text-on-surface-variant mb-1">Treatment</p>
                        <p class="font-mono text-xs text-primary">PFC-Free DWR</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Category Grid -->
        <section class="py-section-gap px-margin-mobile md:px-margin-desktop max-w-container-max mx-auto">
            <div class="grid grid-cols-2 md:grid-cols-4 gap-gutter">
                <a class="group relative aspect-[3/4] overflow-hidden bg-surface-container-low" href="${ctx}/products?gender=Men">
                    <img alt="Men's Collection" class="w-full h-full object-cover group-hover:scale-105" src="${ctx}/assets/images/category-men.jpg" onerror="this.src='${ctx}/assets/images/fallback.jpg'"/>
                    <div class="absolute inset-0 bg-black/10 flex items-end p-6"><span class="font-label-caps text-label-caps text-on-primary uppercase tracking-widest">Men</span></div>
                </a>
                <a class="group relative aspect-[3/4] overflow-hidden bg-surface-container-low" href="${ctx}/products?gender=Women">
                    <img alt="Women's Collection" class="w-full h-full object-cover group-hover:scale-105" src="${ctx}/assets/images/category-women.jpg" onerror="this.src='${ctx}/assets/images/fallback.jpg'"/>
                    <div class="absolute inset-0 bg-black/10 flex items-end p-6"><span class="font-label-caps text-label-caps text-on-primary uppercase tracking-widest">Women</span></div>
                </a>
                <a class="group relative aspect-[3/4] overflow-hidden bg-surface-container-low" href="${ctx}/products?category=Footwear">
                    <img alt="Footwear" class="w-full h-full object-cover group-hover:scale-105" src="${ctx}/assets/images/category-footwear.jpg" onerror="this.src='${ctx}/assets/images/fallback.jpg'"/>
                    <div class="absolute inset-0 bg-black/10 flex items-end p-6"><span class="font-label-caps text-label-caps text-on-primary uppercase tracking-widest">Footwear</span></div>
                </a>
                <a class="group relative aspect-[3/4] overflow-hidden bg-surface-container-low" href="${ctx}/products?category=Accessories">
                    <img alt="Accessories" class="w-full h-full object-cover group-hover:scale-105" src="${ctx}/assets/images/category-accessories.jpg" onerror="this.src='${ctx}/assets/images/fallback.jpg'"/>
                    <div class="absolute inset-0 bg-black/10 flex items-end p-6"><span class="font-label-caps text-label-caps text-on-primary uppercase tracking-widest">Accessories</span></div>
                </a>
            </div>
        </section>

        <!-- Dynamic Studio Selection Products -->
        <section class="py-section-gap px-margin-mobile md:px-margin-desktop max-w-container-max mx-auto border-t border-outline-variant">
            <div class="flex flex-col md:flex-row justify-between items-end mb-stack-lg gap-gutter">
                <div>
                    <span class="font-label-caps text-label-caps text-on-surface-variant tracking-[0.2em] uppercase mb-stack-sm block">Archive</span>
                    <h2 class="font-headline-md text-headline-md">Studio Selection 01</h2>
                </div>
                <a class="font-label-caps text-label-caps border-b border-primary pb-1 hover:opacity-60" href="${ctx}/products">View Archive</a>
            </div>
            
            <div class="grid grid-cols-2 md:grid-cols-4 gap-gutter">
                <c:choose>
                    <c:when test="${empty products}">
                        <div class="col-span-2 md:col-span-4 text-center py-16 text-on-surface-variant/80 font-body-md tracking-wide">
                            No products available in the archive. Check back soon.
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="p" items="${products}">
                            <div class="group cursor-pointer flex flex-col ${p.stockQuantity == 0 ? 'opacity-70' : ''}" onclick="goToProduct('${p.id}')">
                                <div class="aspect-[3/4] mb-stack-md bg-surface-container-low overflow-hidden relative">
                                    <img class="w-full h-full object-cover group-hover:scale-105" 
                                         src="<c:choose><c:when test="${fn:startsWith(p.image, 'http')}">${p.image}</c:when><c:otherwise>${ctx}/assets/images/${p.image}</c:otherwise></c:choose>"
                                         onerror="this.src='${ctx}/assets/images/fallback.jpg'"
                                         alt="${p.name}">
                                    
                                    <c:choose>
                                        <c:when test="${p.stockQuantity == 0}">
                                            <div class="absolute top-4 left-4 bg-primary text-on-primary text-[10px] font-mono tracking-widest px-2 py-1 uppercase">OUT OF STOCK</div>
                                        </c:when>
                                        <c:when test="${p.stockQuantity <= 5}">
                                            <div class="absolute top-4 left-4 bg-error text-on-error text-[10px] font-mono tracking-widest px-2 py-1 uppercase">ONLY ${p.stockQuantity} LEFT</div>
                                        </c:when>
                                    </c:choose>

                                    <button class="absolute top-4 right-4 bg-white/80 hover:bg-white text-primary w-8 h-8 rounded-full flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity z-20 wishlist-btn ${not empty wishlistNames and wishlistNames.contains(p.id) ? 'active' : ''}"
                                            data-id="${p.id}"
                                            onclick="toggleWishlist(event, this)">
                                        <span class="material-symbols-outlined" style="${not empty wishlistNames and wishlistNames.contains(p.id) ? 'font-variation-settings: \'FILL\' 1;' : ''}">favorite</span>
                                    </button>
                                    
                                    <button class="absolute bottom-0 left-0 right-0 bg-primary text-on-primary font-label-md py-3 text-center opacity-0 translate-y-2 group-hover:opacity-100 group-hover:translate-y-0 transition-all z-20 add-to-bag-btn ${p.stockQuantity == 0 ? 'disabled' : ''}" 
                                            data-id="${p.id}" 
                                            data-size="M" 
                                            data-price="${p.price}" 
                                            onclick="quickAdd(event)"
                                            ${p.stockQuantity == 0 ? 'disabled' : ''}>
                                        ${p.stockQuantity == 0 ? 'OUT OF STOCK' : '+ ADD TO BAG'}
                                    </button>
                                </div>
                                <div class="flex justify-between items-start mt-2">
                                    <div>
                                        <h3 class="font-body-md text-primary group-hover:underline">${p.name}</h3>
                                        <p class="font-label-md text-on-surface-variant">${p.category}</p>
                                    </div>
                                    <p class="font-label-md text-primary font-medium">₹<fmt:formatNumber value="${p.price}" maxFractionDigits="0"/></p>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>

        <!-- Trust Signals -->
        <section class="py-stack-lg border-t border-outline-variant px-margin-mobile md:px-margin-desktop bg-surface-bright">
            <div class="max-w-container-max mx-auto flex flex-col md:flex-row justify-center items-center gap-8 md:gap-16">
                <span class="font-label-caps text-label-caps text-on-surface-variant uppercase tracking-widest">Complimentary Global Shipping</span>
                <span class="hidden md:block w-1 h-1 bg-outline-variant rounded-full"></span>
                <span class="font-label-caps text-label-caps text-on-surface-variant uppercase tracking-widest">90-Day Returns</span>
                <span class="hidden md:block w-1 h-1 bg-outline-variant rounded-full"></span>
                <span class="font-label-caps text-label-caps text-on-surface-variant uppercase tracking-widest">Secured Checkout</span>
            </div>
        </section>
    </main>

    <!-- Footer -->
    <footer class="bg-surface-container-low w-full py-section-gap-mobile md:py-32 border-t border-outline-variant">
        <div class="grid grid-cols-1 md:grid-cols-4 gap-gutter px-margin-mobile md:px-margin-desktop max-w-container-max mx-auto">
            <div class="flex flex-col gap-stack-md col-span-1 md:col-span-2 pr-0 md:pr-12">
                <h4 class="font-headline-sm text-headline-sm font-medium text-primary">AuraWear</h4>
                <p class="font-body-md text-body-md text-on-surface-variant max-w-md">
                    High-end minimalist apparel designed with organic precision. We focus on textile clarity and essential silhouettes for the modern wardrobe.
                </p>
                <p class="font-label-md text-label-md text-on-surface-variant mt-stack-lg">
                    © 2025 AuraWear. All rights reserved.
                </p>
            </div>
            <div class="flex flex-col gap-stack-md mt-stack-lg md:mt-0">
                <h5 class="font-label-caps text-label-caps text-primary uppercase mb-2">Explore</h5>
                <a class="font-body-md text-body-md text-on-surface-variant hover:text-primary" href="${ctx}/products">Shop All</a>
                <a class="font-body-md text-body-md text-on-surface-variant hover:text-primary" href="${ctx}/products?gender=Men">New Arrivals</a>
                <a class="font-body-md text-body-md text-on-surface-variant hover:text-primary" href="${ctx}/products?category=Accessories">Essentials</a>
                <a class="font-body-md text-body-md text-on-surface-variant hover:text-primary" href="${ctx}/collections">Collections</a>
            </div>
            <div class="flex flex-col gap-stack-md mt-stack-lg md:mt-0">
                <h5 class="font-label-caps text-label-caps text-primary uppercase mb-2">Support</h5>
                <a class="font-body-md text-body-md text-on-surface-variant hover:text-primary" href="mailto:support@aurawear.com">Contact</a>
                <a class="font-body-md text-body-md text-on-surface-variant hover:text-primary" href="${ctx}/my-orders">Shipping &amp; Returns</a>
                <a class="font-body-md text-body-md text-on-surface-variant hover:text-primary" href="javascript:void(0)" onclick="openSizeGuide()">Size Guide</a>
            </div>
        </div>
    </footer>

    <!-- TOAST -->
    <div id="aw-toast"></div>

    <script>
    const ctx = "${ctx}";

    function goToProduct(id) {
        window.location.href = ctx + "/product?id=" + id;
    }

    function toggleWishlist(e, el) {
        e.stopPropagation();
        const id = el.getAttribute("data-id");
        fetch(ctx + "/wishlist-toggle", {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded",
                "X-CSRF-Token": window._csrf
            },
            body: "id=" + encodeURIComponent(id),
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
        const pName = btn.closest(".group").querySelector("h3")?.innerText || 'Product';
        btn.disabled = true;
        btn.innerText = "Adding...";
        fetch(ctx + "/add-to-cart", {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded",
                "X-CSRF-Token": window._csrf
            },
            body: "id=" + encodeURIComponent(id) + "&size=" + encodeURIComponent(size || "M") + "&price=" + encodeURIComponent(price),
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
                if (typeof gtag === 'function') {
                    gtag('event', 'add_to_cart', {
                        currency: 'INR',
                        value: parseFloat(price),
                        items: [{
                            item_id: id,
                            item_name: pName,
                            price: parseFloat(price),
                            quantity: 1,
                            item_size: size || 'M'
                        }]
                    });
                }
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
