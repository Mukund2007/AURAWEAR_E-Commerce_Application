<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ page import="java.util.*, com.aurawear.model.CartItem" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<%
    List<CartItem> cart = (List<CartItem>) request.getAttribute("cartItems");
    int total     = 0;
    int itemCount = 0;
    if (cart != null) {
        itemCount = cart.size();
        for (CartItem item : cart) {
            total += item.getPrice() * item.getQuantity();
        }
    }
    String ctxPath = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Bag — AuraWear</title>

    <link rel="stylesheet" href="${ctx}/assets/css/home.css">
    <link rel="stylesheet" href="${ctx}/assets/css/cart3.css?v=22">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">

</head>
<body>

    <jsp:include page="../partials/navbar.jsp" />

    <section class="cart-page">

        <!-- ===== LEFT ===== -->
        <div class="cart-left">

            <h1>Your Bag ( <%= itemCount %> )</h1>

            <% if (cart == null || cart.isEmpty()) { %>

                <div class="empty-cart">
                    <p class="sad-text">Not even one thing?<br>That's sad.</p>
                    <a href="${ctx}/products" class="go-shopping-link">Go shopping →</a>
                </div>

            <% } else { %>
                <div class="cart-items-list">
                <% for (CartItem item : cart) { %>

                    <div class="cart-item">

                        <img src="${ctx}/assets/images/<%= item.getImage() %>"
                             onerror="this.src='${ctx}/assets/images/fallback.jpg'"
                             alt="<%= item.getProductName() %>">

                        <div class="item-info">
                            <div class="item-header-row">
                                <h3><%= item.getProductName() %></h3>
                                <a href="${ctx}/remove-from-cart?id=<%= item.getProductId() %>&size=<%= item.getSize() %>"
                                   class="remove-item-btn" title="Remove">
                                    ✕
                                </a>
                            </div>

                            <p class="item-meta">Size: <%= item.getSize() %></p>

                            <div class="item-bottom-row">
                                <div class="qty-controls">
                                    <button onclick="updateQty(this, <%= item.getProductId() %>, '<%= item.getSize() %>', -1)"
                                        <%= item.getQuantity() == 1 ? "disabled" : "" %>>−</button>
                                    <span class="qty"><%= item.getQuantity() %></span>
                                    <button onclick="updateQty(this, <%= item.getProductId() %>, '<%= item.getSize() %>', 1)">+</button>
                                </div>
                                <span class="item-price" data-price="<%= item.getPrice() %>">
                                    ₹<%= item.getPrice() * item.getQuantity() %>
                                </span>
                            </div>
                        </div>

                    </div>

                <% } %>
                </div>
            <% } %>

        </div>


        <!-- ===== RIGHT SUMMARY ===== -->
        <div class="cart-summary">

            <h2>Summary</h2>

            <div class="summary-row">
                <span>Subtotal ( <%= itemCount %> <%= itemCount == 1 ? "item" : "items" %> )</span>
                <span class="subtotal">₹<%= total %></span>
            </div>

            <div class="summary-row">
                <span>Shipping</span>
                <span>
                    <% if (total >= 999) { %>
                        <span class="free-badge">FREE</span>
                    <% } else { %>
                        ₹99
                    <% } %>
                </span>
            </div>

            <div class="summary-divider"></div>

            <div class="summary-total">
                <span>Total</span>
                <span class="total">₹<%= total >= 999 ? total : total + 99 %></span>
            </div>

            <div class="coupon-box">
                <input type="text" placeholder="Promo code">
                <button>Apply</button>
            </div>

            <a href="${ctx}/checkout" class="checkout-btn">Checkout →</a>

            <p class="secure-note">
                🔒 Secure checkout
            </p>

        </div>

    </section>


    <script>
    const ctxPath = "<%= ctxPath %>";

    function updateQty(btn, id, size, change) {
        fetch(ctxPath + "/update-cart?id=" + id + "&size=" + size + "&change=" + change)
        .then(res => res.json())
        .then(data => {
            const controls  = btn.parentElement;
            const qtySpan   = controls.querySelector(".qty");
            const minusBtn  = controls.querySelector("button:first-child");

            qtySpan.innerText    = data.quantity;
            minusBtn.disabled    = data.quantity <= 1;

            const itemDiv  = btn.closest(".cart-item");
            const priceTag = itemDiv.querySelector(".item-price");
            const basePrice = parseInt(priceTag.dataset.price);
            priceTag.innerText = "₹" + (basePrice * data.quantity);

            updateSummary();
        })
        .catch(err => console.error("Cart update error:", err));
    }

    function updateSummary() {
        let subtotal = 0;
        document.querySelectorAll(".item-price").forEach(el => {
            subtotal += parseInt(el.innerText.replace("₹", "").trim());
        });

        document.querySelector(".subtotal").innerText = "₹" + subtotal;

        const freeShipping = subtotal >= 999;
        document.querySelector(".total").innerText = "₹" + (freeShipping ? subtotal : subtotal + 99);

        // Update shipping badge
        const shippingEl = document.querySelector(".summary-row:nth-child(3) span:last-child");
        if (shippingEl) {
            shippingEl.innerHTML = freeShipping
                ? '<span class="free-badge">FREE</span>'
                : '₹99';
        }
    }

    window.addEventListener('scroll', function () {
        const nav = document.querySelector('.navbar');
        if (nav) nav.classList.toggle('scrolled', window.scrollY > 80);
    });
    </script>

</body>
</html>
