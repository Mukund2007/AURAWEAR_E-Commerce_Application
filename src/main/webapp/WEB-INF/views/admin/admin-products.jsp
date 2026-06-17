<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html class="theme-noir">
<head>
    <meta charset="UTF-8">
    <title>AuraWear Admin - Products</title>
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
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 20px;
        }
        .page-header {
            margin-bottom: 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
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
        .collapsible-form-panel {
            background-color: var(--card-bg);
            border: 1px solid var(--border-color);
            padding: 30px;
            margin-bottom: 40px;
            display: none;
        }
        .form-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 15px;
            display: flex;
            flex-direction: column;
        }
        .form-group label {
            font-size: 11px;
            font-weight: 700;
            letter-spacing: 1px;
            text-transform: uppercase;
            color: #aaaaaa;
            margin-bottom: 6px;
        }
        .form-group input, .form-group select {
            background-color: var(--input-bg);
            border: 1px solid var(--border-color);
            padding: 10px 14px;
            color: var(--text-color);
            font-family: 'Outfit', sans-serif;
            font-size: 13px;
            outline: none;
            transition: border-color 0.3s;
        }
        .form-group input:focus, .form-group select:focus {
            border-color: var(--border-color-solid);
        }
        /* Buttons */
        .btn-action {
            background-color: transparent;
            color: var(--text-color);
            border: 1px solid var(--border-color-solid);
            padding: 10px 20px;
            font-family: 'Outfit', sans-serif;
            font-size: 11px;
            font-weight: 700;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            cursor: pointer;
            transition: all 0.3s;
        }
        .btn-action:hover {
            background-color: var(--text-color);
            color: var(--bg-color);
        }
        .btn-accent {
            background-color: var(--accent-color);
            border-color: var(--accent-color);
            color: #ffffff;
        }
        .btn-accent:hover {
            background-color: transparent;
            border-color: var(--accent-color);
            color: var(--accent-color);
        }
        .btn-edit {
            background-color: transparent;
            color: var(--text-color);
            border: 1px solid var(--border-color);
            padding: 6px 12px;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            cursor: pointer;
            transition: border-color 0.3s;
            margin-right: 5px;
        }
        .btn-edit:hover {
            border-color: var(--text-color);
        }
        .btn-delete {
            background-color: transparent;
            color: #ff4d4d;
            border: 1px solid rgba(255, 77, 77, 0.3);
            padding: 6px 12px;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            cursor: pointer;
            transition: all 0.3s;
        }
        .btn-delete:hover {
            border-color: #ff4d4d;
            background-color: rgba(255, 77, 77, 0.1);
        }
        /* Tables */
        .table-container {
            background-color: var(--card-bg);
            border: 1px solid var(--border-color);
            overflow-x: auto;
        }
        .admin-table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }
        .admin-table th, .admin-table td {
            padding: 14px 20px;
            border-bottom: 1px solid var(--border-color);
            font-size: 13px;
            vertical-align: middle;
        }
        .admin-table th {
            background-color: #171717;
            font-size: 11px;
            font-weight: 700;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            color: #aaaaaa;
        }
        .admin-table tbody tr:hover {
            background-color: #161616;
        }
        .product-thumbnail {
            width: 40px;
            height: 48px;
            object-fit: cover;
            border: 1.5px solid var(--border-color);
        }
        /* Modal Window styling */
        .admin-modal {
            display: none;
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background-color: rgba(0, 0, 0, 0.85);
            align-items: center;
            justify-content: center;
            z-index: 1000;
            padding: 20px;
        }
        .modal-content {
            background-color: #121212;
            border: 1.5px solid var(--border-color);
            padding: 40px;
            width: 100%;
            max-width: 800px;
            position: relative;
        }
        .modal-close {
            position: absolute;
            top: 20px; right: 20px;
            color: #888888;
            font-size: 24px;
            cursor: pointer;
            background: none;
            border: none;
        }
        .modal-close:hover {
            color: var(--text-color);
        }
        .alert-success {
            background-color: rgba(0, 255, 0, 0.08);
            border-left: 3px solid #4cd137;
            padding: 14px 20px;
            font-size: 14px;
            color: #4cd137;
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
        <li class="active"><a href="${ctx}/admin/products">Products</a></li>
        <li><a href="${ctx}/admin/settings">Settings</a></li>
        <li><a href="${ctx}/home" target="_blank">View Store</a></li>
        <li><a href="${ctx}/logout" class="btn-logout">Logout</a></li>
    </ul>
</nav>

<div class="admin-container">
    <div class="page-header">
        <div>
            <h1 class="page-title">Catalog Inventory</h1>
            <div class="page-subtitle">Add, edit, or remove products in storefront database</div>
        </div>
        <button class="btn-action btn-accent" onclick="toggleAddForm()"><i class="fa-solid fa-plus"></i> Add Product</button>
    </div>

    <c:if test="${not empty param.msg}">
        <div class="alert-success">
            <i class="fa-solid fa-circle-check"></i> ${param.msg}
        </div>
    </c:if>

    <!-- Collapsible Add Product Panel -->
    <div class="collapsible-form-panel" id="addProductPanel">
        <h2 style="font-size: 16px; text-transform: uppercase; margin-bottom: 20px; border-bottom: 1px solid var(--border-color); padding-bottom: 10px;">Add New Product</h2>
        <form action="${ctx}/admin/products" method="post">
            <input type="hidden" name="action" value="add">
            
            <div class="form-grid">
                <div class="form-group">
                    <label>Product Name</label>
                    <input type="text" name="name" required placeholder="Classic Oversized Tee">
                </div>
                <div class="form-group">
                    <label>Fulfillment Price (₹)</label>
                    <input type="number" name="price" required placeholder="2499">
                </div>
                <div class="form-group">
                    <label>Original Price (For Discount, ₹)</label>
                    <input type="number" name="originalPrice" placeholder="2999">
                </div>
                <div class="form-group">
                    <label>Discount Percentage (%)</label>
                    <input type="number" name="discount" value="0" placeholder="15">
                </div>
                <div class="form-group">
                    <label>Category</label>
                    <select name="category" required>
                        <option value="Tops">Tops</option>
                        <option value="Bottoms">Bottoms</option>
                        <option value="Footwear">Footwear</option>
                        <option value="Accessories">Accessories</option>
                        <option value="Outerwear">Outerwear</option>
                        <option value="Sets">Sets</option>
                        <option value="Pants">Pants</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Apparel Type</label>
                    <input type="text" name="type" placeholder="Oversized Tee" required>
                </div>
                <div class="form-group">
                    <label>Sizes (Comma separated)</label>
                    <input type="text" name="size" value="S, M, L, XL" required placeholder="S, M, L, XL">
                </div>
                <div class="form-group">
                    <label>Colors (Comma separated)</label>
                    <input type="text" name="color" value="Black, White" required placeholder="Charcoal Noir">
                </div>
                <div class="form-group">
                    <label>Gender Targeting</label>
                    <select name="gender" required>
                        <option value="Unisex">Unisex</option>
                        <option value="Men">Men</option>
                        <option value="Women">Women</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Brand Name</label>
                    <input type="text" name="brand" value="AuraWear" required>
                </div>
                <div class="form-group" style="grid-column: span 2;">
                    <label>Image Asset Name / URL</label>
                    <input type="text" name="image" value="fallback.jpg" required placeholder="assets/images/tee6.jpg or tee6.jpg">
                </div>
            </div>

            <button type="submit" class="btn-action btn-accent">Save Product</button>
            <button type="button" class="btn-action" onclick="toggleAddForm()" style="margin-left: 10px;">Cancel</button>
        </form>
    </div>

    <!-- Products Table -->
    <div class="table-container">
        <table class="admin-table">
            <thead>
                <tr>
                    <th>Asset</th>
                    <th>Name</th>
                    <th>Category</th>
                    <th>Type</th>
                    <th>Price</th>
                    <th>Original</th>
                    <th>Sizes</th>
                    <th>Colors</th>
                    <th>Gender</th>
                    <th style="width: 180px;">Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="prod" items="${products}">
                    <tr>
                        <td>
                            <img src="${ctx}/assets/images/${prod.image}" class="product-thumbnail" alt="${prod.name}" onerror="this.src='${ctx}/assets/images/fallback.jpg';">
                        </td>
                        <td><strong>${prod.name}</strong></td>
                        <td>${prod.category}</td>
                        <td>${prod.type}</td>
                        <td>₹<fmt:formatNumber value="${prod.price}" type="number" maxFractionDigits="0" /></td>
                        <td>₹<fmt:formatNumber value="${prod.originalPrice}" type="number" maxFractionDigits="0" /></td>
                        <td>${prod.size}</td>
                        <td>${prod.color}</td>
                        <td>${prod.gender}</td>
                        <td>
                            <button class="btn-edit" onclick="openEditModal(
                                '${prod.id}', 
                                '${prod.name.replace("'", "\\'")}', 
                                '${prod.price}', 
                                '${prod.originalPrice}', 
                                '${prod.discount}', 
                                '${prod.category}', 
                                '${prod.type}', 
                                '${prod.size}', 
                                '${prod.color}', 
                                '${prod.gender}', 
                                '${prod.rating}', 
                                '${prod.reviews}', 
                                '${prod.brand}', 
                                '${prod.image}'
                            )">Edit</button>
                            <form action="${ctx}/admin/products" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this product?');">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="productId" value="${prod.id}">
                                <button type="submit" class="btn-delete">Delete</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- Edit Modal Box -->
<div class="admin-modal" id="editModal">
    <div class="modal-content">
        <button class="modal-close" onclick="closeEditModal()">&times;</button>
        <h2 style="font-size: 16px; text-transform: uppercase; margin-bottom: 20px; border-bottom: 1px solid var(--border-color); padding-bottom: 10px;">Edit Product Info</h2>
        <form action="${ctx}/admin/products" method="post">
            <input type="hidden" name="action" value="edit">
            <input type="hidden" name="productId" id="editProductId">
            
            <div class="form-grid">
                <div class="form-group">
                    <label>Product Name</label>
                    <input type="text" name="name" id="editName" required>
                </div>
                <div class="form-group">
                    <label>Fulfillment Price (₹)</label>
                    <input type="number" name="price" id="editPrice" required>
                </div>
                <div class="form-group">
                    <label>Original Price (₹)</label>
                    <input type="number" name="originalPrice" id="editOriginalPrice">
                </div>
                <div class="form-group">
                    <label>Discount Percentage (%)</label>
                    <input type="number" name="discount" id="editDiscount" value="0">
                </div>
                <div class="form-group">
                    <label>Category</label>
                    <select name="category" id="editCategory" required>
                        <option value="Tops">Tops</option>
                        <option value="Bottoms">Bottoms</option>
                        <option value="Footwear">Footwear</option>
                        <option value="Accessories">Accessories</option>
                        <option value="Outerwear">Outerwear</option>
                        <option value="Sets">Sets</option>
                        <option value="Pants">Pants</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Apparel Type</label>
                    <input type="text" name="type" id="editType" required>
                </div>
                <div class="form-group">
                    <label>Sizes (Comma separated)</label>
                    <input type="text" name="size" id="editSize" required>
                </div>
                <div class="form-group">
                    <label>Colors (Comma separated)</label>
                    <input type="text" name="color" id="editColor" required>
                </div>
                <div class="form-group">
                    <label>Gender Targeting</label>
                    <select name="gender" id="editGender" required>
                        <option value="Unisex">Unisex</option>
                        <option value="Men">Men</option>
                        <option value="Women">Women</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Brand Name</label>
                    <input type="text" name="brand" id="editBrand" required>
                </div>
                <div class="form-group" style="grid-column: span 2;">
                    <label>Image Asset Name / URL</label>
                    <input type="text" name="image" id="editImage" required>
                </div>
            </div>

            <button type="submit" class="btn-action btn-accent">Save Changes</button>
            <button type="button" class="btn-action" onclick="closeEditModal()" style="margin-left: 10px;">Cancel</button>
        </form>
    </div>
</div>

<script>
    function toggleAddForm() {
        const panel = document.getElementById("addProductPanel");
        if (panel.style.display === "block") {
            panel.style.display = "none";
        } else {
            panel.style.display = "block";
        }
    }

    function openEditModal(id, name, price, originalPrice, discount, category, type, size, color, gender, rating, reviews, brand, image) {
        document.getElementById('editProductId').value = id;
        document.getElementById('editName').value = name;
        document.getElementById('editPrice').value = Math.round(price);
        document.getElementById('editOriginalPrice').value = Math.round(originalPrice);
        document.getElementById('editDiscount').value = discount;
        document.getElementById('editCategory').value = category;
        document.getElementById('editType').value = type;
        document.getElementById('editSize').value = size;
        document.getElementById('editColor').value = color;
        document.getElementById('editGender').value = gender;
        document.getElementById('editBrand').value = brand;
        document.getElementById('editImage').value = image;
        document.getElementById('editModal').style.display = 'flex';
    }

    function closeEditModal() {
        document.getElementById('editModal').style.display = 'none';
    }
</script>

</body>
</html>
