<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AuraWear — Premium Streetwear & Fashion</title>
    <meta name="description" content="AuraWear — Bold drops. Curated collections. Premium streetwear for Men & Women.">
    <link rel="stylesheet" href="${ctx}/assets/css/home.css?v=101">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
</head>
<body>
    <c:set var="isHome" value="true" scope="request" />
    <jsp:include page="../partials/navbar.jsp" />

    <!-- ══════════════════════════════════════════════════════════
         HERO — FULL SPLIT SCREEN
    ══════════════════════════════════════════════════════════ -->
    <section class="hero">
        <!-- LEFT: black panel with giant text -->
        <div class="hero-left">
            <div class="hero-left-inner">
                <p class="hero-eyebrow delay-1" data-scroll-reveal>AW '25 — New Arrival</p>
                <h1 class="hero-heading delay-2" data-scroll-reveal>
                    <span class="hh-line">DEFINE</span>
                    <span class="hh-line hh-outline">YOUR</span>
                    <span class="hh-line">AURA<span class="hh-dot">.</span></span>
                </h1>
                <p class="hero-copy delay-3" data-scroll-reveal>Timeless silhouettes.<br>Built for the bold.</p>
                <div class="hero-ctas delay-4" data-scroll-reveal>
                    <a href="${ctx}/products?gender=Men" class="cta-primary">Shop Men</a>
                    <a href="${ctx}/products?gender=Women" class="cta-ghost">Shop Women</a>
                </div>
            </div>
            <div class="hero-left-footer">
                <span>FREE DELIVERY ABOVE ₹999</span>
                <span class="hf-sep">|</span>
                <span>LIMITED DROPS</span>
                <span class="hf-sep">|</span>
                <span>WORLDWIDE SHIPPING</span>
            </div>
        </div>
    </section>

    <!-- ══════════════════════════════════════════════════════════
         MARQUEE
    ══════════════════════════════════════════════════════════ -->
    <div class="ticker" aria-hidden="true">
        <div class="ticker-track">
            <span>STREET LUXURY</span><em>*</em>
            <span>DEFINE YOUR AURA</span><em>*</em>
            <span>AW TWENTY FIVE</span><em>*</em>
            <span>CURATED DROPS</span><em>*</em>
            <span>PREMIUM FITS</span><em>*</em>
            <span>STREET LUXURY</span><em>*</em>
            <span>DEFINE YOUR AURA</span><em>*</em>
            <span>AW TWENTY FIVE</span><em>*</em>
            <span>CURATED DROPS</span><em>*</em>
            <span>PREMIUM FITS</span><em>*</em>
        </div>
    </div>

    <div class="blueprint-line" data-scroll-reveal="line"></div>

    <!-- ══════════════════════════════════════════════════════════
         3-PANEL SHOP BY CATEGORY
    ══════════════════════════════════════════════════════════ -->
    <section class="cat-panels">
        <a href="${ctx}/products?gender=Men" class="cat-panel delay-1" data-scroll-reveal>
            <div class="cat-img-wrap">
                <img src="${ctx}/assets/images/over1.jpg?v=10" alt="Men">
                <div class="cat-overlay"></div>
            </div>
            <div class="cat-label">
                <span class="cat-sub">— 01</span>
                <h3>MEN</h3>
                <span class="cat-arrow"><i class="fa-solid fa-arrow-right"></i></span>
            </div>
        </a>
        <a href="${ctx}/products?gender=Women" class="cat-panel cat-panel--mid delay-2" data-scroll-reveal>
            <div class="cat-img-wrap">
                <img src="${ctx}/assets/images/over3.jpg?v=10" alt="Women">
                <div class="cat-overlay"></div>
            </div>
            <div class="cat-label">
                <span class="cat-sub">— 02</span>
                <h3>WOMEN</h3>
                <span class="cat-arrow"><i class="fa-solid fa-arrow-right"></i></span>
            </div>
        </a>
        <a href="${ctx}/products?category=Accessories" class="cat-panel delay-3" data-scroll-reveal>
            <div class="cat-img-wrap">
                <img src="${ctx}/assets/images/bag1.jpg?v=10" alt="Accessories">
                <div class="cat-overlay"></div>
            </div>
            <div class="cat-label">
                <span class="cat-sub">— 03</span>
                <h3>EXTRAS</h3>
                <span class="cat-arrow"><i class="fa-solid fa-arrow-right"></i></span>
            </div>
        </a>
    </section>

    <!-- ══════════════════════════════════════════════════════════
         EDITORIAL STATEMENT ROW
    ══════════════════════════════════════════════════════════ -->
    <section class="statement">
        <div class="statement-line delay-1" data-scroll-reveal>
            <span class="sl-num">01</span>
            <p class="sl-text">We make clothes for people who don't follow trends — they set them.</p>
        </div>
        <div class="statement-divider"></div>
        <div class="statement-stats delay-2" data-scroll-reveal>
            <div class="ss-item"><strong>50K+</strong><span>Customers</span></div>
            <div class="ss-item"><strong>2K+</strong><span>Products</span></div>
            <div class="ss-item"><strong>4.9★</strong><span>Avg Rating</span></div>
            <div class="ss-item"><strong>48h</strong><span>Fast Dispatch</span></div>
        </div>
    </section>

    <div class="blueprint-line" data-scroll-reveal="line"></div>

    <!-- ══════════════════════════════════════════════════════════
         TRENDING — HORIZONTAL SCROLL
    ══════════════════════════════════════════════════════════ -->
    <section class="trending-section">
        <div class="ts-head">
            <div>
                <p class="ts-label">WHAT'S HOT RIGHT NOW</p>
                <h2 class="ts-title">TRENDING</h2>
            </div>
            <a href="${ctx}/products" class="ts-viewall">
                All Products <i class="fa-solid fa-arrow-right"></i>
            </a>
        </div>

        <div class="ts-scroll" id="trendingScroll">
            <c:forEach var="p" items="${products}">
                <div class="ts-card" onclick="goToProduct('${p.id}')"
                     data-id="${p.id}" data-name="${p.name}" data-price="${p.price}" data-size="M">
                    <div class="ts-img-wrap">
                        <img src="${ctx}/assets/images/${p.image}"
                             onerror="this.src='${ctx}/assets/images/fallback.jpg'"
                             alt="${p.name}" class="img-main">
                        <span class="ts-new">NEW</span>
                        <button class="ts-wish ${not empty wishlistNames and wishlistNames.contains(p.id) ? 'active' : ''}" 
                                data-id="${p.id}"
                                onclick="toggleWishlist(event, this)" title="Add to Wishlist">
                            <i class="${not empty wishlistNames and wishlistNames.contains(p.id) ? 'fa-solid' : 'fa-regular'} fa-heart"></i>
                        </button>
                        <button class="ts-add" 
                                data-id="${p.id}" 
                                data-size="${p.size}" 
                                data-price="${p.price}" 
                                onclick="quickAdd(event)">
                            + ADD TO BAG
                        </button>
                    </div>
                    <div class="ts-info">
                        <span class="ts-cat">${p.category}</span>
                        <p class="ts-name">${p.name}</p>
                        <div class="ts-bottom">
                            <span class="ts-price">₹<fmt:formatNumber value="${p.price}" maxFractionDigits="0"/></span>
                            <span class="ts-rating"><i class="fa-solid fa-star"></i> ${p.rating}</span>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- Scroll arrows -->
        <div class="ts-controls">
            <button onclick="scrollCards(-1)" class="ts-ctrl"><i class="fa-solid fa-arrow-left"></i></button>
            <button onclick="scrollCards(1)"  class="ts-ctrl"><i class="fa-solid fa-arrow-right"></i></button>
        </div>
    </section>

    <!-- ══════════════════════════════════════════════════════════
         FULL-BLEED FEATURE DROP (DARK)
    ══════════════════════════════════════════════════════════ -->
    <section class="feature">
        <div class="feature-bg">
            <img src="${ctx}/assets/images/feature-drop-new.jpg" alt="Street Luxury Drop" class="feature-bg-img">
            <div class="feature-bg-overlay"></div>
        </div>
        <div class="feature-content">
            <p class="feature-eyebrow">LIMITED RELEASE — AW25</p>
            <h2 class="feature-title">STREET<br>LUXURY</h2>
            <p class="feature-desc">Minimal silhouettes. Modern movement.<br>Built for the culture.</p>
            <a href="${ctx}/collections" class="feature-btn">
                Explore the Drop <i class="fa-solid fa-arrow-right"></i>
            </a>
        </div>
        <div class="feature-side">
            <div class="feature-tag-box">
                <span class="ftb-num">03</span>
                <span class="ftb-text">COLLECTIONS AVAILABLE</span>
            </div>
        </div>
    </section>

    <div class="blueprint-line" data-scroll-reveal="line"></div>

    <!-- ══════════════════════════════════════════════════════════
         SHOP BY STYLE — PILL ROW
    ══════════════════════════════════════════════════════════ -->
    <section class="style-nav">
        <p class="style-nav-label">SHOP BY STYLE</p>
        <div class="style-nav-pills">
            <a href="${ctx}/products?category=Streetwear"  class="snp"><i class="fa-solid fa-fire"></i> Streetwear</a>
            <a href="${ctx}/products?category=Minimal"     class="snp"><i class="fa-solid fa-minus"></i> Minimal</a>
            <a href="${ctx}/products?category=Outerwear"   class="snp"><i class="fa-solid fa-shirt"></i> Outerwear</a>
            <a href="${ctx}/products?category=Techwear"    class="snp"><i class="fa-solid fa-microchip"></i> Techwear</a>
            <a href="${ctx}/products?category=Sets"        class="snp"><i class="fa-solid fa-layer-group"></i> Co-ords</a>
            <a href="${ctx}/products?category=Footwear"    class="snp"><i class="fa-solid fa-shoe-prints"></i> Footwear</a>
            <a href="${ctx}/products?category=Accessories" class="snp"><i class="fa-solid fa-watch"></i> Accessories</a>
        </div>
    </section>

    <!-- ══════════════════════════════════════════════════════════
         BENEFITS STRIP
    ══════════════════════════════════════════════════════════ -->
    <div class="blueprint-line" data-scroll-reveal="line"></div>
    <div class="benefits-strip">
        <div class="bs-item">
            <i class="fa-solid fa-truck-fast"></i>
            <span>Free Delivery <em>above ₹999</em></span>
        </div>
        <div class="bs-sep"></div>
        <div class="bs-item">
            <i class="fa-solid fa-gem"></i>
            <span>Premium Quality <em>guaranteed</em></span>
        </div>
        <div class="bs-sep"></div>
        <div class="bs-item">
            <i class="fa-solid fa-rotate-left"></i>
            <span>Easy Returns <em>within 7 days</em></span>
        </div>
        <div class="bs-sep"></div>
        <div class="bs-item">
            <i class="fa-solid fa-shield-halved"></i>
            <span>Secure Checkout <em>100% safe</em></span>
        </div>
        <div class="bs-sep"></div>
        <div class="bs-item">
            <i class="fa-solid fa-headset"></i>
            <span>24/7 Support <em>always here</em></span>
        </div>
    </div>

    <div class="blueprint-line" data-scroll-reveal="line"></div>

    <!-- ══════════════════════════════════════════════════════════
         NEWSLETTER
    ══════════════════════════════════════════════════════════ -->
    <section class="nl">
        <div class="nl-left">
            <p class="nl-eyebrow">JOIN THE CIRCLE</p>
            <h2 class="nl-heading">EARLY<br>ACCESS.</h2>
        </div>
        <div class="nl-right">
            <p class="nl-sub">Private drops, pre-launch prices, and curated edits — before anyone else.</p>
            <div class="nl-form">
                <input type="email" id="nlEmail" placeholder="your@email.com">
                <button onclick="subscribe()">Subscribe <i class="fa-solid fa-arrow-right"></i></button>
            </div>
        </div>
    </section>

    <div class="blueprint-line" data-scroll-reveal="line"></div>

    <!-- ══════════════════════════════════════════════════════════
         FOOTER
    ══════════════════════════════════════════════════════════ -->
    <footer class="footer">
        <div class="footer-top">
            <div class="ft-brand">
                <div class="ft-logo">AURAWEAR</div>
                <p>Premium streetwear for<br>modern culture.</p>
                <div class="ft-socials">
                    <a href="#"><i class="fa-brands fa-instagram"></i></a>
                    <a href="#"><i class="fa-brands fa-x-twitter"></i></a>
                    <a href="#"><i class="fa-brands fa-tiktok"></i></a>
                </div>
            </div>
            <div class="ft-col">
                <h5>Shop</h5>
                <a href="${ctx}/products?gender=Men">Men</a>
                <a href="${ctx}/products?gender=Women">Women</a>
                <a href="${ctx}/products?category=Footwear">Footwear</a>
                <a href="${ctx}/products?category=Accessories">Accessories</a>
                <a href="${ctx}/collections">Collections</a>
            </div>
            <div class="ft-col">
                <h5>Account</h5>
                <a href="${ctx}/profile">My Profile</a>
                <a href="${ctx}/wishlist">Wishlist</a>
                <a href="${ctx}/cart">Cart</a>
                <a href="${ctx}/my-orders">Orders</a>
            </div>
            <div class="ft-col">
                <h5>Help</h5>
                <a href="${ctx}/my-orders">Track Order</a>
                <a href="${ctx}/my-orders">Returns</a>
                <a href="javascript:void(0)" onclick="openSizeGuide()">Size Guide</a>
                <a href="mailto:support@aurawear.com">Contact</a>
            </div>
        </div>
        <div class="footer-bottom">
            <span>© 2025 AuraWear. All rights reserved.</span>
            <span>Made with ♡ in India</span>
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
            const icon = el.querySelector("i");
            if (status.trim() === "added") {
                el.classList.add("active");
                if (icon) { icon.className = "fa-solid fa-heart"; }
                showToast("Added to wishlist ♡");
            } else {
                el.classList.remove("active");
                if (icon) { icon.className = "fa-regular fa-heart"; }
                showToast("Removed from wishlist");
            }
        })
        .catch(() => {
            showToast("Could not update wishlist. Try again.");
        });
    }

    function scrollCards(dir) {
        const el = document.getElementById("trendingScroll");
        el.scrollBy({ left: dir * 600, behavior: 'smooth' });
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
            btn.innerText = "Added ✓";
            showToast("Added to bag!");
            updateCartCount();
            setTimeout(() => { btn.disabled = false; btn.innerText = "+ ADD TO BAG"; }, 1600);
        })
        .catch(() => { btn.disabled = false; btn.innerText = "+ ADD TO BAG"; });
    }

    function updateCartCount() {
        fetch(ctx + "/cart-count", { credentials: "include" })
            .then(r => r.text())
            .then(c => { const el = document.getElementById("cart-count"); if (el) el.innerText = c; })
            .catch(() => {});
    }

    function subscribe() {
        const input = document.getElementById("nlEmail");
        if (!input.value || !input.value.includes("@")) {
            input.style.outline = "2px solid var(--accent-color)";
            setTimeout(() => input.style.outline = "", 800);
            return;
        }
        input.value = "";
        showToast("You're in! Welcome to the Circle ♡");
    }

    function showToast(msg) {
        const t = document.getElementById("aw-toast");
        t.innerText = msg;
        t.classList.add("show");
        setTimeout(() => t.classList.remove("show"), 2800);
    }
    window.showToast = showToast;

    document.addEventListener("DOMContentLoaded", updateCartCount);

    window.addEventListener("load", () => {
        const hero = document.querySelector('.hero');
        console.log("=== AuraWear Layout Diagnostics ===");
        console.log("Hero Element:", hero);
        if (hero) {
            console.log("Hero OffsetHeight:", hero.offsetHeight);
            console.log("Hero ComputedStyle Display:", window.getComputedStyle(hero).display);
            console.log("Hero ComputedStyle Opacity:", window.getComputedStyle(hero).opacity);
            const heroLeft = document.querySelector('.hero-left');
            if (heroLeft) {
                console.log("HeroLeft ComputedStyle Background:", window.getComputedStyle(heroLeft).background);
                console.log("HeroLeft ComputedStyle Opacity:", window.getComputedStyle(heroLeft).opacity);
            }
        }
        console.log("=== End Diagnostics ===");
    });
    </script>
    <script src="${ctx}/assets/js/app-interactions.js?v=11"></script>
</body>
</html>
