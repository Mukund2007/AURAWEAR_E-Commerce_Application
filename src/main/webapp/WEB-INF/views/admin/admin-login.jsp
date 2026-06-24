<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html class="theme-noir">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AuraWear Admin Portal</title>
    
    <!-- Google Analytics GA4 -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=G-EG16LNFXMK"></script>
    <script>
        window.dataLayer = window.dataLayer || [];
        function gtag(){dataLayer.push(arguments);}
        gtag('js', new Date());
        gtag('config', 'G-EG16LNFXMK');
    </script>

    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/assets/css/admin-responsive.css">

    <style>
        :root {
            --bg-color: #0d0d0d;
            --text-color: #ede4dd;
            --border-color: rgba(237, 228, 221, 0.15);
            --border-color-solid: #ede4dd;
            --accent-color: #ff0001;
            --input-bg: #1a1a1a;
        }
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: 'Outfit', sans-serif;
            background-color: var(--bg-color);
            color: var(--text-color);
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            padding: 20px;
        }
        .login-card {
            background-color: #121212;
            border: 1.5px solid var(--border-color);
            width: 100%;
            max-width: 400px;
            padding: 40px;
            position: relative;
        }
        .login-card::before {
            content: "";
            position: absolute;
            top: -1.5px;
            left: -1.5px;
            width: 80px;
            height: 1.5px;
            background-color: var(--accent-color);
        }
        .brand-logo {
            font-size: 28px;
            font-weight: 900;
            letter-spacing: 4px;
            text-transform: uppercase;
            margin-bottom: 8px;
            text-align: center;
        }
        .brand-logo span {
            color: var(--accent-color);
        }
        .subtitle {
            font-size: 11px;
            color: #888888;
            letter-spacing: 3px;
            text-transform: uppercase;
            text-align: center;
            margin-bottom: 40px;
        }
        .form-group {
            margin-bottom: 24px;
        }
        .form-group label {
            display: block;
            font-size: 11px;
            font-weight: 700;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            color: #aaaaaa;
            margin-bottom: 8px;
        }
        .form-group input {
            width: 100%;
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
        .btn-submit {
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
            margin-top: 10px;
        }
        .btn-submit:hover {
            opacity: 0.9;
        }
        .error-message {
            background-color: rgba(255, 0, 1, 0.1);
            border-left: 3px solid var(--accent-color);
            padding: 12px;
            font-size: 13px;
            color: #ff4d4d;
            margin-bottom: 24px;
        }
        .back-to-store {
            display: block;
            text-align: center;
            margin-top: 30px;
            font-size: 11px;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            color: #888888;
            text-decoration: none;
            transition: color 0.3s;
        }
        .back-to-store:hover {
            color: var(--text-color);
        }
    </style>
</head>
<body>

<div class="login-card">
    <div class="brand-logo">AW <span>ADMIN</span></div>
    <div class="subtitle">AURAWEAR REALM CONTROLLER</div>

    <c:if test="${not empty error}">
        <div class="error-message">
            <i class="fa-solid fa-triangle-exclamation"></i> <c:out value="${error}" />
        </div>
    </c:if>

    <form action="${ctx}/admin/login" method="post">
        <input type="hidden" name="_csrf" value="${_csrf}" />
        <div class="form-group">
            <label>System Email</label>
            <input type="email" name="email" required autocomplete="email" placeholder="name@aurawear.com">
        </div>
        
        <div class="form-group">
            <label>Security Password</label>
            <input type="password" name="password" required autocomplete="current-password" placeholder="••••••••">
        </div>

        <button type="submit" class="btn-submit">Authenticate</button>
    </form>

    <a href="${ctx}/home" class="back-to-store">&larr; Return to Storefront</a>
</div>

</body>
</html>
