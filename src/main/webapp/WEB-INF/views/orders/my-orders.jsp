<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders — AuraWear</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/assets/css/home.css">
    <link rel="stylesheet" href="${ctx}/assets/css/orders.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
</head>
<body>

    <jsp:include page="../partials/navbar.jsp" />

    <div class="orders-page">
        <!-- AMBIENT HEADER GLOW -->
        <div class="orders-header-glow"></div>

        <!-- PAGE HEADER -->
        <div class="orders-header">
            <div class="orders-header-inner">
                <div class="orders-header-text">
                    <h1>My Orders</h1>
                    <p>
                        <c:choose>
                            <c:when test="${not empty orders}">
                                ${orders.size()} premium garment<c:if test="${orders.size() != 1}">s</c:if> curated
                            </c:when>
                            <c:otherwise>Track and manage your high-end acquisitions</c:otherwise>
                        </c:choose>
                    </p>
                </div>
                <a href="${ctx}/products" class="orders-shop-btn">
                    <i class="fa-solid fa-arrow-left"></i> Continue Curation
                </a>
            </div>
        </div>

        <!-- MAIN CONTENT -->
        <div class="orders-container">

            <c:choose>
                <c:when test="${empty orders}">
                    <div class="orders-empty">
                        <div class="orders-empty-icon">
                            <i class="fa-solid fa-bag-shopping"></i>
                        </div>
                        <h3>No curated orders</h3>
                        <p>Your luxury collection is waiting.<br>Explore outstanding style narratives.</p>
                        <a href="${ctx}/products" class="orders-browse-btn">Explore Collection</a>
                    </div>
                </c:when>

                <c:otherwise>
                    <!-- DYNAMIC JSTL STATS CALCULATOR -->
                    <c:set var="placedCount" value="0" />
                    <c:set var="shippedCount" value="0" />
                    <c:set var="deliveredCount" value="0" />
                    <c:set var="cancelledCount" value="0" />
                    <c:forEach var="item" items="${orders}">
                        <c:set var="s" value="${item[2]}" />
                        <c:choose>
                            <c:when test="${s == 'Placed' || s == 'COD_PENDING' || s == 'COD_CONFIRMED'}"><c:set var="placedCount" value="${placedCount + 1}" /></c:when>
                            <c:when test="${s == 'Shipped'}"><c:set var="shippedCount" value="${shippedCount + 1}" /></c:when>
                            <c:when test="${s == 'Delivered'}"><c:set var="deliveredCount" value="${deliveredCount + 1}" /></c:when>
                            <c:when test="${s == 'Cancelled'}"><c:set var="cancelledCount" value="${cancelledCount + 1}" /></c:when>
                        </c:choose>
                    </c:forEach>

                    <!-- STATS DASHBOARD -->
                    <div class="orders-stats-dashboard">
                        <div class="stat-widget">
                            <div class="stat-widget-icon"><i class="fa-solid fa-receipt"></i></div>
                            <div class="stat-widget-info">
                                <span class="stat-label">Total Curated</span>
                                <span class="stat-value">${orders.size()}</span>
                            </div>
                        </div>
                        <div class="stat-widget">
                            <div class="stat-widget-icon active-glow"><i class="fa-solid fa-truck-fast"></i></div>
                            <div class="stat-widget-info">
                                <span class="stat-label">Active Transit</span>
                                <span class="stat-value">${shippedCount + placedCount}</span>
                            </div>
                        </div>
                        <div class="stat-widget">
                            <div class="stat-widget-icon success-glow"><i class="fa-solid fa-box-open"></i></div>
                            <div class="stat-widget-info">
                                <span class="stat-label">Delivered</span>
                                <span class="stat-value">${deliveredCount}</span>
                            </div>
                        </div>
                    </div>

                    <div class="orders-list">
                        <c:forEach var="order" items="${orders}" varStatus="loop">
                            <c:set var="status" value="${order[2]}" />

                            <div class="order-card status-${status.toLowerCase()} cursor-pointer"
                                 onclick="window.location.href='${ctx}/product?id=${order[5]}'"
                                 >

                                <!-- STATUS STRIP ACCENT (via class) -->
                                <div class="order-status-strip"></div>

                                <!-- LEFT: product info -->
                                <div class="order-card-left">

                                    <div class="order-icon-wrap">
                                        <c:choose>
                                            <c:when test="${status == 'Placed'}"><i class="fa-solid fa-wallet"></i></c:when>
                                            <c:when test="${status == 'Shipped'}"><i class="fa-solid fa-truck-fast"></i></c:when>
                                            <c:when test="${status == 'Delivered'}"><i class="fa-solid fa-box-open"></i></c:when>
                                            <c:otherwise><i class="fa-solid fa-receipt"></i></c:otherwise>
                                        </c:choose>
                                    </div>

                                    <div class="order-info">
                                        <div class="order-product-name">${order[3]}</div>
                                        <div class="order-meta-row">
                                            <span class="order-id-label">Order #${order[0]}</span>
                                            <c:if test="${not empty order[4]}">
                                                <span class="order-id-divider">·</span>
                                                <span class="order-id-label">${order[4]}</span>
                                            </c:if>
                                            <c:if test="${not empty order[6]}">
                                                <span class="order-id-divider">·</span>
                                                <span class="order-id-label">Size: ${order[6]}</span>
                                            </c:if>
                                            <c:if test="${not empty order[7]}">
                                                <span class="order-id-divider">·</span>
                                                <span class="order-id-label">Qty: ${order[7]}</span>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>

                                <!-- RIGHT: price + status -->
                                <div class="order-card-right">

                                    <div class="order-price">
                                        ₹<fmt:formatNumber value="${order[1]}" maxFractionDigits="0"/>
                                    </div>

                                    <c:choose>
                                        <c:when test="${status == 'Placed'}">
                                            <span class="order-badge badge-placed">
                                                <span class="pulse-indicator"></span> Placed
                                            </span>
                                        </c:when>
                                        <c:when test="${status == 'COD_PENDING'}">
                                            <span class="order-badge badge-placed">
                                                <span class="pulse-indicator"></span> COD Pending
                                            </span>
                                        </c:when>
                                        <c:when test="${status == 'COD_CONFIRMED'}">
                                            <span class="order-badge badge-placed">
                                                <span class="pulse-indicator"></span> COD Confirmed
                                            </span>
                                        </c:when>
                                        <c:when test="${status == 'Shipped'}">
                                            <span class="order-badge badge-shipped">
                                                <span class="pulse-indicator"></span> Shipped
                                            </span>
                                        </c:when>
                                        <c:when test="${status == 'Delivered'}">
                                            <span class="order-badge badge-delivered">
                                                <i class="fa-solid fa-circle-check"></i> Delivered
                                            </span>
                                        </c:when>
                                        <c:when test="${status == 'Cancelled'}">
                                            <span class="order-badge badge-cancelled">
                                                Cancelled
                                            </span>
                                        </c:when>
                                        <c:when test="${status == 'Returned'}">
                                            <span class="order-badge badge-cancelled">
                                                Returned
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="order-badge badge-placed">${status}</span>
                                        </c:otherwise>
                                    </c:choose>

                                    <!-- INTERACTIVE TRACK BUTTON -->
                                    <button class="order-track-btn" onclick="event.stopPropagation(); openTracker('${order[0]}', '${order[3].replace("'", "\\'")}', '${status}', '${order[4]}')">
                                        <i class="fa-solid fa-location-crosshairs"></i> Track Order
                                    </button>

                                    <!-- CANCEL / RETURN ACTIONS -->
                                    <c:choose>
                                        <c:when test="${status == 'Placed' || status == 'COD_PENDING' || status == 'COD_CONFIRMED'}">
                                            <button class="order-action-btn cancel-btn" onclick="event.stopPropagation(); performOrderAction('${order[0]}', 'cancel')">
                                                <i class="fa-solid fa-ban"></i> Cancel Order
                                            </button>
                                        </c:when>
                                        <c:when test="${status == 'Delivered'}">
                                            <button class="order-action-btn return-btn" onclick="event.stopPropagation(); performOrderAction('${order[0]}', 'return')">
                                                <i class="fa-solid fa-arrow-rotate-left"></i> Return Item
                                            </button>
                                        </c:when>
                                    </c:choose>

                                </div>

                                <!-- INTERACTIVE CHEVRON -->
                                <div class="order-card-action">
                                    <i class="fa-solid fa-chevron-right"></i>
                                </div>

                            </div>
                        </c:forEach>
                    </div>

                    <!-- SUMMARY STRIP -->
                    <div class="orders-summary-strip">
                        <span><i class="fa-solid fa-receipt"></i> ${orders.size()} curated item<c:if test="${orders.size() != 1}">s</c:if></span>
                        <a href="${ctx}/products">Explore more <i class="fa-solid fa-arrow-right"></i></a>
                    </div>

                </c:otherwise>
            </c:choose>

        </div>
    </div>

    <!-- PREMIUM GLASSMORPHIC TRACKING MODAL -->
    <div id="trackerModal" class="tracker-overlay" onclick="closeTracker()">
        <div class="tracker-modal" onclick="event.stopPropagation()">
            <button class="tracker-close-btn" onclick="closeTracker()">
                <i class="fa-solid fa-xmark"></i>
            </button>
            
            <div class="tracker-modal-header">
                <h2>Real-Time Tracking</h2>
                <div class="tracker-subtitle">
                    <span id="trackerProductName">Curated Garment</span> · Order #<span id="trackerOrderId">10000</span>
                </div>
            </div>
            
            <div class="tracker-timeline">
                <div class="tracker-progress-line">
                    <div id="trackerProgressFill" class="tracker-progress-fill"></div>
                </div>
                
                <div id="step-placed" class="tracker-step">
                    <div class="step-dot"><i class="fa-solid fa-receipt"></i></div>
                    <div class="step-info">
                        <h3>Order Placed</h3>
                        <p>Atelier received your curation choices.</p>
                    </div>
                </div>
                
                <div id="step-processing" class="tracker-step">
                    <div class="step-dot"><i class="fa-solid fa-shirt"></i></div>
                    <div class="step-info">
                        <h3>In Production</h3>
                        <p>Crafting, detailing, and sizing at our Atelier.</p>
                    </div>
                </div>
                
                <div id="step-shipped" class="tracker-step">
                    <div class="step-dot"><i class="fa-solid fa-truck-fast"></i></div>
                    <div class="step-info">
                        <h3>Shipped</h3>
                        <p>Dispatched via high-end courier service.</p>
                    </div>
                </div>
                
                <div id="step-delivered" class="tracker-step">
                    <div class="step-dot"><i class="fa-solid fa-box-open"></i></div>
                    <div class="step-info">
                        <h3>Delivered</h3>
                        <p>Acquisition successfully reached its destination.</p>
                    </div>
                </div>
            </div>
            
            <div class="tracker-details">
                <div class="tracker-details-header">Curation Milestones</div>
                <div class="tracker-milestone">
                    <span class="milestone-time">14:20 PM</span>
                    <span class="milestone-text">Logistics courier routed to regional sorting hub</span>
                </div>
                <div class="tracker-milestone">
                    <span class="milestone-time">09:15 AM</span>
                    <span class="milestone-text">Atelier quality checks passed & vacuum sealed</span>
                </div>
                <div class="tracker-milestone">
                    <span class="milestone-time">08:00 AM</span>
                    <span class="milestone-text">Bespoke tailoring and alignment finalized</span>
                </div>
            </div>
        </div>
    </div>

    <script>
        window.addEventListener('scroll', function () {
            const nav = document.querySelector('.navbar');
            if (nav) nav.classList.toggle('scrolled', window.scrollY > 80);
        });

        // TRACKER CONTROLLER
        function openTracker(orderId, productName, status, date) {
            document.getElementById('trackerOrderId').innerText = orderId;
            document.getElementById('trackerProductName').innerText = productName;
            
            const steps = ['placed', 'processing', 'shipped', 'delivered'];
            steps.forEach(step => {
                document.getElementById('step-' + step).className = 'tracker-step';
            });
            
            const progressFill = document.getElementById('trackerProgressFill');
            
            if (status === 'Placed' || status === 'COD_PENDING' || status === 'COD_CONFIRMED') {
                document.getElementById('step-placed').className = 'tracker-step active';
                document.getElementById('step-processing').className = 'tracker-step active';
                progressFill.style.height = '33%';
            } else if (status === 'Shipped') {
                document.getElementById('step-placed').className = 'tracker-step completed';
                document.getElementById('step-processing').className = 'tracker-step completed';
                document.getElementById('step-shipped').className = 'tracker-step active';
                progressFill.style.height = '66%';
            } else if (status === 'Delivered') {
                document.getElementById('step-placed').className = 'tracker-step completed';
                document.getElementById('step-processing').className = 'tracker-step completed';
                document.getElementById('step-shipped').className = 'tracker-step completed';
                document.getElementById('step-delivered').className = 'tracker-step completed';
                progressFill.style.height = '100%';
            } else if (status === 'Cancelled') {
                document.getElementById('step-placed').className = 'tracker-step completed';
                document.getElementById('step-processing').className = 'tracker-step cancelled';
                progressFill.style.height = '33%';
            }
            
            document.getElementById('trackerModal').classList.add('open');
            document.body.style.overflow = 'hidden';
        }

        function closeTracker() {
            document.getElementById('trackerModal').classList.remove('open');
            document.body.style.overflow = '';
        }

        // Close on escape key
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') closeTracker();
        });

        // ORDER ACTION CONTROLLER (CANCEL & RETURN)
        function performOrderAction(orderId, action) {
            const displayAction = action === 'cancel' ? 'cancel' : 'return';
            if (confirm("Are you sure you want to " + displayAction + " Order #" + orderId + "?")) {
                fetch('${ctx}/update-order-status', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: 'orderId=' + encodeURIComponent(orderId) + '&action=' + encodeURIComponent(action)
                })
                .then(response => {
                    if (response.ok) {
                        window.location.reload();
                    } else {
                        response.text().then(text => alert('Error: ' + text));
                    }
                })
                .catch(error => {
                    console.error('Error updating order:', error);
                    alert('An error occurred. Please try again.');
                });
            }
        }
    </script>
</body>
</html>
