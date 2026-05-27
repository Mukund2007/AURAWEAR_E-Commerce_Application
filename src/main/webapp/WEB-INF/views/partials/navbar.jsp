<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<script>
    (function() {
        var savedTheme = localStorage.getItem('auraTheme') || 'canvas';
        if (savedTheme !== 'canvas') {
            document.documentElement.classList.add('theme-' + savedTheme);
        }
    })();
</script>

<style>
/* ── GLOBAL THEMATIC VARIABLES & OVERRIDES ───────────────────── */
:root {
    --bg-color: #f0e9e2;
    --text-color: #0d0d0d;
    --border-color: rgba(13, 13, 13, 0.12);
    --border-color-solid: #0d0d0d;
    --accent-color: #ff0001;
    --card-bg: rgba(255, 255, 255, 0.45);
    --navbar-bg: rgba(240, 233, 226, 0.82);
    --input-bg: #ffffff;
}

html.theme-noir {
    --bg-color: #0d0d0d;
    --text-color: #ede4dd;
    --border-color: rgba(237, 228, 221, 0.15);
    --border-color-solid: #ede4dd;
    --accent-color: #ff0001;
    --card-bg: rgba(25, 25, 25, 0.5);
    --navbar-bg: rgba(13, 13, 13, 0.85);
    --input-bg: #1a1a1a;
}

html.theme-red {
    --bg-color: #ff0001;
    --text-color: #0d0d0d;
    --border-color: rgba(13, 13, 13, 0.25);
    --border-color-solid: #0d0d0d;
    --accent-color: #ede4dd;
    --card-bg: rgba(255, 255, 255, 0.25);
    --navbar-bg: rgba(255, 0, 1, 0.85);
    --input-bg: rgba(255, 255, 255, 0.4);
}

/* Global Application Level transitions */
html {
    background-color: var(--bg-color) !important;
    color: var(--text-color) !important;
    transition: background-color 0.8s cubic-bezier(0.76, 0, 0.24, 1), color 0.8s cubic-bezier(0.76, 0, 0.24, 1);
}

body {
    background: transparent !important;
    color: var(--text-color) !important;
}

/* Smooth interpolation for all standard typography and elements */
h1, h2, h3, h4, h5, h6, p, span, a, div, section, label, input, select, textarea, button {
    transition: color 0.8s cubic-bezier(0.76, 0, 0.24, 1), background-color 0.8s cubic-bezier(0.76, 0, 0.24, 1), border-color 0.8s cubic-bezier(0.76, 0, 0.24, 1);
}

/* Navbar theme variables overrides */
.navbar {
    background: var(--navbar-bg) !important;
    border-bottom: 1.5px solid var(--border-color-solid) !important;
    transition: background 0.8s cubic-bezier(0.76, 0, 0.24, 1), border-bottom 0.8s cubic-bezier(0.76, 0, 0.24, 1) !important;
}
.brand a, .navbar a, .navbar i, .navbar span {
    color: var(--text-color) !important;
}

/* Dynamic outlined Menu Button (Icon Only) */
.menu-trigger-btn {
    display: inline-flex !important;
    align-items: center;
    justify-content: center;
    background: transparent !important;
    border: 1.5px solid var(--border-color-solid) !important;
    width: 44px !important;
    height: 44px !important;
    padding: 0 !important;
    border-radius: 50% !important;
    cursor: pointer;
    position: relative;
    overflow: hidden;
    transition: all 0.4s cubic-bezier(0.76, 0, 0.24, 1) !important;
    z-index: 1;
}

/* Custom Hamburger Bars Container */
.menu-icon-bars {
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    width: 18px;
    height: 12px;
    position: relative;
    z-index: 2;
}

/* Individual thin bars */
.menu-icon-bars .bar {
    width: 100%;
    height: 2px;
    background: var(--text-color);
    transition: transform 0.4s cubic-bezier(0.76, 0, 0.24, 1), width 0.4s cubic-bezier(0.76, 0, 0.24, 1), background-color 0.4s cubic-bezier(0.76, 0, 0.24, 1);
    transform-origin: left center;
}

/* Hover state stagger animations */
.menu-trigger-btn:hover .bar-1 {
    width: 60%;
    transform: translateX(40%);
    background: var(--bg-color) !important;
}
.menu-trigger-btn:hover .bar-2 {
    width: 100%;
    background: var(--bg-color) !important;
}
.menu-trigger-btn:hover .bar-3 {
    width: 80%;
    transform: translateX(20%);
    background: var(--bg-color) !important;
}

/* Sliding dynamic curtain background fill on hover */
.menu-trigger-btn::before {
    content: "";
    position: absolute;
    top: 0; left: 0; width: 100%; height: 100%;
    background: var(--text-color);
    transform: translateY(100%);
    transition: transform 0.4s cubic-bezier(0.76, 0, 0.24, 1);
    z-index: 0;
}

.menu-trigger-btn:hover::before {
    transform: translateY(0);
}

/* blueprint lines transition */
.blueprint-line {
    background: var(--border-color) !important;
}

/* search box transitions (Pill Shaped Aceternity Style) */
.search-box {
    background: var(--input-bg) !important;
    border-color: var(--border-color-solid) !important;
    color: var(--text-color) !important;
    border-radius: 40px !important;
    padding: 6px 18px !important;
    width: 280px !important;
    display: flex;
    align-items: center;
    transition: background 0.8s cubic-bezier(0.76, 0, 0.24, 1), border-color 0.8s cubic-bezier(0.76, 0, 0.24, 1), box-shadow 0.2s;
}
.search-box:focus-within {
    box-shadow: 0 0 0 3px var(--border-color);
}
.search-box form {
    display: flex; align-items: center; width: 100%; gap: 8px;
}
.search-box input {
    border: none; background: transparent; outline: none;
    font-size: 13px; width: 100%; padding: 0;
    color: var(--text-color) !important; font-family: inherit;
    font-weight: 500;
}
.search-box button {
    background: none; border: none; cursor: pointer;
    font-size: 15px; color: var(--text-color) !important; padding: 0; flex-shrink: 0;
}
.search-box button:hover { color: var(--accent-color) !important; }

/* Home Page Bento Panels & Cards overrides */
.info-panel, .snp-card, .prod-card, .benefit-card, .cart-item, .order-card, .profile-card, .wishlist-card, .auth-card {
    background: var(--card-bg) !important;
    border-color: var(--border-color-solid) !important;
    color: var(--text-color) !important;
}
.info-panel h3, .info-panel p, 
.snp-card h3, .snp-card p,
.prod-card h3, .prod-card p, .prod-card .price,
.benefit-card h4, .benefit-card p {
    color: var(--text-color) !important;
}

.info-bento {
    border-color: var(--border-color-solid) !important;
}

/* Catalog, details and dynamic pages general overrides */
.product-card, .product-grid, .product-detail-container, .cart-container, .wishlist-container, .orders-container {
    color: var(--text-color) !important;
}

/* Toggles & indicators overrides */
.top-strip {
    background: var(--border-color-solid) !important;
    color: var(--bg-color) !important;
    border-bottom-color: var(--border-color) !important;
}
.top-strip a {
    color: var(--bg-color) !important;
    opacity: 0.75;
}
.top-strip a:hover {
    color: var(--accent-color) !important;
    opacity: 1;
}

/* POETIC Drawer overlays — always full-bleed dark panel regardless of theme */
.menu-overlay {
    background: rgba(13, 13, 13, 0.98) !important;
    color: #ede4dd !important;
}
html.theme-noir .menu-overlay {
    background: rgba(5, 5, 5, 0.99) !important;
}
html.theme-red .menu-overlay {
    background: rgba(13, 13, 13, 0.98) !important;
}
.menu-overlay .menu-item {
    color: #ede4dd !important;
}
.menu-overlay .menu-item:hover {
    color: var(--accent-color) !important;
}

/* General button states */
.cta-primary {
    background: var(--text-color) !important;
    color: var(--bg-color) !important;
    border-color: var(--text-color) !important;
}
.cta-primary:hover {
    background: var(--accent-color) !important;
    color: var(--bg-color) !important;
    border-color: var(--accent-color) !important;
}

.cta-ghost {
    background: transparent !important;
    color: var(--text-color) !important;
    border-color: var(--text-color) !important;
}
.cta-ghost:hover {
    background: var(--text-color) !important;
    color: var(--bg-color) !important;
    border-color: var(--text-color) !important;
}

/* Footer overrides — footer uses intentionally INVERTED palette:
   Canvas: bg=dark(#0d0d0d), text=cream; Noir: bg=cream, text=dark; Red: bg=dark, text=red-accent */
footer, .footer {
    background: var(--border-color-solid) !important;
    color: var(--bg-color) !important;
    border-top: 2px solid var(--border-color-solid) !important;
}

/* Right-side nav icons overrides and smooth scaling */
.nav-icons a {
    color: var(--text-color) !important;
    transition: color 0.4s, transform 0.4s cubic-bezier(0.76, 0, 0.24, 1) !important;
}

.nav-icons a:hover {
    color: var(--accent-color) !important;
    transform: translateY(-2px) scale(1.06) !important;
}

.cart-badge {
    background: var(--accent-color) !important;
    color: var(--bg-color) !important;
    border: 1px solid var(--border-color-solid) !important;
    transition: all 0.4s cubic-bezier(0.76, 0, 0.24, 1) !important;
}

/* ── OUTFIT-STYLE DYNAMIC THEME SELECTOR WIDGET ──────────────────── */
.aura-theme-picker {
    display: flex;
    align-items: center;
    gap: 12px;
    z-index: 99900;
    transition: all 0.5s cubic-bezier(0.76, 0, 0.24, 1);
}

.theme-swatch {
    width: 24px;
    height: 24px;
    border-radius: 50%;
    border: none;
    background: transparent;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 0;
    transition: all 0.4s cubic-bezier(0.76, 0, 0.24, 1);
    position: relative;
    outline: none;
}

.theme-swatch:hover {
    transform: scale(1.2);
}

.swatch-dot {
    border-radius: 50%;
    transition: all 0.4s cubic-bezier(0.76, 0, 0.24, 1);
}

/* 1. Noir Swatch Dot - "larger black" when active */
.swatch-noir .swatch-dot {
    background: #000000;
    width: 14px;
    height: 14px;
    border: 1px solid rgba(237, 228, 221, 0.2);
}
.swatch-noir.active .swatch-dot {
    width: 20px;
    height: 20px;
    border-color: transparent;
}

/* 2. Canvas Swatch Dot - "white outline circle" when active */
.swatch-canvas .swatch-dot {
    background: #ede4dd;
    width: 14px;
    height: 14px;
    border: 1px solid rgba(13, 13, 13, 0.2);
}
.swatch-canvas.active .swatch-dot {
    width: 20px;
    height: 20px;
    background: transparent;
    border: 2px solid var(--text-color);
}

/* 3. Red Swatch Dot - "larger red with white dot" when active, "small red" when inactive */
.swatch-red .swatch-dot {
    background: #ff0001;
    width: 14px;
    height: 14px;
    border: none;
    position: relative;
    display: flex;
    align-items: center;
    justify-content: center;
}
.swatch-red.active .swatch-dot {
    width: 20px;
    height: 20px;
}
.swatch-red .swatch-dot::after {
    content: "";
    position: absolute;
    width: 4px;
    height: 4px;
    background: #ffffff;
    border-radius: 50%;
    opacity: 0;
    transition: opacity 0.3s ease;
}
.swatch-red.active .swatch-dot::after {
    opacity: 1;
}

/* Selected state active concentric ring */
.theme-swatch.active {
    box-shadow: 0 0 0 2px var(--bg-color), 0 0 0 3.5px var(--text-color);
}

/* ── CUSTOM CURSOR FOLLOWER ──────────────────────────────────── */
.custom-cursor-follower {
    position: fixed;
    top: 0;
    left: 0;
    width: 8px;
    height: 8px;
    background-color: #ff0001;
    border-radius: 50%;
    pointer-events: none;
    z-index: 999999;
    transform: translate(-50%, -50%);
    transition: width 0.3s cubic-bezier(0.25, 1, 0.5, 1), 
                height 0.3s cubic-bezier(0.25, 1, 0.5, 1), 
                background-color 0.3s cubic-bezier(0.25, 1, 0.5, 1),
                border 0.3s cubic-bezier(0.25, 1, 0.5, 1);
}

.custom-cursor-follower.hovered {
    width: 28px;
    height: 28px;
    background-color: rgba(255, 0, 1, 0.15);
    border: 1px solid #ff0001;
}

/* Gracefully disable the cursor follower on touch-based mobile devices */
@media (hover: none) or (pointer: coarse) {
    .custom-cursor-follower {
        display: none !important;
    }
}

/* ── ACETERNITY-STYLE FLOATING NAVBAR PILL ──────────────────────── */
.navbar-center-menu {
    display: flex;
    align-items: center;
    gap: 28px;
    background: var(--card-bg);
    border: 1.5px solid var(--border-color-solid);
    padding: 6px 10px 6px 24px;
    border-radius: 40px;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.04);
    backdrop-filter: blur(12px);
    -webkit-backdrop-filter: blur(12px);
    transition: all 0.5s cubic-bezier(0.76, 0, 0.24, 1);
}

html.theme-noir .navbar-center-menu {
    background: rgba(25, 25, 25, 0.65) !important;
    box-shadow: 0 4px 25px rgba(0, 0, 0, 0.25) !important;
}

html.theme-red .navbar-center-menu {
    background: rgba(255, 255, 255, 0.2) !important;
    box-shadow: 0 4px 20px rgba(13, 13, 13, 0.1) !important;
}

.acet-menu-item {
    position: relative;
    padding: 10px 0;
    cursor: pointer;
}

.acet-menu-title {
    font-size: 12px;
    font-weight: 800;
    text-transform: uppercase;
    letter-spacing: 1.5px;
    color: var(--text-color);
    display: flex;
    align-items: center;
    gap: 6px;
    transition: color 0.3s;
}

.acet-menu-item:hover .acet-menu-title {
    color: var(--accent-color);
}

/* Glassmorphic Dropdown Panel */
.acet-dropdown {
    position: absolute;
    top: calc(100% + 15px);
    left: 50%;
    transform: translateX(-50%) translateY(15px) scale(0.95);
    background: var(--bg-color);
    border: 1.5px solid var(--border-color-solid);
    box-shadow: 8px 8px 0px var(--border-color-solid);
    padding: 24px;
    opacity: 0;
    visibility: hidden;
    pointer-events: none;
    z-index: 1000;
    transition: opacity 0.4s cubic-bezier(0.16, 1, 0.3, 1), transform 0.4s cubic-bezier(0.16, 1, 0.3, 1), visibility 0.4s;
    border-radius: 0px;
}

/* Arrow indicator pointing up to item */
.acet-dropdown::before {
    content: "";
    position: absolute;
    bottom: 100%;
    left: 50%;
    transform: translateX(-50%);
    border-width: 8px;
    border-style: solid;
    border-color: transparent transparent var(--border-color-solid) transparent;
}

.acet-dropdown::after {
    content: "";
    position: absolute;
    bottom: 100%;
    left: 50%;
    transform: translateX(-50%);
    border-width: 7px;
    border-style: solid;
    border-color: transparent transparent var(--bg-color) transparent;
    margin-bottom: -2px;
}

/* Hover reveal dropdown logic */
.acet-menu-item:hover .acet-dropdown {
    opacity: 1;
    visibility: visible;
    pointer-events: auto;
    transform: translateX(-50%) translateY(0) scale(1);
}

/* Dropdown Content Typography */
.dropdown-heading {
    font-size: 10px;
    font-weight: 900;
    text-transform: uppercase;
    letter-spacing: 3px;
    color: var(--accent-color);
    margin-bottom: 8px;
    border-bottom: 1px solid var(--border-color);
    padding-bottom: 4px;
}

.hovered-link {
    font-size: 13px;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 1px;
    color: var(--text-color) !important;
    text-decoration: none;
    transition: color 0.3s, transform 0.3s;
    display: inline-block;
}

.hovered-link:hover {
    color: var(--accent-color) !important;
    transform: translateX(4px);
}

.dropdown-divider {
    height: 1px;
    background: var(--border-color);
    margin: 8px 0;
}

/* ProductItem Grid overrides */
.dropdown-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 24px;
    padding: 8px;
    width: 460px;
}

.acet-product-item {
    display: flex;
    gap: 16px;
    align-items: center;
    text-decoration: none;
    transition: transform 0.3s cubic-bezier(0.76, 0, 0.24, 1);
}

.acet-product-item:hover {
    transform: translateY(-2px);
}

.acet-prod-img {
    width: 60px;
    height: 60px;
    object-fit: cover;
    border: 1px solid var(--border-color-solid);
    transition: transform 0.3s;
    filter: grayscale(0.25) contrast(1.15) brightness(0.88) sepia(0.08);
}

.acet-product-item:hover .acet-prod-img {
    transform: scale(1.05);
    filter: grayscale(0) contrast(1) brightness(1) sepia(0);
}

.acet-prod-info {
    display: flex;
    flex-direction: column;
    gap: 4px;
}

.acet-prod-title {
    font-size: 12px;
    font-weight: 800;
    text-transform: uppercase;
    letter-spacing: 1px;
    color: var(--text-color);
}

.acet-product-item:hover .acet-prod-title {
    color: var(--accent-color);
}

.acet-prod-desc {
    font-size: 10px;
    color: var(--text-color);
    opacity: 0.6;
    max-width: 150px;
    line-height: 1.4;
}





.click-aura-ripple {
    position: fixed;
    width: 20px;
    height: 20px;
    background: radial-gradient(circle, rgba(255, 0, 1, 0.6) 0%, transparent 70%);
    border-radius: 50%;
    pointer-events: none;
    z-index: 99999;
    transform: translate(-50%, -50%);
    animation: aura-ripple-out 0.6s cubic-bezier(0.1, 0.8, 0.3, 1) forwards;
}

@keyframes aura-ripple-out {
    0% { width: 20px; height: 20px; opacity: 1; }
    100% { width: 200px; height: 200px; opacity: 0; filter: blur(8px); }
}

/* ── HIGH-END TACTILE FILM GRAIN / NOISE OVERLAY ─────────────── */
.noise-overlay {
    position: fixed;
    top: -50%; left: -50%;
    width: 200%; height: 200%;
    z-index: 99999 !important; /* Always on top of all elements */
    pointer-events: none;
    opacity: 0.052; /* Tactile texture-blending */
    background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 250 250' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noiseFilter'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.8' numOctaves='3' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noiseFilter)'/%3E%3C/svg%3E");
    animation: noise-jitter 0.15s steps(4) infinite;
}

@keyframes noise-jitter {
    0% { transform: translate(0, 0); }
    10% { transform: translate(-1%, -1%); }
    20% { transform: translate(-2%, 1%); }
    30% { transform: translate(1%, -2%); }
    40% { transform: translate(-1%, 3%); }
    50% { transform: translate(-2%, 1%); }
    60% { transform: translate(3%, -1%); }
    70% { transform: translate(0%, 2%); }
    80% { transform: translate(2%, 3%); }
    90% { transform: translate(-3%, 1%); }
    100% { transform: translate(0, 0); }
}

/* ── SCROLL-DRIVEN REVEAL ANIMATIONS ─────────────────────────── */
[data-scroll-reveal] {
    opacity: 0;
    transform: translateY(28px) scale(0.99);
    transition: opacity 1s cubic-bezier(0.25, 1, 0.5, 1), transform 1s cubic-bezier(0.25, 1, 0.5, 1);
    will-change: transform, opacity;
}

[data-scroll-reveal].reveal-active {
    opacity: 1;
    transform: translateY(0) scale(1);
}

.delay-1 { transition-delay: 0.12s; }
.delay-2 { transition-delay: 0.24s; }
.delay-3 { transition-delay: 0.36s; }
.delay-4 { transition-delay: 0.48s; }

[data-scroll-reveal="line"] {
    width: 0% !important;
    transition: width 1.2s cubic-bezier(0.25, 1, 0.5, 1) !important;
}
[data-scroll-reveal="line"].reveal-active {
    width: 100% !important;
}

[data-scroll-reveal="fade"] {
    transform: none !important;
}

/* ── BLUEPRINT GRID DIVIDER LINES ────────────────────────────── */
.blueprint-line {
    width: 100%;
    height: 1px;
    background: rgba(13, 13, 13, 0.12);
    position: relative;
    overflow: hidden;
    margin: 0;
}
.blueprint-line::after {
    content: "";
    position: absolute;
    left: 0; top: 0;
    width: 0%; height: 100%;
    background: #ff0001;
    transition: width 1.2s cubic-bezier(0.25, 1, 0.5, 1);
}
.blueprint-line.reveal-active::after {
    width: 100%;
}
.blueprint-line:hover::after {
    background: #ff0001;
    box-shadow: 0 0 8px rgba(255, 0, 1, 0.8);
}

/* ── SON DAVEN ARCHITECTURAL PRELOADER ───────────────────────── */
.preloader-overlay {
    position: fixed;
    inset: 0;
    background: #0d0d0d;
    color: #ede4dd;
    z-index: 100000;
    display: grid;
    grid-template-columns: 1fr auto;
    align-items: center;
    padding: 80px 100px;
    transition: opacity 0.8s cubic-bezier(0.76, 0, 0.24, 1), visibility 0.8s cubic-bezier(0.76, 0, 0.24, 1);
}

.preloader-left {
    display: flex;
    flex-direction: column;
    gap: 40px;
    position: relative;
    z-index: 100005;
}

.preloader-logo {
    font-size: 32px;
    font-weight: 900;
    letter-spacing: -1.5px;
    color: #ff0001;
    text-shadow: 0 0 10px rgba(255, 0, 1, 0.3);
}

.preloader-message {
    display: flex;
    flex-direction: column;
    gap: 8px;
    max-width: 450px;
}

.pm-line {
    font-size: 14px;
    font-weight: 700;
    letter-spacing: 3px;
    text-transform: uppercase;
    color: rgba(237, 228, 221, 0.4);
    opacity: 0;
    transform: translateY(10px);
    animation: pm-reveal 0.6s cubic-bezier(0.25, 1, 0.5, 1) forwards;
}

.pm-line-1 { animation-delay: 0.2s; }
.pm-line-2 { animation-delay: 0.5s; color: #ede4dd; }
.pm-line-3 { animation-delay: 0.8s; font-weight: 400; font-style: italic; text-transform: none; letter-spacing: 1px; }

@keyframes pm-reveal {
    to { opacity: 1; transform: translateY(0); }
}

.preloader-right {
    display: flex;
    flex-direction: column;
    align-items: flex-end;
    gap: 12px;
    position: relative;
    z-index: 100005;
}

.preloader-percent {
    font-size: 110px;
    font-weight: 900;
    line-height: 0.9;
    letter-spacing: -6px;
    color: #ede4dd;
}

.preloader-status {
    font-size: 10px;
    font-weight: 800;
    letter-spacing: 4px;
    color: #ff0001;
    text-transform: uppercase;
}

/* Split curtains inside the preloader that fold up */
.preloader-curtain {
    position: absolute;
    inset: 0;
    z-index: 100001;
    display: grid;
    grid-template-columns: 1fr 1fr 1fr;
    pointer-events: none;
}

.preloader-col {
    background: #0d0d0d;
    height: 100%;
    transform: translateY(0);
    transition: transform 1.2s cubic-bezier(0.76, 0, 0.24, 1);
}

.preloader-overlay.loaded {
    opacity: 0;
    visibility: hidden;
}

.preloader-overlay.loaded .preloader-col {
    transform: translateY(-100%);
}

.preloader-overlay.loaded .pc-2 { transition-delay: 0.12s; }
.preloader-overlay.loaded .pc-3 { transition-delay: 0.24s; }

@media (max-width: 768px) {
    .preloader-overlay {
        grid-template-columns: 1fr;
        padding: 40px 30px;
        align-content: space-between;
    }
    .preloader-right {
        align-items: flex-start;
        margin-top: 40px;
    }
    .preloader-percent {
        font-size: 70px;
    }
}



.menu-overlay {
    position: fixed;
    inset: 0;
    background: rgba(13, 13, 13, 0.98);
    backdrop-filter: blur(15px);
    -webkit-backdrop-filter: blur(15px);
    z-index: 99990;
    color: #ede4dd;
    display: grid;
    grid-template-rows: auto 1fr;
    padding: 40px 60px;
    opacity: 0;
    visibility: hidden;
    transform: translateY(-20px);
    transition: opacity 0.5s cubic-bezier(0.76, 0, 0.24, 1), visibility 0.5s cubic-bezier(0.76, 0, 0.24, 1), transform 0.5s cubic-bezier(0.76, 0, 0.24, 1);
}

.menu-overlay.active {
    opacity: 1;
    visibility: visible;
    transform: translateY(0);
}

.menu-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1px solid rgba(237, 228, 221, 0.15);
    padding-bottom: 20px;
}

.menu-close-btn {
    background: transparent;
    border: 1px solid rgba(237, 228, 221, 0.2);
    color: #ede4dd;
    font-size: 16px;
    width: 44px; height: 44px;
    display: flex; align-items: center; justify-content: center;
    cursor: pointer;
    transition: all 0.3s;
}
.menu-close-btn:hover {
    background: #ff0001;
    border-color: #ff0001;
    color: #ffffff;
    transform: rotate(90deg);
}

.menu-grid {
    display: grid;
    grid-template-columns: 1.2fr 1fr 1.2fr;
    gap: 0;
    height: 100%;
}

.menu-col {
    padding: 60px 40px;
    border-right: 1px solid rgba(237, 228, 221, 0.1);
    display: flex;
    flex-direction: column;
    gap: 30px;
}
.menu-col:last-child {
    border-right: none;
}

.menu-col h4 {
    font-size: 10px;
    font-weight: 800;
    letter-spacing: 4px;
    color: #ff0001;
    text-transform: uppercase;
    margin-bottom: 10px;
}

.menu-list {
    display: flex;
    flex-direction: column;
    gap: 16px;
}

.menu-item {
    font-size: 38px;
    font-weight: 900;
    letter-spacing: -1.5px;
    color: #ede4dd;
    text-transform: uppercase;
    transition: all 0.25s;
}
.menu-item:hover {
    color: #ff0001;
    transform: translateX(10px);
    text-shadow: 0 0 15px rgba(255, 0, 1, 0.3);
}

.menu-item-sub {
    font-size: 13px;
    font-weight: 600;
    color: rgba(237, 228, 221, 0.4);
    text-transform: uppercase;
    letter-spacing: 1px;
    transition: color 0.2s;
}
.menu-item-sub:hover {
    color: #ff0001;
}

.menu-poetics {
    font-size: 14px;
    line-height: 1.8;
    color: rgba(237, 228, 221, 0.55);
    max-width: 320px;
}

.menu-footer {
    display: flex;
    gap: 20px;
    margin-top: auto;
    font-size: 11px;
    letter-spacing: 1.5px;
    text-transform: uppercase;
    color: rgba(237, 228, 221, 0.3);
}
.menu-footer a:hover {
    color: #ff0001;
}

@media (max-width: 900px) {
    .menu-grid {
        grid-template-columns: 1fr;
        overflow-y: auto;
    }
    .menu-col {
        padding: 30px 20px;
        border-right: none;
        border-bottom: 1px solid rgba(237, 228, 221, 0.1);
    }
    .menu-item {
        font-size: 26px;
    }
    /* Hide centered navigation pill on mobile */
    .navbar-center-menu {
        display: none !important;
    }
    /* Compact brand logo for narrow viewports */
    .brand a span {
        display: none !important;
    }
    /* Clean, icon-only navigation elements */
    .nav-icons a span {
        display: none !important;
    }
    .nav-icons {
        gap: 20px !important;
        align-items: center;
    }
    /* Show mobile menu trigger */
    .mobile-menu-trigger {
        display: inline-flex !important;
    }
}

.mobile-menu-trigger {
    display: none !important;
}

/* ── STUNNING GLASSMORPHIC SIZE GUIDE MODAL ─────────────────── */
.size-overlay {
    position: fixed !important;
    top: 0 !important; left: 0 !important;
    right: 0 !important; bottom: 0 !important;
    background: rgba(0, 0, 0, 0.4);
    backdrop-filter: blur(8px);
    -webkit-backdrop-filter: blur(8px);
    z-index: 99999 !important;
    display: flex !important;
    align-items: center;
    justify-content: center;
    padding: 20px;
    opacity: 0;
    visibility: hidden;
    transition: opacity 0.3s ease, visibility 0.3s ease;
}
.size-overlay.active {
    opacity: 1 !important;
    visibility: visible !important;
}
.size-modal {
    width: 100%;
    max-width: 580px;
    max-height: 90vh;
    background: var(--bg-color);
    border: 1.5px solid var(--border-color-solid);
    border-radius: 0px;
    padding: 44px 40px;
    overflow-y: auto;
    position: relative;
    transform: scale(0.94) translateY(12px);
    transition: transform 0.4s cubic-bezier(0.16, 1, 0.3, 1), background 0.8s, border-color 0.8s, color 0.8s;
    box-shadow: 8px 8px 0px var(--border-color-solid);
    color: var(--text-color);
}
.size-overlay.active .size-modal {
    transform: scale(1) translateY(0);
}
.size-tabs {
    display: flex;
    border-bottom: 1.5px solid var(--border-color-solid);
    gap: 8px;
    margin-bottom: 24px;
    transition: border-color 0.8s;
}
.size-tab-btn {
    background: none;
    border: none;
    padding: 10px 16px;
    font-size: 12px;
    font-weight: 800;
    text-transform: uppercase;
    letter-spacing: 1px;
    color: var(--text-color);
    cursor: pointer;
    border-bottom: 3px solid transparent;
    opacity: 0.6;
    transition: all 0.25s ease, color 0.8s;
}
.size-tab-btn:hover {
    opacity: 1;
    color: var(--accent-color);
}
.size-tab-btn.active {
    opacity: 1;
    border-bottom-color: var(--accent-color);
    color: var(--accent-color);
}
.size-tab-content {
    display: none;
}
.size-tab-content.active {
    display: block;
    animation: sizeFadeIn 0.3s ease;
}
@keyframes sizeFadeIn {
    from { opacity: 0; transform: translateY(4px); }
    to { opacity: 1; transform: translateY(0); }
}
.size-table {
    width: 100%;
    border-collapse: collapse;
    margin: 10px 0;
    text-align: left;
}
.size-table th, .size-table td {
    padding: 12px 16px;
    border-bottom: 1.5px solid var(--border-color-solid);
    font-size: 13px;
    transition: border-color 0.8s;
}
.size-table th {
    font-weight: 800;
    text-transform: uppercase;
    letter-spacing: 1px;
    font-size: 11px;
    background: var(--input-bg);
}
.size-table tr:hover td {
    background: var(--input-bg);
}

/* ── PREMIUM MOBILE RESPONSIVE NAV OVERRIDES ────────────────────────── */
@media (max-width: 768px) {
    /* Prevent wrapping in navbar */
    .navbar {
        flex-wrap: nowrap !important;
        justify-content: space-between !important;
        padding: 14px 16px !important;
        gap: 10px !important;
    }
    
    /* Hide the search box in the main navbar */
    .navbar .search-box {
        display: none !important;
    }
    
    /* Hide non-essential account/wishlist links in main nav icons */
    .navbar .nav-icons > a:not(.cart-link) {
        display: none !important;
    }
    
    /* Hide the Cart text label and keep only the bag icon and count badge */
    .navbar .nav-icons .cart-link span:not(.cart-badge) {
        display: none !important;
    }
    
    /* Let's style the nav icons container to not have large margins or wrap */
    .navbar .nav-icons {
        gap: 12px !important;
        display: flex !important;
        align-items: center !important;
    }
    
    /* Shrink gap of the right side container to fit mobile screen */
    .navbar div[style*="display:flex; align-items:center; gap:30px;"] {
        gap: 12px !important;
    }
    
    /* Make the theme swatches slightly smaller or adjust gap for mobile */
    .navbar .aura-theme-picker {
        gap: 8px !important;
        margin-right: 4px;
    }
    
    .navbar .theme-swatch {
        width: 20px !important;
        height: 20px !important;
    }
    .navbar .swatch-dot {
        width: 10px !important;
        height: 10px !important;
    }
    .navbar .swatch-noir.active .swatch-dot,
    .navbar .swatch-canvas.active .swatch-dot,
    .navbar .swatch-red.active .swatch-dot {
        width: 14px !important;
        height: 14px !important;
    }
    
    /* Add a beautiful mobile search box inside the menu overlay */
    .menu-overlay .mobile-search-box {
        display: flex !important;
    }
}

/* By default, hide the mobile search box in desktop view */
.menu-overlay .mobile-search-box {
    display: none;
    background: var(--input-bg);
    border: 1.5px solid var(--border-color-solid);
    padding: 10px 16px;
    align-items: center;
    gap: 10px;
    transition: all 0.3s ease;
    margin: 16px 20px 24px 20px;
    border-radius: 0px;
}
.menu-overlay .mobile-search-box form {
    display: flex;
    align-items: center;
    width: 100%;
    gap: 8px;
}
.menu-overlay .mobile-search-box input {
    border: none;
    background: transparent;
    outline: none;
    font-size: 14px;
    width: 100%;
    color: var(--text-color);
}
.menu-overlay .mobile-search-box button {
    background: none;
    border: none;
    cursor: pointer;
    font-size: 16px;
    color: var(--text-color);
}
</style>

<div class="top-strip">
    <div>✨ AURA SYSTEM LIVE ✨ | Shipping on all orders above ₹999</div>
    <div class="top-right">
        <a href="${ctx}/my-orders">Track Order</a>
        <a href="${ctx}/my-orders">Returns</a>
        <a href="javascript:void(0)" onclick="openSizeGuide()">Size Guide</a>
        <a href="mailto:support@aurawear.com">Contact</a>
    </div>
</div>

<!-- NAVBAR -->
<nav class="navbar">

    <div class="brand">
        <a href="${ctx}/home">AW <span>AURAWEAR</span></a>
    </div>

    <!-- CENTER PILL: ACETERNITY HOVER NAVIGATION -->
    <div class="navbar-center-menu">
        <!-- Item 01: Collections -->
        <div class="acet-menu-item" data-aura-bound="true">
            <span class="acet-menu-title">Collections <i class="fa fa-chevron-down" style="font-size: 8px; margin-left: 4px; opacity: 0.5;"></i></span>
            <div class="acet-dropdown dropdown-collections">
                <div style="display: flex; flex-direction: column; gap: 12px; min-width: 180px;">
                    <h4 class="dropdown-heading">Curated Drops</h4>
                    <a href="${ctx}/collections" class="hovered-link" data-aura-bound="true">Noir Drop</a>
                    <a href="${ctx}/collections" class="hovered-link" data-aura-bound="true">Minimalist Essentials</a>
                    <a href="${ctx}/collections" class="hovered-link" data-aura-bound="true">Street Uniform</a>
                    <div class="dropdown-divider"></div>
                    <a href="${ctx}/products" class="hovered-link" data-aura-bound="true" style="color: var(--accent-color) !important; font-weight: 800;">&rarr; Browse Lookbook</a>
                </div>
            </div>
        </div>

        <!-- Item 02: Catalog (Grid of Products) -->
        <div class="acet-menu-item" data-aura-bound="true">
            <span class="acet-menu-title">Catalog <i class="fa fa-chevron-down" style="font-size: 8px; margin-left: 4px; opacity: 0.5;"></i></span>
            <div class="acet-dropdown dropdown-catalog">
                <div class="dropdown-grid">
                    <a href="${ctx}/products?gender=Men" class="acet-product-item" data-aura-bound="true">
                        <img src="${ctx}/assets/images/over1.jpg" alt="Men's Apparel" class="acet-prod-img" />
                        <div class="acet-prod-info">
                            <h4 class="acet-prod-title">Men's apparel</h4>
                            <p class="acet-prod-desc">Silhouettes designed for structure and volume.</p>
                        </div>
                    </a>
                    <a href="${ctx}/products?gender=Women" class="acet-product-item" data-aura-bound="true">
                        <img src="${ctx}/assets/images/over3.jpg" alt="Women's Apparel" class="acet-prod-img" />
                        <div class="acet-prod-info">
                            <h4 class="acet-prod-title">Women's apparel</h4>
                            <p class="acet-prod-desc">Textured, high-fashion silhouettes.</p>
                        </div>
                    </a>
                    <a href="${ctx}/products?category=Footwear" class="acet-product-item" data-aura-bound="true">
                        <img src="${ctx}/assets/images/sneak1.jpg" alt="Footwear Drop" class="acet-prod-img" />
                        <div class="acet-prod-info">
                            <h4 class="acet-prod-title">Footwear Drop</h4>
                            <p class="acet-prod-desc">Tactile, premium weights that stand out.</p>
                        </div>
                    </a>
                    <a href="${ctx}/products?category=Accessories" class="acet-product-item" data-aura-bound="true">
                        <img src="${ctx}/assets/images/bag1.jpg" alt="Accessories" class="acet-prod-img" />
                        <div class="acet-prod-info">
                            <h4 class="acet-prod-title">Accessories</h4>
                            <p class="acet-prod-desc">Minimalist details to complete the look.</p>
                        </div>
                    </a>
                </div>
            </div>
        </div>

        <!-- Item 03: Atmosphere -->
        <div class="acet-menu-item" data-aura-bound="true">
            <span class="acet-menu-title">Atmosphere <i class="fa fa-chevron-down" style="font-size: 8px; margin-left: 4px; opacity: 0.5;"></i></span>
            <div class="acet-dropdown dropdown-atmosphere">
                <div style="display: flex; flex-direction: column; gap: 12px; min-width: 180px;">
                    <h4 class="dropdown-heading">Brand Realm</h4>
                    <a href="${ctx}/profile" class="hovered-link" data-aura-bound="true">My Account</a>
                    <a href="${ctx}/wishlist" class="hovered-link" data-aura-bound="true">Wishlist</a>
                    <a href="${ctx}/cart" class="hovered-link" data-aura-bound="true">Shopping Cart</a>
                    <a href="${ctx}/my-orders" class="hovered-link" data-aura-bound="true">Order Status</a>
                </div>
            </div>
        </div>

        <!-- Embedded Mini Hamburger Button inside Center Menu -->
        <a href="#" class="menu-trigger-btn" onclick="openMenuOverlay(); return false;" data-aura-bound="true" title="Open Fullscreen Overlay" aria-label="Fullscreen Menu" style="margin-left: 4px;">
            <span class="menu-icon-bars">
                <span class="bar bar-1"></span>
                <span class="bar bar-2"></span>
                <span class="bar bar-3"></span>
            </span>
        </a>
    </div>

    <div style="display:flex; align-items:center; gap:30px;">

        <!-- DYNAMIC THEME SELECTOR WIDGET (OUTFIT COLOR SWATCHES) -->
        <div class="aura-theme-picker" data-aura-bound="true">
            <button class="theme-swatch swatch-noir" onclick="setAuraTheme('noir')" title="Noir (Dark) Mode" aria-label="Noir Mode">
                <span class="swatch-dot"></span>
            </button>
            <button class="theme-swatch swatch-canvas" onclick="setAuraTheme('canvas')" title="Canvas (Cream) Mode" aria-label="Canvas Mode">
                <span class="swatch-dot"></span>
            </button>
            <button class="theme-swatch swatch-red" onclick="setAuraTheme('red')" title="Accent (Red) Mode" aria-label="Red Mode">
                <span class="swatch-dot"></span>
            </button>
        </div>

        <div class="search-box">
            <form action="${ctx}/products" method="get">
                <input type="text" name="keyword"
                       placeholder="Search for products..."
                       value="${param.keyword}">
                <button type="submit"><i class="fa fa-search"></i></button>
            </form>
        </div>

        <div class="nav-icons">

            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <a href="${ctx}/profile">
                        <i class="fa fa-user"></i>
                        <span>Account</span>
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="#" onclick="openLoginModal(); return false;">
                        <i class="fa fa-user"></i>
                        <span>Account</span>
                    </a>
                </c:otherwise>
            </c:choose>

            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <a href="${ctx}/wishlist">
                        <i class="fa fa-heart"></i>
                        <span>Wishlist</span>
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="#" onclick="openLoginModal(); return false;">
                        <i class="fa fa-heart"></i>
                        <span>Wishlist</span>
                    </a>
                </c:otherwise>
            </c:choose>

            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <a href="${ctx}/cart" class="cart-link">
                        <div style="position:relative; display:inline-block;">
                            <i class="fa fa-bag-shopping"></i>
                            <span id="cart-count" class="cart-badge">0</span>
                        </div>
                        <span>Cart</span>
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="#" onclick="openLoginModal(); return false;" class="cart-link">
                        <div style="position:relative; display:inline-block;">
                            <i class="fa fa-bag-shopping"></i>
                            <span id="cart-count" class="cart-badge">0</span>
                        </div>
                        <span>Cart</span>
                    </a>
                </c:otherwise>
            </c:choose>

            <!-- Mobile Menu Hamburger Trigger -->
            <a href="#" class="menu-trigger-btn mobile-menu-trigger" onclick="openMenuOverlay(); return false;" title="Open Fullscreen Overlay" aria-label="Fullscreen Menu">
                <span class="menu-icon-bars">
                    <span class="bar bar-1"></span>
                    <span class="bar bar-2"></span>
                    <span class="bar bar-3"></span>
                </span>
            </a>

        </div>

    </div>

</nav>

<!-- PRELOADER -->
<c:if test="${requestScope.isHome == 'true'}">
<div class="preloader-overlay" id="preloader">
    <div class="preloader-left">
        <div class="preloader-logo">AW</div>
        <div class="preloader-message">
            <span class="pm-line pm-line-1">AURA IS NOT WHAT YOU WEAR.</span>
            <span class="pm-line pm-line-2">IT IS WHO YOU ARE.</span>
            <span class="pm-line pm-line-3">See you in the dreams.</span>
        </div>
    </div>
    <div class="preloader-right">
        <div class="preloader-percent" id="preloaderPercent">0%</div>
        <div class="preloader-status">LOADING STOREFRONT</div>
    </div>
    <div class="preloader-curtain">
        <div class="preloader-col pc-1"></div>
        <div class="preloader-col pc-2"></div>
        <div class="preloader-col pc-3"></div>
    </div>
</div>
</c:if>

<!-- LUXURY OVERLAY MENU -->
<div class="menu-overlay" id="menuOverlay">
    <div class="menu-header">
        <div class="preloader-logo">AW</div>
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
<jsp:include page="../partials/login-modal.jsp" />

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

        <div class="modal-perks" style="margin-top: 24px; border-top: 1.5px solid var(--border-color-solid); padding-top: 20px;">
            <span>📐 Oversized Fit Guarantee</span>
            <span>⚡ Order standard size for a premium relaxed drape</span>
            <span>🌌 Size down for a classic, traditional fit</span>
        </div>
    </div>
</div>

<script>
// ── OUTFIT-STYLE DYNAMIC THEMING CONTROLLER ───────────────────
function setAuraTheme(theme) {
    const htmlEl = document.documentElement;
    htmlEl.classList.remove('theme-noir', 'theme-canvas', 'theme-red');
    if (theme !== 'canvas') {
        htmlEl.classList.add('theme-' + theme);
    }
    localStorage.setItem('auraTheme', theme);
    updateSwatchUI(theme);
}

function updateSwatchUI(theme) {
    document.querySelectorAll('.theme-swatch').forEach(swatch => {
        swatch.classList.remove('active');
    });
    const activeSwatch = document.querySelector('.swatch-' + theme);
    if (activeSwatch) {
        activeSwatch.classList.add('active');
    }
}

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
    // ── Swatch Active UI Initialization
    var savedTheme = localStorage.getItem('auraTheme') || 'canvas';
    updateSwatchUI(savedTheme);

    // ── Preloader Progress Counter
    const percentEl = document.getElementById("preloaderPercent");
    const preloader = document.getElementById("preloader");
    
    if (percentEl && preloader) {
        if (sessionStorage.getItem("auraPreloaderShown") === "true") {
            preloader.style.display = "none";
            preloader.classList.add("loaded");
        } else {
            let count = 0;
            const interval = setInterval(() => {
                count += Math.floor(Math.random() * 8) + 4;
                if (count >= 100) {
                    count = 100;
                    clearInterval(interval);
                    setTimeout(() => {
                        preloader.classList.add("loaded");
                        sessionStorage.setItem("auraPreloaderShown", "true");
                    }, 400);
                }
                percentEl.innerText = count + "%";
            }, 35);
        }
    }

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

    // ── Preloader-Safe Typographical Entrance Guarantee
    setTimeout(() => {
        const firstFoldElements = document.querySelectorAll(
            ".hero [data-scroll-reveal], .cat-panels [data-scroll-reveal], .statement [data-scroll-reveal]"
        );
        firstFoldElements.forEach(el => {
            el.classList.add("reveal-active");
        });
    }, 400);

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

// ── CUSTOM CURSOR FOLLOWER FOR OUTFIT REALM ────────────────────
function initCustomCursorFollower() {
    // Prevent double initialization
    if (document.querySelector('.custom-cursor-follower')) return;

    const follower = document.createElement('div');
    follower.className = 'custom-cursor-follower';
    document.body.appendChild(follower);

    let mouseX = -50;
    let mouseY = -50;
    let currentX = -50;
    let currentY = -50;

    document.addEventListener('mousemove', (e) => {
        mouseX = e.clientX;
        mouseY = e.clientY;
    });

    // Animate custom cursor with linear interpolation (lerp) for ultra-smooth inertia tracking
    function tick() {
        const dx = mouseX - currentX;
        const dy = mouseY - currentY;
        
        currentX += dx * 0.15;
        currentY += dy * 0.15;
        
        follower.style.left = currentX + 'px';
        follower.style.top = currentY + 'px';
        
        requestAnimationFrame(tick);
    }
    tick();

    // Hover events for premium visual expansion on links/buttons
    function addHoverListeners() {
        document.querySelectorAll('a, button, .theme-swatch, .menu-item, .acet-menu-item').forEach(el => {
            if (el.dataset.cursorBound) return;
            el.dataset.cursorBound = "true";
            
            el.addEventListener('mouseenter', () => {
                follower.classList.add('hovered');
            });
            el.addEventListener('mouseleave', () => {
                follower.classList.remove('hovered');
            });
        });
    }

    addHoverListeners();
    
    // Re-bind when mutations occur (e.g. dynamically loaded items)
    const observer = new MutationObserver(addHoverListeners);
    observer.observe(document.body, { childList: true, subtree: true });
}

if (document.readyState === "loading") {
    window.addEventListener("DOMContentLoaded", initCustomCursorFollower);
} else {
    initCustomCursorFollower();
}

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
