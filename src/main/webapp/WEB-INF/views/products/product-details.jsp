<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${product.name} — AuraWear</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/assets/css/home.css">
    <link rel="stylesheet" href="${ctx}/assets/css/product-details.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">

</head>
<body>

    <jsp:include page="../partials/navbar.jsp" />

    <div class="details-wrap">

        <!-- BREADCRUMB -->
        <div class="breadcrumb">
            <a href="${ctx}/home">Home</a>
            <span>/</span>
            <a href="${ctx}/products">${product.category}</a>
            <span>/</span>
            <span>${product.name}</span>
        </div>

        <div class="details-container">

            <!-- IMAGE -->
            <div class="image-section">
                <img src="${ctx}/assets/images/${product.image}"
                     onerror="this.src='${ctx}/assets/images/fallback.jpg'"
                     alt="${product.name}">
            </div>

            <!-- INFO -->
            <div class="info-section">

                <div class="product-category">${product.category}</div>

                <h1>${product.name}</h1>

                <!-- RATING -->
                <div class="rating-row">
                    <span class="stars">
                        <c:forEach begin="1" end="${product.fullStars}">
                            <i class="fa-solid fa-star"></i>
                        </c:forEach>
                        <c:if test="${product.halfStar}">
                            <i class="fa-solid fa-star-half-stroke"></i>
                        </c:if>
                        <c:forEach begin="1" end="${5 - product.fullStars - (product.halfStar ? 1 : 0)}">
                            <i class="fa-regular fa-star"></i>
                        </c:forEach>
                    </span>
                    <span class="rating-value">${product.rating}</span>
                    <span class="reviews-count">(${product.reviews} reviews)</span>
                </div>

                <!-- PRICE -->
                <div class="price">₹<fmt:formatNumber value="${product.price}" maxFractionDigits="0"/></div>

                <div class="divider"></div>

                <!-- META TAGS -->
                <div class="meta-row">
                    <span class="meta-tag">${product.category}</span>
                    <span class="meta-tag">${product.color}</span>
                </div>

                <!-- SIZE SELECTOR -->
                <div>
                    <div class="size-label">SELECT SIZE</div>
                    <div class="sizes">
                        <button data-size="S">S</button>
                        <button data-size="M">M</button>
                        <button data-size="L">L</button>
                        <button data-size="XL">XL</button>
                    </div>
                </div>

                <!-- ACTION BUTTONS -->
                <div class="action-buttons">
                    <button class="add-btn" onclick="addToCart()">Add to Cart</button>
                   <button class="wishlist-btn ${isWishlisted ? 'wishlisted' : ''}" id="wishlistBtn"
        onclick="toggleWishlist(${product.id}, this)">
    <i class="${isWishlisted ? 'fa-solid' : 'fa-regular'} fa-heart"></i>
    ${isWishlisted ? 'Wishlisted' : 'Add to Wishlist'}
</button>
                </div>

            </div>
            <!-- end .info-section -->

        </div>
        <!-- end .details-container -->

    </div>
    <!-- end .details-wrap -->

    <!-- TOAST -->
    <div id="toast"></div>


    <script>
    const ctx = "${ctx}";
    const productId    = ${product.id};
    const productPrice = ${product.price};
    let selectedSize   = null;

    // SIZE SELECT
    document.querySelectorAll(".sizes button").forEach(btn => {
        btn.addEventListener("click", () => {
            document.querySelectorAll(".sizes button").forEach(b => b.classList.remove("active"));
            btn.classList.add("active");
            selectedSize = btn.dataset.size;
        });
    });

    // ADD TO CART
    function addToCart() {
        if (!selectedSize) {
            showToast("Please select a size first");
            return;
        }

        fetch(ctx + "/add-to-cart?id=" + productId + "&size=" + selectedSize + "&price=" + productPrice, {
            method: "GET",
            credentials: "include"
        })
        .then(res => {
            if (res.status === 200) {
                showToast("Added to cart 🛒");
                updateCartCount();
            } else {
                showToast("Please login first ⚠️");
            }
        })
        .catch(() => showToast("Something went wrong"));
    }

    // WISHLIST TOGGLE
    function toggleWishlist(id, btn) {
    fetch(ctx + "/wishlist-toggle?id=" + id, {
        method: "GET",
        credentials: "include"
    })
    .then(res => res.text())
    .then(status => {
        if (status.trim() === "added") {
            btn.innerHTML = '<i class="fa-solid fa-heart"></i> Wishlisted';
            btn.classList.add("wishlisted");
            showToast("Added to wishlist ♡");
        } else {
            btn.innerHTML = '<i class="fa-regular fa-heart"></i> Add to Wishlist';
            btn.classList.remove("wishlisted");
            showToast("Removed from wishlist");
        }
    })
    .catch(() => showToast("Please login first ⚠️"));
}

    // UPDATE CART COUNT IN NAVBAR
    function updateCartCount() {
        fetch(ctx + "/cart-count", { credentials: "include" })
            .then(res => res.text())
            .then(count => {
                const el = document.getElementById("cart-count");
                if (el) el.innerText = count;
            });
    }

    // TOAST
    function showToast(msg) {
        const toast = document.getElementById("toast");
        toast.innerText = msg;
        toast.classList.add("active");
        setTimeout(() => toast.classList.remove("active"), 2500);
    }

    // NAVBAR SCROLL
    window.addEventListener("scroll", function () {
        const nav = document.querySelector(".navbar");
        if (nav) nav.classList.toggle("scrolled", window.scrollY > 80);
    });
    </script>

</body>
</html>
