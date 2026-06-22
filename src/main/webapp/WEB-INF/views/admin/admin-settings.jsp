<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html class="theme-noir">
<head>
    <meta charset="UTF-8">
    <title>AuraWear Admin - Settings</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --bg-color: #0d0d0d;
            --text-color: #ede4dd;
            --border-color: rgba(237, 228, 221, 0.15);
            --border-color-solid: #ede4dd;
            --accent-color: #ff0001;
            --card-bg: #121212;
            --input-bg: #1a1a1a;
        }
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: 'Outfit', sans-serif;
            background-color: var(--bg-color);
            color: var(--text-color);
            min-height: 100vh;
        }
        /* Navigation */
        .admin-nav {
            border-bottom: 1.5px solid var(--border-color);
            padding: 20px 40px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            background-color: #090909;
        }
        .nav-brand {
            font-size: 20px;
            font-weight: 900;
            letter-spacing: 3px;
            text-transform: uppercase;
        }
        .nav-brand span {
            color: var(--accent-color);
        }
        .nav-links {
            display: flex;
            gap: 30px;
            list-style: none;
            align-items: center;
        }
        .nav-links a {
            color: var(--text-color);
            text-decoration: none;
            font-size: 12px;
            font-weight: 700;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            opacity: 0.7;
            transition: opacity 0.3s, color 0.3s;
        }
        .nav-links a:hover, .nav-links .active a {
            opacity: 1;
            color: var(--accent-color);
        }
        .btn-logout {
            border: 1px solid var(--border-color);
            padding: 8px 16px;
            transition: border-color 0.3s;
        }
        .btn-logout:hover {
            border-color: var(--accent-color);
        }
        /* Content Layout */
        .admin-container {
            max-width: 600px;
            margin: 0 auto;
            padding: 60px 20px;
        }
        .page-header {
            margin-bottom: 40px;
        }
        .page-title {
            font-size: 32px;
            font-weight: 900;
            letter-spacing: -1.5px;
            text-transform: uppercase;
        }
        .page-subtitle {
            font-size: 12px;
            color: #888888;
            letter-spacing: 2px;
            text-transform: uppercase;
            margin-top: 4px;
        }
        /* Form panels */
        .settings-card {
            background-color: var(--card-bg);
            border: 1px solid var(--border-color);
            padding: 40px;
            position: relative;
        }
        .settings-card::before {
            content: "";
            position: absolute;
            top: -1px;
            left: -1px;
            width: 60px;
            height: 2px;
            background-color: var(--accent-color);
        }
        .form-group {
            margin-bottom: 24px;
            display: flex;
            flex-direction: column;
        }
        .form-group label {
            font-size: 11px;
            font-weight: 700;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            color: #aaaaaa;
            margin-bottom: 8px;
        }
        .form-group input {
            background-color: var(--input-bg);
            border: 1px solid var(--border-color);
            padding: 14px 16px;
            color: var(--text-color);
            font-family: 'Outfit', sans-serif;
            font-size: 14px;
            outline: none;
            transition: border-color 0.3s;
        }
        .form-group input:focus {
            border-color: var(--border-color-solid);
        }
        /* Buttons */
        .btn-save {
            width: 100%;
            background-color: var(--accent-color);
            color: #ffffff;
            border: none;
            padding: 16px;
            font-family: 'Outfit', sans-serif;
            font-size: 12px;
            font-weight: 900;
            letter-spacing: 2.5px;
            text-transform: uppercase;
            cursor: pointer;
            transition: opacity 0.3s;
        }
        .btn-save:hover {
            opacity: 0.9;
        }
        .alert-success {
            background-color: rgba(0, 255, 0, 0.08);
            border-left: 3px solid #4cd137;
            padding: 14px 20px;
            font-size: 14px;
            color: #4cd137;
            margin-bottom: 24px;
        }
        .alert-error {
            background-color: rgba(255, 0, 0, 0.08);
            border-left: 3px solid #e84118;
            padding: 14px 20px;
            font-size: 14px;
            color: #e84118;
            margin-bottom: 24px;
        }
    </style>
</head>
<body>

<!-- Navigation Header -->
<nav class="admin-nav">
    <div class="nav-brand">AW <span>ADMIN</span></div>
    <ul class="nav-links">
        <li><a href="${ctx}/admin/dashboard">Dashboard</a></li>
        <li><a href="${ctx}/admin/orders">Orders</a></li>
        <li><a href="${ctx}/admin/products">Products</a></li>
        <li class="active"><a href="${ctx}/admin/settings">Settings</a></li>
        <li><a href="${ctx}/home" target="_blank">View Store</a></li>
        <li><a href="${ctx}/logout" class="btn-logout">Logout</a></li>
    </ul>
</nav>

<div class="admin-container">
    <div class="page-header">
        <h1 class="page-title">Store Settings</h1>
        <div class="page-subtitle">Configure shipping charges and promotional thresholds</div>
    </div>

    <c:if test="${not empty param.success}">
        <div class="alert-success">
            <i class="fa-solid fa-circle-check"></i> Shipping configuration saved successfully!
        </div>
    </c:if>
    <c:if test="${not empty param.error}">
        <div class="alert-error">
            <i class="fa-solid fa-triangle-exclamation"></i> Error updating settings. Please try again.
        </div>
    </c:if>

    <div class="settings-card">
        <form action="${ctx}/admin/settings" method="post">
            <input type="hidden" name="_csrf" value="${_csrf}" />
            <div class="form-group">
                <label>Shipping Charge (₹)</label>
                <input type="number" name="shippingCharge" value="${shippingCharge}" required min="0" placeholder="99">
            </div>
            
            <div class="form-group">
                <label>Free Shipping Threshold (₹)</label>
                <input type="number" name="freeShippingThreshold" value="${freeShippingThreshold}" required min="0" placeholder="999">
            </div>

            <button type="submit" class="btn-save">Save Configuration</button>
        </form>
    </div>
</div>

</body>
</html>
