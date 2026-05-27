<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Placed — AuraWear</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/assets/css/home.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Outfit', 'DM Sans', Arial, sans-serif;
            background: var(--bg-color);
            color: var(--text-color);
            -webkit-font-smoothing: antialiased;
            transition: background-color 0.8s cubic-bezier(0.76, 0, 0.24, 1), color 0.8s cubic-bezier(0.76, 0, 0.24, 1);
        }

        .success-wrap {
            max-width: 500px;
            margin: 100px auto;
            padding: 48px 32px;
            text-align: center;
            background: var(--card-bg);
            border: 1.5px solid var(--border-color-solid);
            border-radius: 0px;
            box-shadow: 8px 8px 0px var(--border-color-solid);
            transition: background 0.8s, border-color 0.8s, box-shadow 0.8s;
        }

        .success-icon {
            width: 80px;
            height: 80px;
            background: var(--accent-color);
            border: 1.5px solid var(--border-color-solid);
            border-radius: 0px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 28px;
            box-shadow: 4px 4px 0px var(--border-color-solid);
            transition: border-color 0.8s, box-shadow 0.8s;
        }

        .success-icon i {
            font-size: 34px;
            color: var(--bg-color);
        }

        .success-wrap h1 {
            font-size: 38px;
            font-weight: 900;
            letter-spacing: -2px;
            margin-bottom: 14px;
            text-transform: uppercase;
            line-height: 0.95;
        }

        .success-wrap p {
            font-size: 13px;
            color: var(--text-color);
            opacity: 0.8;
            font-weight: 700;
            text-transform: uppercase;
            line-height: 1.6;
            margin-bottom: 40px;
            transition: color 0.8s;
        }

        .success-actions {
            display: flex;
            gap: 14px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .btn-dark {
            background: var(--border-color-solid);
            color: var(--bg-color);
            border: 1.5px solid var(--border-color-solid);
            padding: 15px 30px;
            border-radius: 0px;
            font-size: 12px;
            font-weight: 800;
            letter-spacing: 1px;
            transition: all 0.2s ease, background 0.8s, color 0.8s, border-color 0.8s;
            text-decoration: none;
            text-transform: uppercase;
        }

        .btn-dark:hover {
            background: var(--accent-color);
            border-color: var(--accent-color);
            color: var(--bg-color);
        }

        .btn-light {
            border: 1.5px solid var(--border-color-solid);
            background: var(--card-bg);
            color: var(--text-color);
            padding: 15px 30px;
            border-radius: 0px;
            font-size: 12px;
            font-weight: 800;
            letter-spacing: 1px;
            transition: all 0.2s ease, background 0.8s, color 0.8s, border-color 0.8s;
            text-decoration: none;
            text-transform: uppercase;
        }

        .btn-light:hover {
            background: var(--accent-color);
            color: var(--bg-color);
            border-color: var(--accent-color);
        }
    </style>

</head>
<body>

    <jsp:include page="../partials/navbar.jsp" />

    <div class="success-wrap">

        <div class="success-icon">
            <i class="fa-solid fa-check"></i>
        </div>

        <h1>Order Placed! 🎉</h1>
        <p>Thank you for shopping with AuraWear.<br>Your order is confirmed and will be shipped soon.</p>

        <div class="success-actions">
            <a href="${ctx}/my-orders" class="btn-dark">View My Orders</a>
            <a href="${ctx}/products"  class="btn-light">Continue Shopping</a>
        </div>

    </div>

    <script>
        window.addEventListener('scroll', function () {
            const nav = document.querySelector('.navbar');
            if (nav) nav.classList.toggle('scrolled', window.scrollY > 80);
        });
    </script>

</body>
</html>
