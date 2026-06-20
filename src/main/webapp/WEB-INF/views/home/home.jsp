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
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;600;700;900&family=Public+Sans:wght@300;600;700;900&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        primary: "var(--accent-color)",
                        background: "var(--bg-color)",
                        surface: "var(--card-bg)",
                        foreground: "var(--text-color)",
                        border: "var(--border-color)"
                    },
                    borderRadius: {
                        "DEFAULT": "0px",
                        "lg": "0px",
                        "xl": "0px",
                        "full": "9999px"
                    },
                    fontFamily: {
                        headline: ["Outfit", "Public Sans", "sans-serif"],
                        display: ["Outfit", "Public Sans", "sans-serif"],
                        body: ["Outfit", "Public Sans", "sans-serif"],
                        label: ["Outfit", "Public Sans", "sans-serif"]
                    },
                    boxShadow: {
                        'brutalist': '4px 4px 0px var(--border-color-solid)',
                        'brutalist-hover': '2px 2px 0px var(--border-color-solid)'
                    }
                },
            },
        }
    </script>
    <style>
        @keyframes scroll {
            0% { transform: translateX(0); }
            100% { transform: translateX(-50%); }
        }
        .marquee-container {
            overflow: hidden;
            white-space: nowrap;
        }
        .marquee-content {
            display: inline-block;
            animation: scroll 20s linear infinite;
        }
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
            vertical-align: middle;
        }
        .hide-scrollbar::-webkit-scrollbar {
            display: none;
        }
        .hide-scrollbar {
            -ms-overflow-style: none;
            scrollbar-width: none;
        }
        body {
            background-color: var(--bg-color);
            color: var(--text-color);
            font-family: 'Outfit', sans-serif;
            text-transform: uppercase;
        }
        /* Custom cursor styling to fit into page if loaded in navbar */
        .custom-cursor-follower {
            pointer-events: none;
        }
        .product-card.dragging {
            user-select: none;
            pointer-events: none;
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
<body class="selection:bg-primary selection:text-background overflow-x-hidden">
    <c:set var="isHome" value="true" scope="request" />
    <jsp:include page="../partials/navbar.jsp" />

    <!-- Hero Section -->
    <section class="min-h-screen flex flex-col md:flex-row border-b border-border">
        <div class="flex-grow flex-shrink flex-1 bg-background flex flex-col justify-center p-8 md:p-16 relative">
            <p class="text-primary font-bold tracking-[0.2em] mb-4">AW '25 — NEW ARRIVAL</p>
            <h1 class="text-6xl md:text-8xl lg:text-9xl font-black tracking-tighter leading-none mb-12 text-foreground">
                DEFINE YOUR<br/>AURA.
            </h1>
            <div class="flex flex-wrap gap-4 mb-20">
                <a href="${ctx}/products?gender=Men" class="bg-primary text-background px-10 py-4 font-black tracking-widest shadow-brutalist hover:shadow-none hover:translate-x-1 hover:translate-y-1 transition-all inline-block border border-border">
                    SHOP MEN
                </a>
                <a href="${ctx}/products?gender=Women" class="border-2 border-foreground text-foreground px-10 py-4 font-black tracking-widest hover:bg-foreground hover:text-background transition-all inline-block">
                    SHOP WOMEN
                </a>
            </div>
            <!-- Bottom Strip -->
            <div class="absolute bottom-0 left-0 w-full border-t border-border py-4 px-8 overflow-hidden whitespace-nowrap">
                <div class="flex gap-12 font-bold tracking-widest text-xs opacity-70">
                    <span>FREE DELIVERY ABOVE ₹999</span>
                    <span>|</span>
                    <span>LIMITED DROPS</span>
                    <span>|</span>
                    <span>WORLDWIDE SHIPPING</span>
                </div>
            </div>
        </div>
        <div class="flex-grow flex-shrink flex-1 min-h-[500px] md:min-h-0 relative overflow-hidden">
            <img alt="High-fashion editorial streetwear" class="absolute inset-0 w-full h-full object-cover transition-transform duration-700 hover:scale-105" src="${ctx}/assets/images/hero-main.jpg" onerror="this.src='${ctx}/assets/images/fallback.jpg'"/>
        </div>
    </section>

    <!-- Marquee -->
    <div class="bg-primary text-background py-4 marquee-container border-y border-border">
        <div class="marquee-content font-black text-2xl md:text-4xl tracking-tighter uppercase">
            STREET LUXURY * DEFINE YOUR AURA * AW TWENTY FIVE * CURATED DROPS * PREMIUM FITS * &nbsp;
            STREET LUXURY * DEFINE YOUR AURA * AW TWENTY FIVE * CURATED DROPS * PREMIUM FITS * &nbsp;
        </div>
    </div>

    <!-- Style Pills -->
    <section class="px-6 py-12 flex gap-4 overflow-x-auto hide-scrollbar border-b border-border">
        <a href="${ctx}/products?category=Streetwear" class="border border-border px-6 py-2 whitespace-nowrap font-bold tracking-widest text-sm hover:bg-primary hover:text-background transition-all">STREETWEAR</a>
        <a href="${ctx}/products?category=Minimal" class="border border-border px-6 py-2 whitespace-nowrap font-bold tracking-widest text-sm hover:bg-primary hover:text-background transition-all">MINIMAL</a>
        <a href="${ctx}/products?category=Outerwear" class="border border-border px-6 py-2 whitespace-nowrap font-bold tracking-widest text-sm hover:bg-primary hover:text-background transition-all">OUTERWEAR</a>
        <a href="${ctx}/products?category=Techwear" class="border border-border px-6 py-2 whitespace-nowrap font-bold tracking-widest text-sm hover:bg-primary hover:text-background transition-all">TECHWEAR</a>
        <a href="${ctx}/products?category=Sets" class="border border-border px-6 py-2 whitespace-nowrap font-bold tracking-widest text-sm hover:bg-primary hover:text-background transition-all">CO-ORDS</a>
        <a href="${ctx}/products?category=Footwear" class="border border-border px-6 py-2 whitespace-nowrap font-bold tracking-widest text-sm hover:bg-primary hover:text-background transition-all">FOOTWEAR</a>
        <a href="${ctx}/products?category=Accessories" class="border border-border px-6 py-2 whitespace-nowrap font-bold tracking-widest text-sm hover:bg-primary hover:text-background transition-all">ACCESSORIES</a>
    </section>

    <!-- Categories -->
    <section class="px-6 py-12 grid grid-cols-1 md:grid-cols-3 gap-6 border-b border-border bg-background">
        <!-- MEN -->
        <a class="group relative aspect-[3/4] overflow-hidden border border-border" href="${ctx}/products?gender=Men">
            <img alt="Men's category" class="absolute inset-0 w-full h-full object-cover transition-transform duration-700 group-hover:scale-110" src="${ctx}/assets/images/over1.jpg" onerror="this.src='${ctx}/assets/images/fallback.jpg'"/>
            <div class="absolute inset-0 bg-gradient-to-t from-background via-transparent to-transparent opacity-80"></div>
            <div class="absolute bottom-0 left-0 p-8 w-full flex justify-between items-end text-foreground">
                <div>
                    <span class="text-primary font-black text-2xl block mb-2">01</span>
                    <h3 class="text-4xl font-black tracking-tighter">MEN</h3>
                </div>
                <span class="material-symbols-outlined text-4xl group-hover:translate-x-2 transition-transform" data-icon="arrow_forward">arrow_forward</span>
            </div>
        </a>
        <!-- WOMEN -->
        <a class="group relative aspect-[3/4] overflow-hidden border border-border" href="${ctx}/products?gender=Women">
            <img alt="Women's category" class="absolute inset-0 w-full h-full object-cover transition-transform duration-700 group-hover:scale-110" src="${ctx}/assets/images/over3.jpg" onerror="this.src='${ctx}/assets/images/fallback.jpg'"/>
            <div class="absolute inset-0 bg-gradient-to-t from-background via-transparent to-transparent opacity-80"></div>
            <div class="absolute bottom-0 left-0 p-8 w-full flex justify-between items-end text-foreground">
                <div>
                    <span class="text-primary font-black text-2xl block mb-2">02</span>
                    <h3 class="text-4xl font-black tracking-tighter">WOMEN</h3>
                </div>
                <span class="material-symbols-outlined text-4xl group-hover:translate-x-2 transition-transform" data-icon="arrow_forward">arrow_forward</span>
            </div>
        </a>
        <!-- EXTRAS -->
        <a class="group relative aspect-[3/4] overflow-hidden border border-border" href="${ctx}/products?category=Accessories">
            <img alt="Extras category" class="absolute inset-0 w-full h-full object-cover transition-transform duration-700 group-hover:scale-110" src="${ctx}/assets/images/bag1.jpg" onerror="this.src='${ctx}/assets/images/fallback.jpg'"/>
            <div class="absolute inset-0 bg-gradient-to-t from-background via-transparent to-transparent opacity-80"></div>
            <div class="absolute bottom-0 left-0 p-8 w-full flex justify-between items-end text-foreground">
                <div>
                    <span class="text-primary font-black text-2xl block mb-2">03</span>
                    <h3 class="text-4xl font-black tracking-tighter">EXTRAS</h3>
                </div>
                <span class="material-symbols-outlined text-4xl group-hover:translate-x-2 transition-transform" data-icon="arrow_forward">arrow_forward</span>
            </div>
        </a>
    </section>

    <!-- Editorial Quote Section -->
    <section class="px-6 py-24 bg-surface flex flex-col md:flex-row items-center gap-16 border-b border-border">
        <div class="md:w-1/2">
            <span class="text-primary font-black text-6xl md:text-9xl opacity-20 block leading-none">01</span>
            <blockquote class="text-3xl md:text-5xl font-black tracking-tighter leading-tight mt-[-2rem] relative z-10 text-foreground">
                "WE MAKE CLOTHES FOR PEOPLE WHO DON'T FOLLOW TRENDS — THEY SET THEM."
            </blockquote>
        </div>
        <div class="md:w-1/2 grid grid-cols-2 gap-8 w-full">
            <div class="border-l-4 border-primary p-6">
                <p class="text-4xl font-black tracking-tighter leading-none text-foreground">50K+</p>
                <p class="text-xs font-bold tracking-widest opacity-60 mt-2 text-foreground">CUSTOMERS</p>
            </div>
            <div class="border-l-4 border-primary p-6">
                <p class="text-4xl font-black tracking-tighter leading-none text-foreground">2K+</p>
                <p class="text-xs font-bold tracking-widest opacity-60 mt-2 text-foreground">PRODUCTS</p>
            </div>
            <div class="border-l-4 border-primary p-6">
                <p class="text-4xl font-black tracking-tighter leading-none text-foreground">4.9★</p>
                <p class="text-xs font-bold tracking-widest opacity-60 mt-2 text-foreground">RATING</p>
            </div>
            <div class="border-l-4 border-primary p-6">
                <p class="text-4xl font-black tracking-tighter leading-none text-foreground">48H</p>
                <p class="text-xs font-bold tracking-widest opacity-60 mt-2 text-foreground">DISPATCH</p>
            </div>
        </div>
    </section>

    <!-- Horizontal Product Scroll -->
    <section class="px-6 py-24 overflow-hidden border-b border-border bg-background">
        <div class="flex justify-between items-end mb-12">
            <div>
                <h2 class="text-5xl md:text-7xl font-black tracking-tighter text-foreground">NEW DROPS</h2>
                <p class="text-primary font-bold tracking-widest mt-2">STREET READY ESSENTIALS</p>
            </div>
            <div class="flex gap-4">
                <button onclick="scrollCards(-1)" class="w-12 h-12 border border-border flex items-center justify-center hover:bg-foreground hover:text-background transition-colors">
                    <span class="material-symbols-outlined" data-icon="chevron_left">chevron_left</span>
                </button>
                <button onclick="scrollCards(1)" class="w-12 h-12 border border-border flex items-center justify-center hover:bg-foreground hover:text-background transition-colors">
                    <span class="material-symbols-outlined" data-icon="chevron_right">chevron_right</span>
                </button>
            </div>
        </div>
        
        <div class="flex gap-8 overflow-x-auto hide-scrollbar pb-12" id="trendingScroll">
            <c:forEach var="p" items="${products}">
                <div class="product-card min-w-[300px] md:min-w-[400px] flex-shrink-0 group cursor-pointer ${p.stockQuantity == 0 ? 'oos-card' : ''}" 
                     onclick="goToProduct('${p.id}')"
                     data-id="${p.id}" data-name="${p.name}" data-price="${p.price}" data-size="M">
                    <div class="relative aspect-[4/5] bg-surface overflow-hidden border border-border">
                        <img class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-105" 
                             src="<c:choose><c:when test="${fn:startsWith(p.image, 'http')}">${p.image}</c:when><c:otherwise>${ctx}/assets/images/${p.image}</c:otherwise></c:choose>"
                             onerror="this.src='${ctx}/assets/images/fallback.jpg'"
                             alt="${p.name}">
                        
                        <c:choose>
                            <c:when test="${p.stockQuantity == 0}">
                                <div class="absolute top-4 left-4 bg-primary text-background px-3 py-1 font-black text-xs tracking-widest border border-border">OUT OF STOCK</div>
                            </c:when>
                            <c:when test="${p.stockQuantity <= 5}">
                                <div class="absolute top-4 left-4 bg-primary text-background px-3 py-1 font-black text-xs tracking-widest border border-border">🔥 ONLY ${p.stockQuantity} LEFT!</div>
                            </c:when>
                            <c:otherwise>
                                <div class="absolute top-4 left-4 bg-primary text-background px-3 py-1 font-black text-xs tracking-widest border border-border">NEW</div>
                            </c:otherwise>
                        </c:choose>

                        <button class="absolute top-4 right-4 text-foreground hover:text-primary transition-colors ${not empty wishlistNames and wishlistNames.contains(p.id) ? 'active text-primary' : ''}" 
                                data-id="${p.id}"
                                onclick="toggleWishlist(event, this)">
                            <span class="material-symbols-outlined" style="${not empty wishlistNames and wishlistNames.contains(p.id) ? 'font-variation-settings: \'FILL\' 1;' : ''}">favorite</span>
                        </button>
                        
                        <button class="absolute bottom-0 left-0 w-full bg-foreground text-background py-4 font-black tracking-widest transform translate-y-full group-hover:translate-y-0 transition-transform duration-300 ${p.stockQuantity == 0 ? 'disabled opacity-50' : ''}" 
                                data-id="${p.id}" 
                                data-size="${p.size}" 
                                data-price="${p.price}" 
                                onclick="quickAdd(event)"
                                ${p.stockQuantity == 0 ? 'disabled' : ''}>
                            ${p.stockQuantity == 0 ? 'OUT OF STOCK' : '+ ADD TO BAG'}
                        </button>
                    </div>
                    <div class="mt-6">
                        <p class="text-xs font-bold tracking-widest opacity-50 mb-1">${p.category}</p>
                        <div class="flex justify-between items-start">
                            <h4 class="text-xl font-black tracking-tighter text-foreground">${p.name}</h4>
                            <span class="font-black text-xl text-foreground">₹<fmt:formatNumber value="${p.price}" maxFractionDigits="0"/></span>
                        </div>
                        <div class="flex gap-1 mt-2 text-primary">
                            <span class="material-symbols-outlined text-sm" style="font-variation-settings: 'FILL' 1;">star</span>
                            <span class="text-foreground text-xs ml-1 opacity-50">(${p.rating} ★)</span>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </section>

    <!-- Feature Drop -->
    <section class="relative h-[80vh] flex items-center justify-center overflow-hidden border-b border-border">
        <div class="absolute inset-0">
            <img alt="AW25 Collection Drop" class="w-full h-full object-cover transition-transform duration-1000 hover:scale-105" src="${ctx}/assets/images/feature-drop-new.jpg" onerror="this.src='${ctx}/assets/images/fallback.jpg'"/>
            <div class="absolute inset-0 bg-background/40"></div>
        </div>
        <div class="relative z-10 text-center px-6">
            <p class="text-primary font-black tracking-[0.4em] mb-4">LIMITED RELEASE — AW25</p>
            <h2 class="text-7xl md:text-[10rem] font-black tracking-tighter leading-none mb-12 text-[#ede4dd]">STREET<br/>LUXURY</h2>
            <a href="${ctx}/collections" class="bg-foreground text-background px-12 py-5 font-black tracking-widest shadow-brutalist hover:shadow-none hover:translate-x-1 hover:translate-y-1 transition-all inline-block border border-border">
                EXPLORE THE DROP
            </a>
        </div>
    </section>

    <!-- Benefits Section -->
    <section class="px-6 py-24 grid grid-cols-2 md:grid-cols-5 gap-12 border-b border-border bg-background">
        <div class="flex flex-col items-center text-center">
            <span class="material-symbols-outlined text-5xl mb-4 text-primary" data-icon="local_shipping">local_shipping</span>
            <p class="font-bold tracking-widest text-xs text-foreground">FREE DELIVERY</p>
        </div>
        <div class="flex flex-col items-center text-center">
            <span class="material-symbols-outlined text-5xl mb-4 text-primary" data-icon="verified">verified</span>
            <p class="font-bold tracking-widest text-xs text-foreground">PREMIUM QUALITY</p>
        </div>
        <div class="flex flex-col items-center text-center">
            <span class="material-symbols-outlined text-5xl mb-4 text-primary" data-icon="keyboard_return">keyboard_return</span>
            <p class="font-bold tracking-widest text-xs text-foreground">EASY RETURNS</p>
        </div>
        <div class="flex flex-col items-center text-center">
            <span class="material-symbols-outlined text-5xl mb-4 text-primary" data-icon="shield">shield</span>
            <p class="font-bold tracking-widest text-xs text-foreground">SECURE CHECKOUT</p>
        </div>
        <div class="flex flex-col items-center text-center col-span-2 md:col-span-1">
            <span class="material-symbols-outlined text-5xl mb-4 text-primary" data-icon="support_agent">support_agent</span>
            <p class="font-bold tracking-widest text-xs text-foreground">24/7 SUPPORT</p>
        </div>
    </section>

    <!-- Newsletter -->
    <section class="px-6 py-24 flex flex-col md:flex-row items-center gap-12 bg-surface">
        <div class="md:w-1/2">
            <h2 class="text-5xl md:text-7xl font-black tracking-tighter leading-none text-foreground">JOIN THE CIRCLE.</h2>
            <p class="text-primary font-bold tracking-[0.3em] mt-2">EARLY ACCESS.</p>
        </div>
        <div class="md:w-1/2 w-full flex flex-col sm:flex-row gap-0">
            <input class="flex-grow bg-background border-2 border-foreground p-5 font-bold tracking-widest outline-none focus:border-primary transition-colors uppercase text-foreground" id="nlEmail" placeholder="YOUR@EMAIL.COM" type="email"/>
            <button onclick="subscribe()" class="bg-foreground text-background px-10 py-5 font-black tracking-widest hover:bg-primary hover:text-background transition-colors border-2 border-foreground">
                SUBSCRIBE
            </button>
        </div>
    </section>

    <!-- Footer -->
    <footer class="w-full px-6 py-12 grid grid-cols-1 md:grid-cols-4 gap-8 bg-background border-t border-border">
        <div class="col-span-1 md:col-span-1">
            <div class="text-4xl font-black tracking-[-3px] uppercase text-foreground mb-8">AURAWEAR</div>
            <p class="text-xs font-bold tracking-[0.2em] opacity-60 leading-relaxed mb-8 text-foreground">
                PREMIUM STREETWEAR FOR THE BOLD. DEFINING THE AESTHETIC OF THE NEW ERA.
            </p>
            <div class="flex gap-4">
                <a class="hover:text-primary transition-colors" href="#"><span class="material-symbols-outlined" data-icon="share">share</span></a>
                <a class="hover:text-primary transition-colors" href="#">INSTAGRAM</a>
                <a class="hover:text-primary transition-colors" href="#">TIKTOK</a>
            </div>
        </div>
        <div>
            <h5 class="font-black text-xl mb-6 tracking-tighter text-foreground">SHOP</h5>
            <ul class="space-y-4 font-body uppercase font-bold tracking-widest text-xs">
                <li><a class="text-foreground hover:bg-primary hover:text-background p-1 transition-all" href="${ctx}/products?gender=Men">MEN</a></li>
                <li><a class="text-foreground hover:bg-primary hover:text-background p-1 transition-all" href="${ctx}/products?gender=Women">WOMEN</a></li>
                <li><a class="text-foreground hover:bg-primary hover:text-background p-1 transition-all" href="${ctx}/products?category=Accessories">ACCESSORIES</a></li>
                <li><a class="text-foreground hover:bg-primary hover:text-background p-1 transition-all" href="${ctx}/collections">COLLECTIONS</a></li>
            </ul>
        </div>
        <div>
            <h5 class="font-black text-xl mb-6 tracking-tighter text-foreground">ACCOUNT</h5>
            <ul class="space-y-4 font-body uppercase font-bold tracking-widest text-xs">
                <li><a class="text-foreground hover:bg-primary hover:text-background p-1 transition-all" href="${ctx}/profile">PROFILE</a></li>
                <li><a class="text-foreground hover:bg-primary hover:text-background p-1 transition-all" href="${ctx}/my-orders">ORDERS</a></li>
                <li><a class="text-foreground hover:bg-primary hover:text-background p-1 transition-all" href="${ctx}/wishlist">WISHLIST</a></li>
                <li><a class="text-foreground hover:bg-primary hover:text-background p-1 transition-all" href="${ctx}/cart">CART</a></li>
            </ul>
        </div>
        <div>
            <h5 class="font-black text-xl mb-6 tracking-tighter text-foreground">HELP</h5>
            <ul class="space-y-4 font-body uppercase font-bold tracking-widest text-xs">
                <li><a class="text-foreground hover:bg-primary hover:text-background p-1 transition-all" href="${ctx}/my-orders">SHIPPING &amp; RETURNS</a></li>
                <li><a class="text-foreground hover:bg-primary hover:text-background p-1 transition-all" href="javascript:void(0)" onclick="openSizeGuide()">SIZE GUIDE</a></li>
                <li><a class="text-foreground hover:bg-primary hover:text-background p-1 transition-all" href="mailto:support@aurawear.com">CONTACT</a></li>
            </ul>
        </div>
        <div class="col-span-1 md:col-span-4 mt-12 pt-8 border-t border-border flex flex-col md:flex-row justify-between items-center gap-4">
            <p class="font-body uppercase font-bold tracking-widest text-xs text-foreground opacity-50">© 2025 AURAWEAR. ALL RIGHTS RESERVED.</p>
            <div class="flex gap-4">
                <span class="material-symbols-outlined opacity-50" data-icon="payments">payments</span>
                <span class="material-symbols-outlined opacity-50" data-icon="credit_card">credit_card</span>
            </div>
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
                el.classList.add("text-primary");
                if (icon) { icon.style.fontVariationSettings = "'FILL' 1"; }
                showToast("Added to wishlist ♡");
            } else {
                el.classList.remove("active");
                el.classList.remove("text-primary");
                if (icon) { icon.style.fontVariationSettings = "'FILL' 0"; }
                showToast("Removed from wishlist");
            }
        })
        .catch(() => {
            showToast("Could not update wishlist. Try again.");
        });
    }

    function scrollCards(dir) {
        const el = document.getElementById("trendingScroll");
        el.scrollBy({ left: dir * 400, behavior: 'smooth' });
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

    // Parallax
    window.addEventListener('scroll', () => {
        const scrolled = window.pageYOffset;
        const heroImg = document.querySelector('section img');
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
