<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fn"  uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Wishlist — AuraWear</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/assets/css/home.css">
    <link rel="stylesheet" href="${ctx}/assets/css/wishlist.css">
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
</head>
<body>

    <jsp:include page="../partials/navbar.jsp" />

    <div class="wishlist-page">

        <!-- HEADER -->
        <div class="wishlist-header">
            <div class="wishlist-header-inner">
                <div class="wishlist-header-text">
                    <h1>My Wishlist</h1>
                    <p>
                        <c:choose>
                            <c:when test="${not empty wishlist}">
                                ${wishlist.size()} saved item<c:if test="${wishlist.size() != 1}">s</c:if>
                            </c:when>
                            <c:otherwise>Items you've saved for later</c:otherwise>
                        </c:choose>
                    </p>
                </div>
                <a href="${ctx}/products" class="wishlist-shop-btn">
                    <i class="fa-solid fa-bag-shopping"></i> Continue Shopping
                </a>
            </div>
        </div>

        <!-- CONTENT -->
        <div class="wishlist-container">
            <c:choose>

                <c:when test="${empty wishlist}">
                    <div class="wishlist-empty">
                        <div class="wishlist-empty-icon">
                            <i class="fa-regular fa-heart"></i>
                        </div>
                        <h3>Your wishlist is empty</h3>
                        <p>Save items you love by tapping the heart on any product.<br>They'll appear here for easy access.</p>
                        <a href="${ctx}/products" class="wishlist-browse-btn">Discover Products</a>
                    </div>
                </c:when>

                <c:otherwise>
                    <div class="wishlist-grid" id="wishlistGrid">
                        <c:forEach var="item" items="${wishlist}">
                            <div class="wishlist-card" id="wcard-${item.productId}">

                                <button class="wl-remove-btn"
                                        onclick="removeItem(event, ${item.productId}, '${item.productName}')"
                                        title="Remove">
                                    <i class="fa-solid fa-xmark"></i>
                                </button>

                                <div class="wl-image-wrap"
                                     onclick="window.location.href='${ctx}/product?id=${item.productId}'">
                                    <c:choose>
                                        <c:when test="${not empty item.image}">
                                            <img src="<c:choose><c:when test="${fn:startsWith(item.image, 'http')}">${item.image}</c:when><c:otherwise>${ctx}/assets/images/${item.image}</c:otherwise></c:choose>"
                                                 onerror="this.style.display='none';this.nextElementSibling.style.display='flex'"
                                                 alt="${item.productName}">
                                            <div class="wl-img-fallback" style="display:none;">
                                                <i class="fa-solid fa-shirt"></i>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="wl-img-fallback">
                                                <i class="fa-solid fa-shirt"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <div class="wl-info">
                                    <h3 class="wl-name">${item.productName}</h3>
                                    <div class="wl-price">
                                        ₹<fmt:formatNumber value="${item.price}" maxFractionDigits="0"/>
                                    </div>
                                </div>

                                <button class="wl-add-btn"
                                        onclick="addToCart(event, ${item.productId}, '${item.size}', ${item.price})">
                                    <i class="fa-solid fa-bag-shopping"></i> Add to Cart
                                </button>

                            </div>
                        </c:forEach>
                    </div>

                    <div class="wishlist-strip">
                        <span id="wishlistCount">
                            <i class="fa-regular fa-heart"></i>
                            ${wishlist.size()} saved item<c:if test="${wishlist.size() != 1}">s</c:if>
                        </span>
                        <a href="${ctx}/products">Shop more <i class="fa-solid fa-arrow-right"></i></a>
                    </div>
                </c:otherwise>

            </c:choose>
        </div>

    </div>

    <div id="toast" class="wl-toast"></div>

    <script>
    const ctx = "${ctx}";

    function removeItem(e, productId, productName) {
        e.stopPropagation();
        fetch(ctx + "/wishlist-toggle?id=" + productId, {
            credentials: "include"
        })
        .then(res => {
            if (res.status === 401) { window.location.href = ctx + "/login"; return; }
            if (!res.ok) throw new Error();
            const card = document.getElementById("wcard-" + productId);
            if (card) {
                card.style.transition = "opacity 0.3s, transform 0.3s";
                card.style.opacity = "0";
                card.style.transform = "scale(0.95)";
                setTimeout(() => { card.remove(); refreshCount(); }, 300);
            }
            showToast(productName + " removed from wishlist");
        })
        .catch(() => showToast("Could not remove. Try again."));
    }

    function addToCart(e, productId, size, price) {
        e.stopPropagation();
        const btn = e.currentTarget;
        btn.disabled = true;
        btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Adding...';

        fetch(ctx + "/add-to-cart?id=" + productId
                + "&size=" + encodeURIComponent(size || "M")
                + "&price=" + price, {
            credentials: "include"
        })
        .then(res => {
            if (res.status === 401) { window.location.href = ctx + "/login"; return; }
            if (!res.ok) throw new Error();
            btn.innerHTML = '<i class="fa-solid fa-check"></i> Added!';
            showToast("Added to cart!");
            updateCartCount();
            setTimeout(() => {
                btn.disabled = false;
                btn.innerHTML = '<i class="fa-solid fa-bag-shopping"></i> Add to Cart';
            }, 1400);
        })
        .catch(() => {
            btn.disabled = false;
            btn.innerHTML = '<i class="fa-solid fa-bag-shopping"></i> Add to Cart';
            showToast("Could not add to cart. Try again.");
        });
    }

    function updateCartCount() {
        fetch(ctx + "/cart-count", { credentials: "include" })
        .then(res => res.text())
        .then(count => {
            const el = document.getElementById("cart-count");
            if (el) el.innerText = count;
        });
    }

    function refreshCount() {
        const count = document.querySelectorAll(".wishlist-card").length;
        const el = document.getElementById("wishlistCount");
        if (el) el.innerHTML = '<i class="fa-regular fa-heart"></i> '
            + count + ' saved item' + (count !== 1 ? 's' : '');
        if (count === 0) {
            document.querySelector(".wishlist-container").innerHTML = `
                <div class="wishlist-empty">
                    <div class="wishlist-empty-icon"><i class="fa-regular fa-heart"></i></div>
                    <h3>Your wishlist is empty</h3>
                    <p>Save items you love by tapping the heart on any product.</p>
                    <a href="${ctx}/products" class="wishlist-browse-btn">Discover Products</a>
                </div>`;
        }
    }

    function showToast(msg) {
        const toast = document.getElementById("toast");
        toast.innerText = msg;
        toast.classList.add("show");
        setTimeout(() => toast.classList.remove("show"), 2400);
    }

    window.addEventListener("scroll", function () {
        const nav = document.querySelector(".navbar");
        if (nav) nav.classList.toggle("scrolled", window.scrollY > 80);
    });
    </script>

</body>
</html>
