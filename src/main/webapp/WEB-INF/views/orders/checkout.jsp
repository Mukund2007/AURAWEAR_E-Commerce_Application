<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ page import="java.util.*, com.aurawear.model.CartItem" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
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
    int shipping   = total >= 999 ? 0 : 99;
    int grandTotal = total + shipping;
%>

<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout — AuraWear</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/assets/css/home.css">
    <link rel="stylesheet" href="${ctx}/assets/css/orders.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">

</head>
<body>

    <jsp:include page="../partials/navbar.jsp" />

    <div class="checkout-wrap">

        <div class="checkout-grid">

            <!-- ===== LEFT: FORM ===== -->
            <div class="checkout-left">

                <h1 class="checkout-title">Checkout</h1>

                <form action="${ctx}/checkout" method="post" id="checkoutForm">

                    <!-- DELIVERY -->
                    <div class="checkout-section">
                        <h3 class="section-title">
                            <i class="fa-solid fa-location-dot"></i> Delivery Address
                        </h3>

                        <div class="form-row two-col">
                            <div class="form-group">
                                <label>First Name</label>
                                <input type="text" name="firstName" placeholder="John" required>
                            </div>
                            <div class="form-group">
                                <label>Last Name</label>
                                <input type="text" name="lastName" placeholder="Doe" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label>Email</label>
                            <input type="email" name="email" placeholder="john@example.com" required>
                        </div>

                        <div class="form-group">
                            <label>Phone</label>
                            <input type="tel" name="phone" placeholder="+91 98765 43210" required>
                        </div>

                        <div class="form-group">
                            <label>Street Address</label>
                            <input type="text" name="address" placeholder="123 Main Street, Apt 4B" required>
                        </div>

                        <div class="form-row two-col">
                            <div class="form-group">
                                <label>City</label>
                                <input type="text" name="city" placeholder="Mumbai" required>
                            </div>
                            <div class="form-group">
                                <label>PIN Code</label>
                                <input type="text" name="pincode" placeholder="400001" required>
                            </div>
                        </div>
                    </div>

                    <!-- PAYMENT -->
                    <div class="checkout-section">
                        <h3 class="section-title">
                            <i class="fa-solid fa-credit-card"></i> Payment
                        </h3>

                        <div class="payment-options">
                            <label class="payment-option selected">
                                <input type="radio" name="payment" value="card" checked>
                                <i class="fa-solid fa-credit-card"></i>
                                <span>Credit / Debit Card</span>
                            </label>
                            <label class="payment-option">
                                <input type="radio" name="payment" value="upi">
                                <i class="fa-solid fa-mobile-screen"></i>
                                <span>UPI</span>
                            </label>
                            <label class="payment-option">
                                <input type="radio" name="payment" value="cod">
                                <i class="fa-solid fa-truck"></i>
                                <span>Cash on Delivery</span>
                            </label>
                        </div>

                        <div id="cardFields">
                            <div class="form-group">
                                <label>Card Number</label>
                                <input type="text" name="cardNumber" placeholder="1234 5678 9012 3456"
                                       maxlength="19" oninput="formatCard(this)">
                            </div>
                            <div class="form-row two-col">
                                <div class="form-group">
                                    <label>Expiry Date</label>
                                    <input type="text" name="expiry" placeholder="MM / YY" maxlength="7">
                                </div>
                                <div class="form-group">
                                    <label>CVV</label>
                                    <input type="password" name="cvv" placeholder="•••" maxlength="4">
                                </div>
                            </div>
                        </div>
                    </div>

                    <button type="submit" class="place-order-btn">
                        Place Order — ₹<%= grandTotal %>
                    </button>

                    <p class="secure-label">
                        <i class="fa fa-lock"></i> Secure & encrypted checkout
                    </p>

                </form>

            </div>


            <!-- ===== RIGHT: ORDER SUMMARY ===== -->
            <div class="checkout-summary">

                <h3 class="summary-heading">Order Summary</h3>

                <div class="summary-items">
                    <% if (cart != null) {
                        for (CartItem item : cart) { %>
                        <div class="summary-item">
                            <img src="${ctx}/assets/images/<%= item.getImage() %>"
                                 onerror="this.src='${ctx}/assets/images/fallback.jpg'"
                                 alt="<%= item.getProductName() %>">
                            <div class="summary-item-info">
                                <p class="summary-item-name"><%= item.getProductName() %></p>
                                <p class="summary-item-meta">Size: <%= item.getSize() %> · Qty: <%= item.getQuantity() %></p>
                            </div>
                            <p class="summary-item-price">₹<%= item.getPrice() * item.getQuantity() %></p>
                        </div>
                    <% } } %>
                </div>

                <div class="summary-divider"></div>

                <div class="summary-row">
                    <span>Subtotal (<%= itemCount %> items)</span>
                    <span>₹<%= total %></span>
                </div>

                <div class="summary-row">
                    <span>Shipping</span>
                    <span>
                        <% if (shipping == 0) { %>
                            <span class="free-badge">FREE</span>
                        <% } else { %>
                            ₹<%= shipping %>
                        <% } %>
                    </span>
                </div>

                <div class="summary-divider"></div>

                <div class="summary-total-row">
                    <span>Total</span>
                    <span>₹<%= grandTotal %></span>
                </div>

            </div>

        </div>

    </div>


    <script>
    // Payment option toggle
    document.querySelectorAll(".payment-option").forEach(option => {
        option.addEventListener("click", function () {
            document.querySelectorAll(".payment-option").forEach(o => o.classList.remove("selected"));
            this.classList.add("selected");

            const val = this.querySelector("input").value;
            document.getElementById("cardFields").style.display =
                val === "card" ? "block" : "none";
        });
    });

    // Card number formatter
    function formatCard(input) {
        let val = input.value.replace(/\D/g, "").substring(0, 16);
        input.value = val.replace(/(.{4})/g, "$1 ").trim();
    }

    // Navbar scroll
    window.addEventListener("scroll", function () {
        const nav = document.querySelector(".navbar");
        if (nav) nav.classList.toggle("scrolled", window.scrollY > 80);
    });
    </script>

</body>
</html>
