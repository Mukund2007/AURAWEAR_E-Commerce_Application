<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Curated Collections — AuraWear</title>
    <meta name="description" content="Explore AuraWear's curated fashion drops — Noir, Minimal Essentials, Street Uniform, and more. Premium editorial collections.">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/assets/css/home.css">
    <link rel="stylesheet" href="${ctx}/assets/css/collections.css?v=5">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
</head>
<body>

    <jsp:include page="../partials/navbar.jsp" />

    <!-- ══ HERO ══════════════════════════════════════════════ -->
    <section class="col-hero">
        <div class="col-hero-label">AW — 2025 DROPS</div>
        <h1 class="col-hero-title">
            <span class="col-hero-line">CURATED</span>
            <span class="col-hero-line red">COLLECTIONS</span>
        </h1>
        <p class="col-hero-sub">Signature drops designed for every aura.</p>
        <div class="col-hero-meta">
            <span>03 COLLECTIONS</span>
            <span class="col-dot">•</span>
            <span>SEASONAL EDIT</span>
            <span class="col-dot">•</span>
            <span>LIMITED DROPS</span>
        </div>
    </section>

    <!-- ══ MARQUEE TICKER ════════════════════════════════════ -->
    <div class="col-ticker" aria-hidden="true">
        <div class="col-ticker-track">
            <span>NOIR DROP</span><span class="sep">★</span>
            <span>MINIMAL ESSENTIALS</span><span class="sep">★</span>
            <span>STREET UNIFORM</span><span class="sep">★</span>
            <span>SEASONAL EDIT 2025</span><span class="sep">★</span>
            <span>CURATED PICKS</span><span class="sep">★</span>
            <span>NOIR DROP</span><span class="sep">★</span>
            <span>MINIMAL ESSENTIALS</span><span class="sep">★</span>
            <span>STREET UNIFORM</span><span class="sep">★</span>
            <span>SEASONAL EDIT 2025</span><span class="sep">★</span>
            <span>CURATED PICKS</span><span class="sep">★</span>
        </div>
    </div>

    <!-- ══ COLLECTION 01 — NOIR DROP ════════════════════════ -->
    <section class="col-block col-block--left" id="noir">
        <div class="col-block-images">
            <div class="col-img-main">
                <img src="${ctx}/assets/images/over1.jpg" alt="Noir Drop — Oversized Silhouette">
                <div class="col-img-badge">01</div>
            </div>
            <div class="col-img-stack">
                <div class="col-img-secondary">
                    <img src="${ctx}/assets/images/cargo2.jpg" alt="Noir Drop — Cargo">
                </div>
                <div class="col-img-secondary">
                    <img src="${ctx}/assets/images/ls1.jpg" alt="Noir Drop — Long Sleeve">
                </div>
            </div>
        </div>
        <div class="col-block-text">
            <div class="col-block-number">COLLECTION — 01</div>
            <h2 class="col-block-title">NOIR<br>DROP</h2>
            <p class="col-block-desc">
                Monochrome essentials &amp; high-contrast silhouettes. 
                All-black everything. Structured fits for the bold.
            </p>
            <ul class="col-block-tags">
                <li>OVERSIZED</li>
                <li>MONOCHROME</li>
                <li>STRUCTURED</li>
            </ul>
            <a href="${ctx}/products?category=Streetwear" class="col-explore-btn">
                Explore the Drop <i class="fa-solid fa-arrow-right"></i>
            </a>
        </div>
    </section>

    <!-- ══ DIVIDER ══════════════════════════════════════════ -->
    <div class="col-divider">
        <span>— SCROLL TO EXPLORE —</span>
    </div>

    <!-- ══ COLLECTION 02 — MINIMAL ══════════════════════════ -->
    <section class="col-block col-block--right col-block--cream" id="minimal">
        <div class="col-block-text">
            <div class="col-block-number">COLLECTION — 02</div>
            <h2 class="col-block-title">MINIMAL<br>ESSENTIALS</h2>
            <p class="col-block-desc">
                Timeless daily uniforms &amp; clean structural base-wear.
                Less is more. Quiet luxury for every occasion.
            </p>
            <ul class="col-block-tags">
                <li>CLEAN CUT</li>
                <li>NEUTRAL TONES</li>
                <li>EVERYDAY FIT</li>
            </ul>
            <a href="${ctx}/products?category=Casual" class="col-explore-btn">
                Explore the Drop <i class="fa-solid fa-arrow-right"></i>
            </a>
        </div>
        <div class="col-block-images">
            <div class="col-img-main">
                <img src="${ctx}/assets/images/polo1.jpg" alt="Minimal Essentials — Polo">
                <div class="col-img-badge col-img-badge--dark">02</div>
            </div>
            <div class="col-img-stack">
                <div class="col-img-secondary">
                    <img src="${ctx}/assets/images/tank1.jpg" alt="Minimal Essentials — Tank">
                </div>
                <div class="col-img-secondary">
                    <img src="${ctx}/assets/images/short1.jpg" alt="Minimal Essentials — Shorts">
                </div>
            </div>
        </div>
    </section>

    <!-- ══ DIVIDER ══════════════════════════════════════════ -->
    <div class="col-divider">
        <span>— KEEP SCROLLING —</span>
    </div>

    <!-- ══ COLLECTION 03 — STREET ════════════════════════════ -->
    <section class="col-block col-block--left col-block--dark" id="street">
        <div class="col-block-images">
            <div class="col-img-main">
                <img src="${ctx}/assets/images/track1.jpg" alt="Street Uniform — Tracksuit">
                <div class="col-img-badge col-img-badge--red">03</div>
            </div>
            <div class="col-img-stack">
                <div class="col-img-secondary">
                    <img src="${ctx}/assets/images/wind1.jpg" alt="Street Uniform — Windbreaker">
                </div>
                <div class="col-img-secondary">
                    <img src="${ctx}/assets/images/cap1.jpg" alt="Street Uniform — Cap">
                </div>
            </div>
        </div>
        <div class="col-block-text">
            <div class="col-block-number">COLLECTION — 03</div>
            <h2 class="col-block-title">STREET<br>UNIFORM</h2>
            <p class="col-block-desc">
                Oversized silhouettes &amp; bold graphic prints.
                Built for the streets. Worn for the culture.
            </p>
            <ul class="col-block-tags">
                <li>BOLD PRINTS</li>
                <li>OVERSIZE</li>
                <li>STREETWEAR</li>
            </ul>
            <a href="${ctx}/products?category=Techwear" class="col-explore-btn col-explore-btn--red">
                Explore the Drop <i class="fa-solid fa-arrow-right"></i>
            </a>
        </div>
    </section>

    <!-- ══ BOTTOM CTA ════════════════════════════════════════ -->
    <section class="col-cta">
        <div class="col-cta-inner">
            <p class="col-cta-label">— FULL CATALOG —</p>
            <h2 class="col-cta-title">CAN'T DECIDE?<br>SHOP EVERYTHING.</h2>
            <a href="${ctx}/products" class="col-cta-btn">
                <i class="fa-solid fa-bag-shopping"></i> Browse All Products
            </a>
        </div>
    </section>

    <script>
        window.addEventListener('scroll', function () {
            const nav = document.querySelector('.navbar');
            if (nav) nav.classList.toggle('scrolled', window.scrollY > 80);
        });

        // Animate sections on scroll
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('col-visible');
                }
            });
        }, { threshold: 0.12 });

        document.querySelectorAll('.col-block, .col-cta').forEach(el => observer.observe(el));
    </script>

</body>
</html>