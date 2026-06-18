<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fn"  uri="jakarta.tags.functions" %>
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

    <jsp:include page="partials/navbar.jsp" />

    <div class="details-wrap">

        <!-- BREADCRUMB -->
        <div class="breadcrumb">
            <a href="${ctx}/home">Home</a>
            <span>/</span>
            <a href="${ctx}/products?category=${product.category}">${product.category}</a>
            <span>/</span>
            <span>${product.name}</span>
        </div>

        <div class="details-container">

            <!-- LEFT: IMAGE -->
            <div class="image-section">
                <img src="${ctx}/assets/images/${product.image}"
                     onerror="this.src='${ctx}/assets/images/fallback.jpg'"
                     alt="${product.name}">
            </div>

            <!-- RIGHT: INFO -->
            <div class="info-section">
                <div class="product-category">${product.category}</div>
                <h1>${product.name}</h1>

                <!-- RATING -->
                <div class="rating-row">
                    <c:choose>
                        <c:when test="${reviewsCount > 0}">
                            <span class="stars">
                                <c:forEach begin="1" end="${averageFullStars}">
                                    <i class="fa-solid fa-star"></i>
                                </c:forEach>
                                <c:if test="${averageHalfStar}">
                                    <i class="fa-solid fa-star-half-stroke"></i>
                                </c:if>
                                <c:forEach begin="1" end="${5 - averageFullStars - (averageHalfStar ? 1 : 0)}">
                                    <i class="fa-regular fa-star"></i>
                                </c:forEach>
                            </span>
                            <span class="rating-value"><fmt:formatNumber value="${averageRating}" minFractionDigits="1" maxFractionDigits="1"/></span>
                            <span class="reviews-count">(${reviewsCount} review<c:if test="${reviewsCount != 1}">s</c:if>)</span>
                        </c:when>
                        <c:otherwise>
                            <span class="reviews-count">No reviews yet</span>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- PRICE ROW -->
                <div class="price-row">
                    <span class="price">₹<fmt:formatNumber value="${product.price}" maxFractionDigits="0"/></span>
                    <c:if test="${product.discount > 0}">
                        <span class="original-price">₹<fmt:formatNumber value="${product.originalPrice}" maxFractionDigits="0"/></span>
                        <span class="discount-badge">${product.discount}% OFF</span>
                    </c:if>
                </div>

                <div class="divider"></div>

                <!-- SIZE SELECTOR -->
                <c:choose>
                    <c:when test="${product.category eq 'Footwear'}">
                        <c:set var="availSizes" value="${fn:split('UK5,UK6,UK7,UK8,UK9,UK10', ',')}" />
                    </c:when>
                    <c:when test="${product.category eq 'Accessories'}">
                        <c:set var="availSizes" value="${fn:split('Free', ',')}" />
                    </c:when>
                    <c:otherwise>
                        <c:set var="availSizes" value="${fn:split('XS,S,M,L,XL', ',')}" />
                    </c:otherwise>
                </c:choose>

                <div>
                    <div class="size-label">SELECT SIZE</div>
                    <div class="sizes">
                        <c:forEach var="sz" items="${availSizes}">
                            <button type="button" class="size-btn" data-size="${sz}">${sz}</button>
                        </c:forEach>
                    </div>
                </div>

                <!-- ACTION BUTTONS -->
                <div class="action-buttons">
                    <!-- ADD TO CART FORM (POST to /cart) -->
                    <form id="addToCartForm" action="${ctx}/cart" method="POST">
                        <input type="hidden" name="productId" value="${product.id}">
                        <input type="hidden" name="price" value="${product.price}">
                        <input type="hidden" name="size" id="selectedSizeInput" value="">
                        <button type="submit" class="add-btn">Add to Cart</button>
                    </form>

                    <!-- WISHLIST BUTTON -->
                    <button class="wishlist-btn ${isWishlisted ? 'wishlisted' : ''}" id="wishlistBtn"
                            onclick="toggleWishlist(${product.id}, this)">
                        <i class="${isWishlisted ? 'fa-solid' : 'fa-regular'} fa-heart"></i>
                        ${isWishlisted ? 'Wishlisted' : 'Add to Wishlist'}
                    </button>
                </div>

                <!-- SPECIFICATIONS SECTION -->
                <div class="product-specs">
                    <h3>Product Information</h3>
                    <div class="spec-grid">
                        <div class="spec-item">
                            <span class="spec-label">Brand</span>
                            <span class="spec-value">${product.brand}</span>
                        </div>
                        <div class="spec-item">
                            <span class="spec-label">Category</span>
                            <span class="spec-value">${product.category}</span>
                        </div>
                        <div class="spec-item">
                            <span class="spec-label">Type</span>
                            <span class="spec-value">${product.type}</span>
                        </div>
                        <div class="spec-item">
                            <span class="spec-label">Color</span>
                            <span class="spec-value">${product.color}</span>
                        </div>
                        <div class="spec-item">
                            <span class="spec-label">Gender</span>
                            <span class="spec-value">${product.gender}</span>
                        </div>
                    </div>
                </div>

            </div>
            <!-- end .info-section -->

        </div>
        <!-- end .details-container -->

        <!-- PRODUCT REVIEWS SECTION -->
        <div class="reviews-section">
            <h2 class="reviews-title">Customer Reviews</h2>
            
            <!-- review success/error messages -->
            <c:if test="${not empty param.reviewError}">
                <div class="error-banner" style="background: rgba(255, 0, 1, 0.1); border: 1.5px solid var(--accent-color); color: var(--text-color); padding: 16px; font-weight: 800; text-transform: uppercase; font-size: 12px; margin-bottom: 24px; letter-spacing: 0.5px;">
                    <i class="fa-solid fa-triangle-exclamation"></i> ${param.reviewError}
                </div>
            </c:if>
            <c:if test="${not empty param.reviewSuccess}">
                <div class="success-banner" style="background: rgba(46, 204, 113, 0.1); border: 1.5px solid #2ecc71; color: var(--text-color); padding: 16px; font-weight: 800; text-transform: uppercase; font-size: 12px; margin-bottom: 24px; letter-spacing: 0.5px;">
                    <i class="fa-solid fa-circle-check"></i> ${param.reviewSuccess}
                </div>
            </c:if>

            <div class="reviews-container">
                
                <!-- LEFT: Reviews List -->
                <div class="reviews-list">
                    <c:choose>
                        <c:when test="${empty reviews}">
                            <div class="review-info-box" style="text-align: center; width: 100%;">
                                No reviews yet — be the first to review!
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="rev" items="${reviews}">
                                <div class="review-card">
                                    <div class="review-header">
                                        <span class="review-user">${rev.userName}</span>
                                        <span class="review-date">
                                            <fmt:formatDate value="${rev.createdAt}" pattern="yyyy-MM-dd" />
                                        </span>
                                    </div>
                                    <div class="review-stars">
                                        <c:forEach begin="1" end="${rev.rating}">
                                            <i class="fa-solid fa-star"></i>
                                        </c:forEach>
                                        <c:forEach begin="1" end="${5 - rev.rating}">
                                            <i class="fa-regular fa-star"></i>
                                        </c:forEach>
                                    </div>
                                    <p class="review-text">${rev.reviewText}</p>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- RIGHT: Write Review Form (Verified Purchase Only) -->
                <div>
                    <c:choose>
                        <c:when test="${hasPurchased}">
                            <c:choose>
                                <c:when test="${hasAlreadyReviewed}">
                                    <div class="review-info-box">
                                        You've already reviewed this product.
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="review-form-container">
                                        <h3 class="review-form-title">Write a Review</h3>
                                        <form action="${ctx}/review" method="POST">
                                            <input type="hidden" name="productId" value="${product.id}">
                                            
                                            <div class="review-form-group">
                                                <label>Rating</label>
                                                <div class="star-rating-input">
                                                    <input type="radio" id="star5" name="rating" value="5" required />
                                                    <label for="star5" title="5 stars"><i class="fa-solid fa-star"></i></label>
                                                    <input type="radio" id="star4" name="rating" value="4" />
                                                    <label for="star4" title="4 stars"><i class="fa-solid fa-star"></i></label>
                                                    <input type="radio" id="star3" name="rating" value="3" />
                                                    <label for="star3" title="3 stars"><i class="fa-solid fa-star"></i></label>
                                                    <input type="radio" id="star2" name="rating" value="2" />
                                                    <label for="star2" title="2 stars"><i class="fa-solid fa-star"></i></label>
                                                    <input type="radio" id="star1" name="rating" value="1" />
                                                    <label for="star1" title="1 star"><i class="fa-solid fa-star"></i></label>
                                                </div>
                                            </div>

                                            <div class="review-form-group">
                                                <label for="reviewText">Review Details</label>
                                                <textarea id="reviewText" name="reviewText" class="review-textarea" placeholder="Share your experience with this premium curation..." required></textarea>
                                            </div>

                                            <button type="submit" class="review-submit-btn">Submit Review</button>
                                        </form>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <!-- Not purchased, show nothing or brief banner about verified purchase -->
                            <div class="review-info-box" style="opacity: 0.7;">
                                <i class="fa-solid fa-circle-info"></i> Only verified purchasers can review this garment.
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

            </div>
        </div>

        <!-- YOU MAY ALSO LIKE SECTION -->
        <c:if test="${not empty relatedProducts}">
            <div class="related-products">
                <h2 class="related-title">You May Also Like</h2>
                <div class="related-grid">
                    <c:forEach var="p" items="${relatedProducts}">
                        <div class="related-card" onclick="window.location.href='${ctx}/product?id=${p.id}'">
                            <div class="related-img-wrap">
                                <img src="${ctx}/assets/images/${p.image}"
                                     onerror="this.src='${ctx}/assets/images/fallback.jpg'"
                                     alt="${p.name}">
                                <c:if test="${p.discount > 0}">
                                    <span class="related-badge">${p.discount}% OFF</span>
                                </c:if>
                            </div>
                            <div class="related-info">
                                <span class="related-category">${p.category}</span>
                                <h4 class="related-name">${p.name}</h4>
                                <div class="related-bottom">
                                    <div class="related-price-row">
                                        <span class="related-price">₹<fmt:formatNumber value="${p.price}" maxFractionDigits="0"/></span>
                                        <c:if test="${p.discount > 0}">
                                            <span class="related-original-price">₹<fmt:formatNumber value="${p.originalPrice}" maxFractionDigits="0"/></span>
                                        </c:if>
                                    </div>
                                    <span class="related-rating">
                                        <i class="fa-solid fa-star"></i> ${p.rating}
                                    </span>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:if>

    </div>
    <!-- end .details-wrap -->

    <!-- TOAST -->
    <div id="toast"></div>

    <script>
    const ctx = "${ctx}";
    const productId = ${product.id};
    let selectedSize = null;

    // Size selection handler
    document.querySelectorAll(".sizes button.size-btn").forEach(btn => {
        btn.addEventListener("click", () => {
            document.querySelectorAll(".sizes button.size-btn").forEach(b => b.classList.remove("active"));
            btn.classList.add("active");
            selectedSize = btn.dataset.size;
            document.getElementById("selectedSizeInput").value = selectedSize;
        });
    });

    // Cart form submit validation
    document.getElementById("addToCartForm").addEventListener("submit", function(e) {
        if (!selectedSize) {
            e.preventDefault();
            showToast("Please select a size first ⚠️");
        }
    });

    // Wishlist Toggle
    function toggleWishlist(id, btn) {
        fetch(ctx + "/wishlist-toggle?id=" + id, {
            method: "GET",
            credentials: "include"
        })
        .then(res => {
            if (res.status === 401) {
                showToast("Please login first ⚠️");
                setTimeout(() => {
                    window.location.href = ctx + "/login";
                }, 1500);
                return;
            }
            return res.text();
        })
        .then(status => {
            if (!status) return;
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
        .catch(() => showToast("Something went wrong"));
    }

    // Toast utility
    function showToast(msg) {
        const toast = document.getElementById("toast");
        toast.innerText = msg;
        toast.classList.add("active");
        setTimeout(() => toast.classList.remove("active"), 2500);
    }

    // Navbar scroll effect
    window.addEventListener("scroll", function () {
        const nav = document.querySelector(".navbar");
        if (nav) nav.classList.toggle("scrolled", window.scrollY > 80);
    });
    </script>

</body>
</html>
