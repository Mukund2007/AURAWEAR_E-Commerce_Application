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

            <!-- ===== LEFT: BILLING & PAYMENT GATEWAY TRIGGER ===== -->
            <div class="checkout-left">
                <h1 class="checkout-title">Checkout</h1>

                <c:if test="${not empty errorMsg}">
                    <div class="error-banner" style="background: rgba(255, 0, 1, 0.1); border: 1.5px solid var(--accent-color); color: var(--text-color); padding: 16px; font-weight: 800; text-transform: uppercase; font-size: 12px; margin-bottom: 24px; letter-spacing: 0.5px;">
                        <i class="fa-solid fa-triangle-exclamation"></i> ${errorMsg}
                    </div>
                </c:if>

                <div class="checkout-section">
                    <h3 class="section-title">
                        <i class="fa-solid fa-credit-card"></i> Payment Method
                    </h3>
                    
                    <p style="font-size: 13px; opacity: 0.7; margin-bottom: 20px; line-height: 1.5; text-transform: uppercase; font-weight: 700; letter-spacing: 0.5px;">
                        Select how you would like to complete your premium acquisition.
                    </p>

                    <!-- PAYMENT METHOD SELECTOR -->
                    <div class="payment-options">
                        <label class="payment-option selected" id="opt-online" style="flex: 1;">
                            <input type="radio" name="payment_method" value="online" checked style="display:none;">
                            <i class="fa-solid fa-credit-card"></i> Online Payment
                        </label>
                        <label class="payment-option" id="opt-cod" style="flex: 1;">
                            <input type="radio" name="payment_method" value="cod" style="display:none;">
                            <i class="fa-solid fa-hand-holding-dollar"></i> Cash on Delivery
                        </label>
                    </div>

                    <!-- PREFILLED BILLING SUMMARY -->
                    <div style="background: var(--card-bg); border: 1.5px solid var(--border-color-solid); padding: 20px; margin-bottom: 30px; display: flex; flex-direction: column; gap: 12px;">
                        <h4 style="font-size: 12px; font-weight: 900; letter-spacing: 1px; text-transform: uppercase; border-bottom: 1px solid var(--border-color); padding-bottom: 8px;">Customer Information</h4>
                        <div style="display: flex; justify-content: space-between; font-size: 13px; font-weight: 700; text-transform: uppercase;">
                            <span style="opacity: 0.5;">Name</span>
                            <span>${user.name}</span>
                        </div>
                        <div style="display: flex; justify-content: space-between; font-size: 13px; font-weight: 700;">
                            <span style="opacity: 0.5; text-transform: uppercase;">Email</span>
                            <span>${user.email}</span>
                        </div>
                    </div>

                    <!-- ONLINE PAYMENT FLOW -->
                    <div id="onlinePaymentFlow">
                        <!-- PAYMENT BUTTON -->
                        <c:choose>
                            <c:when test="${not empty razorpayOrderId}">
                                <button type="button" id="payNowBtn" class="place-order-btn" style="width: 100%; border-radius: 0px !important;">
                                    <i class="fa-solid fa-lock"></i> Pay Now — ₹<fmt:formatNumber value="${grandTotal}" maxFractionDigits="0"/>
                                </button>
                            </c:when>
                            <c:otherwise>
                                <button type="button" class="place-order-btn" style="width: 100%; border-radius: 0px !important; opacity: 0.5; cursor: not-allowed;" disabled>
                                    Online Checkout Unavailable
                                </button>
                            </c:otherwise>
                        </c:choose>
                        
                        <p class="secure-label" style="margin-top: 16px; text-align: center; text-transform: uppercase; font-size: 11px; font-weight: 800; letter-spacing: 1px;">
                            <i class="fa fa-lock"></i> Secure 256-bit encrypted SSL checkout
                        </p>
                    </div>

                    <!-- COD PAYMENT FLOW -->
                    <div id="codPaymentFlow" style="display: none;">
                        <form action="${ctx}/checkout/cod" method="POST">
                            <button type="submit" class="place-order-btn" style="width: 100%; border-radius: 0px !important;">
                                <i class="fa-solid fa-truck"></i> Place Order (COD) — ₹<fmt:formatNumber value="${grandTotal}" maxFractionDigits="0"/>
                            </button>
                        </form>
                        
                        <p class="secure-label" style="margin-top: 16px; text-align: center; text-transform: uppercase; font-size: 11px; font-weight: 800; letter-spacing: 1px;">
                            <i class="fa-solid fa-truck-ramp-box"></i> Pay in cash upon product delivery
                        </p>
                    </div>

                </div>
            </div>

            <!-- ===== RIGHT: ORDER SUMMARY ===== -->
            <div class="checkout-summary">
                <h3 class="summary-heading">Order Summary</h3>

                <div class="summary-items">
                    <c:forEach var="item" items="${cartItems}">
                        <div class="summary-item">
                            <img src="<c:choose><c:when test="${fn:startsWith(item.image, 'http')}">${item.image}</c:when><c:otherwise>${ctx}/assets/images/${item.image}</c:otherwise></c:choose>"
                                 onerror="this.src='${ctx}/assets/images/fallback.jpg'"
                                 alt="${item.productName}">
                            <div class="summary-item-info">
                                <p class="summary-item-name">${item.productName}</p>
                                <p class="summary-item-meta">Size: ${item.size} · Qty: ${item.quantity}</p>
                            </div>
                            <p class="summary-item-price">₹<fmt:formatNumber value="${item.price * item.quantity}" maxFractionDigits="0"/></p>
                        </div>
                    </c:forEach>
                </div>

                <div class="summary-divider"></div>

                <div class="summary-row">
                    <span>Subtotal</span>
                    <span>₹<fmt:formatNumber value="${subtotal}" maxFractionDigits="0"/></span>
                </div>

                <div class="summary-row">
                    <span>Shipping</span>
                    <span>
                        <c:choose>
                            <c:when test="${shipping == 0}">
                                <span class="free-badge" style="background: var(--accent-color); color: var(--bg-color); font-size: 9px; font-weight: 800; padding: 2px 6px;">FREE</span>
                            </c:when>
                            <c:otherwise>
                                ₹<fmt:formatNumber value="${shipping}" maxFractionDigits="0"/>
                            </c:otherwise>
                        </c:choose>
                    </span>
                </div>

                <div class="summary-divider"></div>

                <div class="summary-total-row">
                    <span>Total</span>
                    <span>₹<fmt:formatNumber value="${grandTotal}" maxFractionDigits="0"/></span>
                </div>
            </div>

        </div>

    </div>

    <!-- RAZORPAY SCRIPT -->
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
    <script>
    // Navbar scroll effect
    window.addEventListener("scroll", function () {
        const nav = document.querySelector(".navbar");
        if (nav) nav.classList.toggle("scrolled", window.scrollY > 80);
    });

    // Toggle payment method flow
    const optOnline = document.getElementById("opt-online");
    const optCod = document.getElementById("opt-cod");
    const onlinePaymentFlow = document.getElementById("onlinePaymentFlow");
    const codPaymentFlow = document.getElementById("codPaymentFlow");

    if (optOnline && optCod) {
        const radios = document.getElementsByName("payment_method");
        
        function updatePaymentFlow() {
            let selectedMethod = "online";
            for (const radio of radios) {
                if (radio.checked) {
                    selectedMethod = radio.value;
                    break;
                }
            }
            
            if (selectedMethod === "online") {
                optOnline.classList.add("selected");
                optCod.classList.remove("selected");
                onlinePaymentFlow.style.display = "block";
                codPaymentFlow.style.display = "none";
            } else {
                optOnline.classList.remove("selected");
                optCod.classList.add("selected");
                onlinePaymentFlow.style.display = "none";
                codPaymentFlow.style.display = "block";
            }
        }

        optOnline.onclick = function() {
            optOnline.querySelector('input[type="radio"]').checked = true;
            updatePaymentFlow();
        };

        optCod.onclick = function() {
            optCod.querySelector('input[type="radio"]').checked = true;
            updatePaymentFlow();
        };
    }

    // Razorpay Integration
    <c:if test="${not empty razorpayOrderId}">
    const payNowBtn = document.getElementById("payNowBtn");
    
    const options = {
        "key": "${razorpayKeyId}",
        "amount": "${amountInPaise}",
        "currency": "INR",
        "name": "AuraWear",
        "description": "Premium Streetwear Checkout",
        "order_id": "${razorpayOrderId}",
        "handler": function (response) {
            // Create a form programmatically and submit payment credentials
            const form = document.createElement("form");
            form.method = "POST";
            form.action = "${ctx}/payment-success";

            const pId = document.createElement("input");
            pId.type = "hidden";
            pId.name = "razorpay_payment_id";
            pId.value = response.razorpay_payment_id;
            form.appendChild(pId);

            const oId = document.createElement("input");
            oId.type = "hidden";
            oId.name = "razorpay_order_id";
            oId.value = response.razorpay_order_id;
            form.appendChild(oId);

            const sig = document.createElement("input");
            sig.type = "hidden";
            sig.name = "razorpay_signature";
            sig.value = response.razorpay_signature;
            form.appendChild(sig);

            document.body.appendChild(form);
            form.submit();
        },
        "prefill": {
            "name": "${user.name}",
            "email": "${user.email}"
        },
        "theme": {
            "color": "#ff0001" // matching AuraWear red theme variable
        }
    };

    const rzp = new Razorpay(options);
    
    payNowBtn.onclick = function(e) {
        rzp.open();
        e.preventDefault();
    };
    </c:if>
    </script>

</body>
</html>
