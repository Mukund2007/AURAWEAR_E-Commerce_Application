<%@ taglib prefix="c"  uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:forEach var="p" items="${products}">
    <div class="product-card ${p.stockQuantity == 0 ? 'oos-card' : ''}" onclick="goToProduct('${p.id}')" data-id="${p.id}" data-name="${p.name}" data-price="${p.price}" data-size="M">

        <img class="img-main"
             src="<c:choose><c:when test="${fn:startsWith(p.image, 'http')}">${p.image}</c:when><c:otherwise>${pageContext.request.contextPath}/assets/images/${p.image}</c:otherwise></c:choose>"
             onerror="this.src='${pageContext.request.contextPath}/assets/images/fallback.jpg'">

        <img class="img-hover"
             src="<c:choose><c:when test="${fn:startsWith(p.image, 'http')}">${p.image}</c:when><c:otherwise>${pageContext.request.contextPath}/assets/images/${p.image}</c:otherwise></c:choose>">

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

        <div class="wishlist"
             onclick="toggleWishlist(event, ${p.id}, this)">♥</div>

        <button class="quick-add ${p.stockQuantity == 0 ? 'disabled' : ''}"
                data-id="${p.id}"
                data-size="M"
                data-price="${p.price}"
                onclick="quickAdd(event)"
                ${p.stockQuantity == 0 ? 'disabled' : ''}>
            ${p.stockQuantity == 0 ? 'Out of Stock' : 'Quick Add'}
        </button>

        <div class="product-info">
            <h3>${p.name}</h3>
            <div class="price">₹${p.price}</div>
        </div>

    </div>
</c:forEach>