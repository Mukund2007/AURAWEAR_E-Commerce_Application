# 🌌 AURAWEAR — Premium Streetwear E-Commerce Platform

<div align="left">
  <a href="https://aurawear-e-commerce-apllication.onrender.com" target="_blank">
    <img src="https://img.shields.io/badge/Live_Demo-onrender.com-ff0001?style=for-the-badge&logo=render&logoColor=white" alt="Live Demo" />
  </a>
  <img src="https://img.shields.io/badge/Database-Aiven_MySQL-0d0d0d?style=for-the-badge&logo=mysql&logoColor=white" alt="Database" />
  <img src="https://img.shields.io/badge/Payments-Razorpay-0d0d0d?style=for-the-badge&logo=razorpay&logoColor=white" alt="Razorpay" />
  <img src="https://img.shields.io/badge/Docker-Ready-0d0d0d?style=for-the-badge&logo=docker&logoColor=white" alt="Docker" />
</div>

AuraWear is a full-stack streetwear e-commerce platform built on a **Java EE Enterprise Stack** — Java 17, Jakarta Servlets, JSTL, and Tomcat 10, backed by Aiven-hosted MySQL. It pairs production-style backend infrastructure (real Razorpay payments, OTP-verified accounts, an admin back office, hardened session security) with an editorial, design-forward frontend full of cinematic micro-interactions.

---

## 🎥 Live Platform Demo & User Interactions

<p align="left">
  <a href="https://www.linkedin.com/in/mukunda-madhava-reddy-767ba6334" target="_blank">
    <img src="https://img.shields.io/badge/Watch_Walkthrough_on_LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" alt="Watch on LinkedIn" />
  </a>
</p>

---

## 🛍️ Storefront & Commerce

* **Catalog** — 50 seeded products across Tops, Bottoms, Footwear, Outerwear, Accessories, and Sets, each with size, color, gender, brand, stock, and discount data.
* **Collections, Search & Product Detail** — Browsable collection views, product search, and a dedicated detail page per product.
* **Cart** — Server-side persistent cart (add / update quantity / remove), with a live cart-count badge in the navbar.
* **Checkout — two paths**:
  * **Razorpay** online payment (test/live mode toggle via env vars).
  * **Cash on Delivery (COD)**, handled by a separate checkout flow.
* **Shipping rules** — Configurable free-shipping threshold and flat shipping charge, driven by a `shop_settings` table (editable from the admin panel).
* **Orders** — Order placement, payment-success handling, status tracking, and a "My Orders" page where customers can cancel placed orders or return delivered ones (ownership verified server-side via session).
* **Reviews** — One review per user per product (enforced at the database level), with a 1–5 star rating and text.
* **Wishlist** — Add, view, and remove items independent of the cart.
* **User Style Profile** — Each account can store a style preference, clothing size, fit preference, and interests, separate from login credentials.

## 🔐 Accounts & Auth

* **Registration with email OTP verification** — new accounts are unverified until the user confirms a one-time code emailed via Gmail SMTP (JavaMail); `users.verified` gates login.
* **Session-based login** for both customers and admins, with role checked server-side (`role = 'customer' | 'admin'`) before granting access to admin routes.
* **Hardened cookies** — sessions use `HttpOnly` + `Secure` cookies, cookie-only tracking (no URL session IDs), and a 30-minute timeout, all set at the deployment-descriptor level.
* **Password hashing** via a dedicated `PasswordUtil`, with a one-off `MigratePasswords` utility provided for hashing any legacy plaintext records.

## 🛠️ Admin Back Office

* **Admin login**, separate from customer login, redirecting non-admin sessions away from every `/admin/*` route.
* **Dashboard** — live totals for revenue, order count, and product count, plus a feed of recent orders, computed directly from the database on each load.
* **Order management** — view and update order status (e.g. processing → shipped → delivered).
* **Product management** — create and update catalog entries.
* **Settings** — edit shop-wide values (shipping threshold, shipping charge) without touching code.

## 🛡️ Security & Infrastructure

* **Servlet filter chain**: `CsrfFilter`, `RateLimitFilter`, `SecurityHeadersFilter`, and `LoginFilter` sit in front of the application, handling CSRF protection, request throttling, hardened response headers, and auth gating respectively.
* **HikariCP** connection pooling against Aiven MySQL.
* **Environment-variable configuration** for every secret (DB credentials, Gmail app password, Razorpay keys) — nothing sensitive is committed, and `app-local.properties` / `razorpay-local.properties` are explicitly excluded from the packaged WAR at build time.
* **Health check endpoint** for uptime monitoring.
* **Dockerized** — a multistage `Dockerfile` (Maven build stage → Tomcat 10 / JDK 17 runtime stage) producing a self-contained image with JVM heap auto-tuned to 75% of the container's available RAM.

## 🎨 Creative Interaction & Design Systems

### 1. Persistent Thematic Color Matrix
Toggles the entire storefront canvas, cards, and outline grids seamlessly between three custom color profiles (persisted locally to prevent any *Flash of Unstyled Content*):
* **Canvas (Warm Cream)**: Warm cream paper canvas (`#ede4dd` / `#f0e9e2`), charcoal outlines, and dark structural typography (`#0d0d0d`).
* **Noir (Pitch Black)**: Solid dark canvas (`#0d0d0d`), warm cream outlines, and crisp white typography.
* **Red (Signal Accent)**: High-visibility bold red canvas (`#ff0001`), translucent bento card overlays, and dark typography.

### 🕹️ 2. Signature Cursor Follower (Inertia Mouse Trail)
* A custom `requestAnimationFrame` lerp-smoothed trailing **red cursor dot** (`.custom-cursor-follower`) tracking mouse coordinates with organic lag/inertia.
* Dynamically expands into a `28px` semi-transparent red border aura on hover over buttons, swatches, and active links.
* **Mobile Touch Safe**: Automatically disables on touchscreens via responsive media queries to ensure accessible taps.

### 📊 3. Cinematic "My Orders" Bento Dashboard
* **Backdrop Mesh Glow**: Elegant, keyframe-animated radial mesh glow backdrop floating behind headers.
* **Live Runtime Summary Stats**: Computes order counters (Total Curated, Active Transit, Delivered) on the fly via JSTL core tags, rendering them inside glassmorphic summary widgets.
* **Slide-Up Tracking Drawer**: A premium milestone timeline modal that slides up from the viewport with a heavy blur backdrop (`backdrop-filter: blur(24px)`).
* **Secure Actions**: Customer capabilities to "Cancel Placed Orders" and "Return Delivered Items" verified through session ownership in the backend.

### 📱 4. Mobile Viewport Architecture (≤ 768px)
* Forced navbar structure to prevent logo wrapping (`flex-wrap: nowrap`) on narrow screens (like `375px`).
* Hides bulky search inputs and secondary action links to maintain a minimalist, balanced mobile header.
* **Overlay Mobile Search**: Dynamically inserts a prominent mobile-only search bar at the top of the slide-out fullscreen hamburger menu drawer (`#menuOverlay`).

---

## 📂 Core Repository Architecture

```text
AuraWear/
├── src/
│   ├── main/
│   │   ├── java/com/aurawear/
│   │   │   ├── controller/          # 28 servlets — home, products, collections, cart, checkout
│   │   │   │                          (Razorpay + COD), orders, reviews, wishlist, profile,
│   │   │   │                          register/login/OTP, health check, and admin/*
│   │   │   ├── dao/                 # UserDAO, LoginDAO, ProductDAO, CartDAO, ReviewDAO,
│   │   │   │                          WishlistDAO, AdminDAO
│   │   │   ├── model/               # User, UserProfile, Product, CartItem, Order, OrderItem,
│   │   │   │                          Review, WishlistItem
│   │   │   ├── filter/              # CsrfFilter, RateLimitFilter, SecurityHeadersFilter, LoginFilter
│   │   │   ├── config/              # AppConfig, AppStartupListener, RazorpayConfig
│   │   │   └── util/                # DBConnection (HikariCP), PasswordUtil, EmailUtil,
│   │   │                              SettingsUtil, MigratePasswords, TestConnection
│   │   ├── resources/                # app-local.properties / razorpay-local.properties (excluded from WAR)
│   │   └── webapp/
│   │       ├── assets/
│   │       │   ├── css/             # Per-page stylesheets (home, products, cart, checkout,
│   │       │   │                      orders, wishlist, profile, auth, navbar, …)
│   │       │   ├── js/               # app-interactions.js — theme matrix, cursor follower, nav
│   │       │   └── images/          # Streetwear catalog imagery
│   │       └── WEB-INF/
│   │           ├── views/
│   │           │   ├── admin/       # Dashboard, products, orders, settings, admin login
│   │           │   ├── auth/        # Register / OTP templates
│   │           │   ├── cart/, orders/, products/, collections/, wishlist/, profile/
│   │           │   └── partials/    # navbar.jsp, login-modal.jsp, head-includes.jsp
│   │           └── web.xml          # Servlet mappings + session security config
│   └── test/java/com/aurawear/controller/   # Controller tests
├── schema.sql                        # Full MySQL schema: users, products, cart, orders,
│                                        order_items, reviews, wishlist, user_profiles, shop_settings
├── Dockerfile                        # Multistage build: Maven 3.9 → Tomcat 10 / JDK 17 runtime
└── pom.xml                           # Maven dependencies (Jakarta Servlet, MySQL Connector/J,
                                         JSTL, JavaMail, HikariCP, Razorpay SDK)
```

---

## 🛠️ Installation & Local Setup

### Prerequisites
* **JDK 17**
* **Maven** (or an IDE with Maven support — e.g. Eclipse IDE for Enterprise Java Developers)
* **Apache Tomcat 10.x** — this app uses the Jakarta `jakarta.servlet` namespace, so **Tomcat 9 will not work**
* **MySQL** — a hosted instance such as Aiven works out of the box; run `schema.sql` to provision all tables
* **Gmail account + [App Password](https://myaccount.google.com/apppasswords)** for sending OTP/order emails
* **A free [Razorpay](https://razorpay.com/) account** for test-mode API keys

### ⚙️ Environment Variables
Every secret is supplied via environment variables at runtime — see `.env.example` for the full reference. Nothing here is ever committed to git:

| Variable | Purpose |
|---|---|
| `AURAWEAR_DB_URL`, `AURAWEAR_DB_USER`, `AURAWEAR_DB_PASSWORD` | MySQL connection (JDBC URL, least-privilege app user, password) |
| `AURAWEAR_EMAIL`, `AURAWEAR_EMAIL_PASSWORD` | Gmail sender address and App Password for OTP/order emails |
| `RAZORPAY_LIVE_MODE` | `true` / `false` — toggles live vs. test payment keys |
| `RAZORPAY_TEST_KEY_ID`, `RAZORPAY_TEST_KEY_SECRET` | Razorpay test-mode credentials |
| `RAZORPAY_LIVE_KEY_ID`, `RAZORPAY_LIVE_KEY_SECRET` | Razorpay live-mode credentials (only required when live mode is on) |

**Local setup (Tomcat `bin/setenv.sh`)** — create `setenv.sh` (or `setenv.bat` on Windows) in your Tomcat `bin/` directory:
```sh
export AURAWEAR_DB_URL="jdbc:mysql://localhost:3306/aurawear"
export AURAWEAR_DB_USER="aurawear_app"
export AURAWEAR_DB_PASSWORD="your_db_password"
export AURAWEAR_EMAIL="your_address@gmail.com"
export AURAWEAR_EMAIL_PASSWORD="your_16_char_app_password"
export RAZORPAY_LIVE_MODE="false"
export RAZORPAY_TEST_KEY_ID="rzp_test_..."
export RAZORPAY_TEST_KEY_SECRET="your_test_secret"
export RAZORPAY_LIVE_KEY_ID="rzp_live_..."
export RAZORPAY_LIVE_KEY_SECRET="your_live_secret"
```

**Eclipse IDE launch configuration** (if running Tomcat through Eclipse):
1. Double-click your **Tomcat Server** in the Eclipse **Servers** panel.
2. Click **Open launch configuration** under *General Information*.
3. Go to the **Environment** tab → **New...** → add all variables above.

### Local Deployment Steps
1. **Clone the repository**:
   ```bash
   git clone https://github.com/Mukund2007/AURAWEAR_E-Commerce_Application.git
   cd AURAWEAR_E-Commerce_Application
   ```
2. **Provision the database** — run `schema.sql` against your MySQL instance. This creates `users`, `products` (pre-seeded with 50 items), `cart`, `orders`, `order_items`, `reviews`, `wishlist`, `user_profiles`, and `shop_settings`.
3. **Import into Eclipse** (or your Maven-aware IDE):
   * `File → Import → Existing Maven Projects`, browse to the cloned folder, click `Finish`.
4. **Configure Apache Tomcat 10**:
   * Add Tomcat 10 under Eclipse `Servers` runtime.
   * Right-click the `AuraWear` project → `Run As → Run on Server`.
5. **Access locally**:
   * `http://localhost:8080/AuraWear/home`

### 🐳 Run with Docker (alternative)
```bash
docker build -t aurawear .
docker run -p 8080:8080 \
  -e AURAWEAR_DB_URL="jdbc:mysql://<host>:3306/aurawear" \
  -e AURAWEAR_DB_USER="..." \
  -e AURAWEAR_DB_PASSWORD="..." \
  -e AURAWEAR_EMAIL="..." \
  -e AURAWEAR_EMAIL_PASSWORD="..." \
  -e RAZORPAY_LIVE_MODE="false" \
  -e RAZORPAY_TEST_KEY_ID="..." \
  -e RAZORPAY_TEST_KEY_SECRET="..." \
  aurawear
```
The app will be available at `http://localhost:8080/`.

--
