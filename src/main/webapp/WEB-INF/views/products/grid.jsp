<c:forEach var="p" items="${products}">
    <div class="product-card" onclick="goToProduct('${p.id}')" data-id="${p.id}" data-name="${p.name}" data-price="${p.price}" data-size="M">

        <img class="img-main"
             src="${pageContext.request.contextPath}/assets/images/${p.image}"
             onerror="this.src='${pageContext.request.contextPath}/assets/images/fallback.jpg'">

        <img class="img-hover"
             src="${pageContext.request.contextPath}/assets/images/${p.image}">

        <div class="badge">NEW</div>

        <div class="wishlist"
             onclick="toggleWishlist(event, ${p.id}, this)">♥</div>

        <button class="quick-add"
                onclick="addToCart(event, ${p.id})">
            Quick Add
        </button>

        <div class="product-info">
            <h3>${p.name}</h3>
            <div class="price">₹${p.price}</div>
        </div>

    </div>
</c:forEach>