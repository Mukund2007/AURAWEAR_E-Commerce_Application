<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c"   uri="jakarta.tags.core"%>
<%@ taglib prefix="fn"  uri="jakarta.tags.functions"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
        <c:choose>
            <c:when test="${not empty param.gender}">${param.gender}'s Collection</c:when>
            <c:when test="${not empty param.category}">${param.category}s</c:when>
            <c:when test="${not empty param.keyword}">"${param.keyword}"</c:when>
            <c:otherwise>All Products</c:otherwise>
        </c:choose>
        — AuraWear
    </title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/assets/css/home.css?v=11">
    <link rel="stylesheet" href="${ctx}/assets/css/products.css?v=13">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">

</head>
<body class="products-page">

    <jsp:include page="../partials/navbar.jsp" />

    <!-- ══ HERO BANNER ════════════════════════════════════════ -->
    <div class="products-hero" data-label="<c:choose><c:when test='${not empty param.gender}'>${param.gender}</c:when><c:when test='${not empty param.category}'>${param.category}</c:when><c:otherwise>ALL</c:otherwise></c:choose>">
        <div class="hero-breadcrumb">
            <a href="${ctx}/home">Home</a>
            <span class="sep">/</span>
            <c:choose>
                <c:when test="${not empty param.gender}">${param.gender}</c:when>
                <c:when test="${not empty param.category}">${param.category}</c:when>
                <c:when test="${not empty param.keyword}">Search: "${param.keyword}"</c:when>
                <c:otherwise>All Products</c:otherwise>
            </c:choose>
        </div>
        <div class="hero-title-row">
            <h1 class="page-title">
                <c:choose>
                    <c:when test="${not empty param.category}">${param.category}s</c:when>
                    <c:when test="${not empty param.gender}">${param.gender}'s Collection</c:when>
                    <c:when test="${not empty param.keyword}">"${param.keyword}"</c:when>
                    <c:otherwise>All Products</c:otherwise>
                </c:choose>
            </h1>
            <div class="hero-sort-bar">
                <select id="sortSelect" onchange="submitSort(this.value)">
                    <option value="">Sort By</option>
                    <option value="priceHigh" ${param.sort == 'priceHigh' ? 'selected' : ''}>Price: High → Low</option>
                    <option value="priceLow"  ${param.sort == 'priceLow'  ? 'selected' : ''}>Price: Low → High</option>
                    <option value="rating"    ${param.sort == 'rating'    ? 'selected' : ''}>Top Rated</option>
                    <option value="newest"    ${param.sort == 'newest'    ? 'selected' : ''}>Newest</option>
                </select>
            </div>
        </div>
    </div>

    <!-- ══ TOOLBAR STRIP ══════════════════════════════════════ -->
    <div class="toolbar-strip">
        <div class="showing">
            Showing <strong>${fn:length(products)}</strong> products
        </div>
        <a href="${ctx}/products" class="clear-btn">Clear All</a>
    </div>

    <div class="page-wrap">

        <div class="shop-layout">

            <!-- ===== FILTER SIDEBAR ===== -->
            <form id="filterForm" method="get" action="${ctx}/products">
                <input type="hidden" name="sort" id="sortHidden" value="${param.sort}">
                <input type="hidden" name="keyword" value="<c:out value='${param.keyword}'/>">
                <div class="filter-sidebar-title">Filter</div>

                <div class="filter-block">
                    <div class="filter-header" onclick="toggleFilter(this)">
                        <h4>CATEGORIES</h4><span>−</span>
                    </div>
                    <div class="filter-content open">
                        <label><input type="checkbox" name="category" value="Tops"> Tops</label>
                        <label><input type="checkbox" name="category" value="Bottoms"> Bottoms</label>
                        <label><input type="checkbox" name="category" value="Pants"> Pants</label>
                        <label><input type="checkbox" name="category" value="Sets"> Sets</label>
                        <label><input type="checkbox" name="category" value="Outerwear"> Outerwear</label>
                        <label><input type="checkbox" name="category" value="Footwear"> Footwear</label>
                        <label><input type="checkbox" name="category" value="Accessories"> Accessories</label>
                    </div>
                </div>

                <div class="filter-block">
                    <div class="filter-header" onclick="toggleFilter(this)">
                        <h4>GENDER</h4><span>+</span>
                    </div>
                    <div class="filter-content">
                        <label><input type="radio" name="gender" value="Men"> Men</label>
                        <label><input type="radio" name="gender" value="Women"> Women</label>
                    </div>
                </div>

                <div class="filter-block">
                    <div class="filter-header" onclick="toggleFilter(this)">
                        <h4>SIZE</h4><span>+</span>
                    </div>
                    <div class="filter-content">
                        <label><input type="checkbox" name="size" value="S"> S</label>
                        <label><input type="checkbox" name="size" value="M"> M</label>
                        <label><input type="checkbox" name="size" value="L"> L</label>
                        <label><input type="checkbox" name="size" value="XL"> XL</label>
                    </div>
                </div>

                <div class="filter-block">
                    <div class="filter-header" onclick="toggleFilter(this)">
                        <h4>COLOR</h4><span>+</span>
                    </div>
                    <div class="filter-content">
                        <label><input type="checkbox" name="color" value="Black"> Black</label>
                        <label><input type="checkbox" name="color" value="White"> White</label>
                        <label><input type="checkbox" name="color" value="Grey"> Grey</label>
                        <label><input type="checkbox" name="color" value="Beige"> Beige</label>
                        <label><input type="checkbox" name="color" value="Navy"> Navy</label>
                        <label><input type="checkbox" name="color" value="Brown"> Brown</label>
                        <label><input type="checkbox" name="color" value="Olive"> Olive</label>
                        <label><input type="checkbox" name="color" value="Blue"> Blue</label>
                        <label><input type="checkbox" name="color" value="Pink"> Pink</label>
                    </div>
                </div>

                <div class="filter-block">
                    <div class="filter-header" onclick="toggleFilter(this)">
                        <h4>PRICE</h4><span>−</span>
                    </div>
                    <div class="filter-content open">
                        <div class="price-slider">
                            <div class="slider-track"></div>
                            <input type="range" id="minRange" name="minPrice" min="0" max="10000" step="100" value="0">
                            <input type="range" id="maxRange" name="maxPrice" min="0" max="10000" step="100" value="10000">
                        </div>
                        <div class="price-label" id="priceLabel">₹0 – ₹10,000+</div>
                    </div>
                </div>

            </form>


            <!-- ===== PRODUCTS SECTION ===== -->
            <div class="products-section">

                <div id="activeFilters" class="active-filters"></div>

                <!-- PRODUCT GRID -->
                <div class="product-grid">
                    <c:choose>
                        <c:when test="${empty products}">
                            <div class="no-products">
                                <i class="fa fa-magnifying-glass no-products-icon"></i>
                                No products found. Try adjusting your filters.
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="p" items="${products}">
                                <div class="product-card ${p.stockQuantity == 0 ? 'oos-card' : ''}" onclick="goToProduct('${p.id}')" data-id="${p.id}" data-name="${p.name}" data-price="${p.price}" data-size="${p.size}">

                                     <div class="product-image">
                                        <img class="img-main"
                                             src="<c:choose><c:when test="${fn:startsWith(p.image, 'http')}">${p.image}</c:when><c:otherwise>${ctx}/assets/images/${p.image}</c:otherwise></c:choose>"
                                             onerror="this.src='${ctx}/assets/images/fallback.jpg'"
                                             alt="${p.name}">
                                        <c:choose>
                                            <c:when test="${p.stockQuantity == 0}">
                                                <div class="badge badge-oos">OUT OF STOCK</div>
                                            </c:when>
                                            <c:when test="${p.stockQuantity <= 5}">
                                                <div class="badge badge-limited">🔥 ONLY ${p.stockQuantity} LEFT!</div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="badge">NEW</div>
                                            </c:otherwise>
                                        </c:choose>

                                        <%-- WISHLIST BUTTON: pre-fill active state from server --%>
                                        <div class="wishlist ${not empty wishlistNames and wishlistNames.contains(p.id) ? 'active' : ''}"
                                             data-id="${p.id}"
                                             onclick="toggleWishlist(event, this)">
                                             <i class="fa fa-heart"></i>
                                        </div>

                                        <%-- QUICK ADD: passes id, size (default from product), price --%>
                                        <button class="quick-add ${p.stockQuantity == 0 ? 'disabled' : ''}"
                                                data-id="${p.id}"
                                                data-size="${p.size}"
                                                data-price="${p.price}"
                                                onclick="quickAdd(event)"
                                                ${p.stockQuantity == 0 ? 'disabled' : ''}>
                                            ${p.stockQuantity == 0 ? 'Out of Stock' : 'Quick Add'}
                                        </button>
                                    </div>

                                    <div class="product-info">
                                        <h3>${p.name}</h3>

                                        <div class="rating">
                                            <c:choose>
                                                <c:when test="${p.reviews == 0}">
                                                    <span class="no-reviews">No reviews yet</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="rating-value">${p.rating}</span>
                                                    <span class="stars">
                                                        <c:forEach begin="1" end="${p.fullStars}">
                                                            <i class="fa-solid fa-star"></i>
                                                        </c:forEach>
                                                        <c:if test="${p.halfStar}">
                                                            <i class="fa-solid fa-star-half-stroke"></i>
                                                        </c:if>
                                                        <c:forEach begin="1" end="${5 - p.fullStars - (p.halfStar ? 1 : 0)}">
                                                            <i class="fa-regular fa-star"></i>
                                                        </c:forEach>
                                                    </span>
                                                    <span class="reviews">(${p.reviews})</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>

                                        <div class="meta">${p.category} • ${p.size} • ${p.color}</div>

                                        <div class="price-row">
                                            <div class="price">₹<fmt:formatNumber value="${p.price}" maxFractionDigits="0"/></div>
                                        </div>
                                    </div>

                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>

            </div>

        </div>

    </div>


    <!-- TOAST NOTIFICATION -->
    <div id="toast" class="toast-msg"></div>


    <script>
    const ctx = "${ctx}";

    function submitForm() {
        document.getElementById("filterForm").submit();
    }

    function submitSort(value) {
        document.getElementById("sortHidden").value = value;
        submitForm();
    }

    function goToProduct(id) {
        const card = document.querySelector(`.product-card[data-id="${id}"]`);
        if (card && card.classList.contains('oos-card')) {
            return;
        }
        window.location.href = ctx + "/product?id=" + id;
    }

    /* ── QUICK ADD ────────── */
    function quickAdd(e) {
        e.stopPropagation();
        const btn = e.currentTarget;
        const id = btn.getAttribute("data-id");
        const size = btn.getAttribute("data-size");
        const price = btn.getAttribute("data-price");
        btn.disabled  = true;
        btn.innerText = "Adding...";

        const url = ctx + "/add-to-cart?id=" + id
                        + "&size=" + encodeURIComponent(size)
                        + "&price=" + price;

        fetch(url, { credentials: "include" })
            .then(res => {
                if (res.status === 401) {
                    window.location.href = ctx + "/login";
                    return;
                }
                if (!res.ok) throw new Error("Failed");
                return res.json();
            })
            .then(data => {
                if (!data) return;
                if (data.success) {
                    btn.innerText = "Added ✓";
                    showToast(btn.closest(".product-card").querySelector("h3").innerText + " added to cart!");
                    updateCartCount();
                } else {
                    btn.innerText = "Out of Stock";
                    showToast(data.message || "This item is out of stock");
                }
                setTimeout(() => {
                    btn.innerText = data.success ? "Quick Add" : "Out of Stock";
                    btn.disabled  = !data.success;
                }, 1400);
            })
            .catch(() => {
                btn.innerText = "Quick Add";
                btn.disabled  = false;
                showToast("Could not add to cart. Try again.");
            });
    }

    /* ── WISHLIST TOGGLE ────────────────────────────────────
       Calls /wishlist-toggle with productId.
       Reads "added"/"removed" from server, then sets heart state
       accurately and shows a toast notification.
     ─────────────────────────────────────────────────────── */
    function toggleWishlist(e, el) {
        e.stopPropagation();
        const id = el.getAttribute("data-id");

        fetch(ctx + "/wishlist-toggle?id=" + id, {
            method: "GET",
            credentials: "include"
        })
        .then(res => {
            if (res.status === 401) {
                window.location.href = ctx + "/login";
                return res.text();
            }
            if (!res.ok) throw new Error("Server error");
            return res.text();
        })
        .then(status => {
            if (!status) return;
            if (status.trim() === "added") {
                el.classList.add("active");
                showToast("Added to wishlist ♡");
            } else {
                el.classList.remove("active");
                showToast("Removed from wishlist");
            }
        })
        .catch(() => {
            showToast("Could not update wishlist. Try again.");
        });
    }

    /* ── CART COUNT ─────────────────────────────────────── */
    function updateCartCount() {
        fetch(ctx + "/cart-count", { credentials: "include" })
            .then(res => res.text())
            .then(count => {
                const el = document.getElementById("cart-count");
                if (el) el.innerText = count;
            });
    }

    /* ── TOAST ──────────────────────────────────────────── */
    function showToast(msg) {
        const toast = document.getElementById("toast");
        toast.innerText = msg;
        toast.classList.add("show");
        setTimeout(() => toast.classList.remove("show"), 2400);
    }

    /* ── FILTER SIDEBAR ─────────────────────────────────── */
    function toggleFilter(el) {
        const content = el.nextElementSibling;
        const icon    = el.querySelector("span");
        const isOpen  = content.classList.toggle("open");
        icon.innerText = isOpen ? "−" : "+";
        try {
            localStorage.setItem("filter_" + el.querySelector("h4").innerText.toLowerCase(), isOpen);
        } catch(e) {}
    }

    function restoreFilterState() {
        document.querySelectorAll(".filter-block").forEach(block => {
            const header  = block.querySelector(".filter-header");
            const content = block.querySelector(".filter-content");
            const icon    = block.querySelector("span");
            const title   = header.querySelector("h4").innerText.toLowerCase();
            try {
                const saved = localStorage.getItem("filter_" + title);
                if (saved === "true")  { content.classList.add("open");    icon.innerText = "−"; }
                if (saved === "false") { content.classList.remove("open"); icon.innerText = "+"; }
            } catch(e) {}
        });
    }

    function restoreFiltersFromURL() {
        const params = new URLSearchParams(window.location.search);
        document.querySelectorAll("#filterForm input[type='checkbox']").forEach(input => {
            input.checked = params.getAll(input.name).includes(input.value);
        });
        const gender = params.get("gender");
        if (gender) {
            const radio = document.querySelector("input[name='gender'][value='" + gender + "']");
            if (radio) radio.checked = true;
        }
        const min = params.get("minPrice");
        const max = params.get("maxPrice");
        if (min) document.getElementById("minRange").value = min;
        if (max) document.getElementById("maxRange").value = max;
        const sort = params.get("sort");
        if (sort) document.getElementById("sortSelect").value = sort;
        updateSlider();
    }

    function renderChips() {
        const container = document.getElementById("activeFilters");
        if (!container) return;
        container.innerHTML = "";
        const params = new URLSearchParams(window.location.search);
        ["category", "size", "color", "gender"].forEach(key => {
            params.getAll(key).forEach(value => {
                if (!value) return;
                container.appendChild(makeChip(value, () => {
                    const url     = new URL(window.location);
                    const updated = url.searchParams.getAll(key).filter(v => v !== value);
                    url.searchParams.delete(key);
                    updated.forEach(v => url.searchParams.append(key, v));
                    window.location.href = url.toString();
                }));
            });
        });
        const min = params.get("minPrice");
        const max = params.get("maxPrice");
        if ((min && min !== "0") || (max && max !== "10000")) {
            container.appendChild(makeChip("₹" + (min || 0) + " – ₹" + (max || "∞"), () => {
                const url = new URL(window.location);
                url.searchParams.delete("minPrice");
                url.searchParams.delete("maxPrice");
                window.location.href = url.toString();
            }));
        }
        const keyword = params.get("keyword");
        if (keyword) {
            container.appendChild(makeChip('"' + keyword + '"', () => {
                const url = new URL(window.location);
                url.searchParams.delete("keyword");
                window.location.href = url.toString();
            }));
        }
    }

    function makeChip(label, onClose) {
        const chip  = document.createElement("div");
        chip.className = "filter-chip";
        const text  = document.createElement("span");
        text.textContent = label;
        const close = document.createElement("span");
        close.className  = "chip-close";
        close.textContent = "×";
        close.onclick = (e) => { e.stopPropagation(); onClose(); };
        chip.appendChild(text);
        chip.appendChild(close);
        return chip;
    }

    /* ── PRICE SLIDER ───────────────────────────────────── */
    const minRange   = document.getElementById("minRange");
    const maxRange   = document.getElementById("maxRange");
    const priceLabel = document.getElementById("priceLabel");
    const track      = document.querySelector(".slider-track");

    function updateSlider() {
        if (!minRange || !maxRange) return;
        let min = parseInt(minRange.value);
        let max = parseInt(maxRange.value);
        if (min > max - 100) { min = max - 100; minRange.value = min; }
        if (max < min + 100) { max = min + 100; maxRange.value = max; }
        priceLabel.innerText = "₹" + min.toLocaleString("en-IN") + " – ₹" + max.toLocaleString("en-IN") + (max >= 10000 ? "+" : "");
        const pMin = (min / 10000) * 100;
        const pMax = (max / 10000) * 100;
        if (track) {
            track.style.background = `linear-gradient(to right, var(--border-color) ${pMin}%, var(--accent-color) ${pMin}%, var(--accent-color) ${pMax}%, var(--border-color) ${pMax}%)`;
        }
    }

    minRange?.addEventListener("input",  updateSlider);
    maxRange?.addEventListener("input",  updateSlider);
    minRange?.addEventListener("change", submitForm);
    maxRange?.addEventListener("change", submitForm);

    /* ── NAVBAR SCROLL ──────────────────────────────────── */
    window.addEventListener("scroll", function () {
        const nav = document.querySelector(".navbar");
        if (nav) nav.classList.toggle("scrolled", window.scrollY > 80);
    });

    /* ── INIT ───────────────────────────────────────────── */
    document.addEventListener("DOMContentLoaded", () => {
        document.querySelectorAll("#filterForm input[type='checkbox'], #filterForm input[type='radio']")
            .forEach(input => input.addEventListener("change", submitForm));
        restoreFiltersFromURL();
        restoreFilterState();
        renderChips();
        updateCartCount();
    });

    // Bind global toast to window so drag add can use it
    window.showToast = showToast;
    </script>
    <script src="${ctx}/assets/js/app-interactions.js?v=11"></script>

</body>
</html>
