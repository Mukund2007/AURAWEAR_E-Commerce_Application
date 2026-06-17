# 🌌 AURAWEAR — Premium Streetwear E-Commerce Storefront

<div align="left">
  <a href="https://aurawear-e-commerce-apllication.onrender.com" target="_blank">
    <img src="https://img.shields.io/badge/Live_Demo-onrender.com-ff0001?style=for-the-badge&logo=render&logoColor=white" alt="Live Demo" />
  </a>
  <a href="https://aurawear-e-commerce-apllication.onrender.com" target="_blank">
    <img src="https://img.shields.io/badge/Database-Aiven_MySQL-0d0d0d?style=for-the-badge&logo=mysql&logoColor=white" alt="Database" />
  </a>
</div>

AuraWear is a highly polished, editorial, and design-forward e-commerce web application inspired by high-end boutique storefront design systems. Built on a robust **Java EE Enterprise Stack** (Tomcat, Servlets, JSTL, Relational Aiven MySQL Database), it merges architectural backend logic with rich, cinematic frontend micro-interactions.

---

## 🎥 Live Platform Demo & User Interactions

<p align="left">
  <a href="https://www.linkedin.com/in/mukunda-madhava-reddy-767ba6334" target="_blank">
    <img src="https://img.shields.io/badge/Watch_Walkthrough_on_LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" alt="Watch on LinkedIn" />
  </a>
</p>
---

## 🎨 Creative Interaction & Design Systems

### 1. Persistent Thematic Color Matrix
Toggles the entire storefront canvas, cards, and outline grids seamlessly between three custom color profiles (persisted locally to prevent any *Flash of Unstyled Content*):
*   **Canvas (Warm Cream)**: Warm cream paper canvas (`#ede4dd` / `#f0e9e2`), charcoal outlines, and dark structural typography (`#0d0d0d`).
*   **Noir (Pitch Black)**: Solid dark canvas (`#0d0d0d`), warm cream outlines, and crisp white typography.
*   **Red (Signal Accent)**: High-visibility bold red canvas (`#ff0001`), translucent bento card overlays, and dark typography.

### 🕹️ 2. Signature Cursor Follower (Inertia Mouse Trail)
*   A custom `requestAnimationFrame` lerp-smoothed trailing **red cursor dot** (`.custom-cursor-follower`) tracking mouse coordinates with organic lag/inertia.
*   Dynamically expands into a `28px` semi-transparent red border aura on hover over buttons, swatches, and active links.
*   **Mobile Touch Safe**: Automatically disables on touchscreens via responsive media queries to ensure accessible taps.

### 📊 3. Cinematic "My Orders" Bento Dashboard
*   **Backdrop Mesh Glow**: Elegant, keyframe-animated radial mesh glow backdrop floating behind headers.
*   **Live Runtime Summary Stats**: Computes order counters (Total Curated, Active Transit, Delivered) on the fly via JSTL core tags, rendering them inside glassmorphic summary widgets.
*   **Slide-Up Tracking Drawer**: A premium milestone timeline modal that slides up from the viewport with a heavy blur backdrop (`backdrop-filter: blur(24px)`).
*   **Secure Actions**: Customer capabilities to "Cancel Placed Orders" and "Return Delivered Items" verified through session ownership in the backend.

### 📱 4. Mobile Viewport Architecture (<= 768px)
*   Forced navbar structure to prevent logo wrapping (`flex-wrap: nowrap`) on narrow screens (like `375px`).
*   Hides bulky search inputs and secondary action links to maintain a minimalist, balanced mobile header.
*   **Overlay Mobile Search**: Dynamically inserts a prominent mobile-only search bar at the top of the slide-out fullscreen hamburger menu drawer (`#menuOverlay`).

---

## 📂 Core Repository Architecture

```text
AuraWear/
├── src/
│   └── main/
│       ├── java/com/aurawear/
│       │   ├── controller/          # Java Servlets (Login, Cart, UpdateOrderStatus, etc.)
│       │   ├── dao/                 # Data Access Objects (UserDAO, OrderDAO, CartDAO, etc.)
│       │   └── model/               # Entity Classes (User, Order, CartItem, Product)
│       └── webapp/
│           ├── assets/
│           │   ├── css/             # Global stylesheets (home.css, orders.css, etc.)
│           │   └── images/          # High-resolution streetwear catalog imagery
│           └── WEB-INF/
│               ├── views/
│               │   ├── auth/        # Login/Register view templates
│               │   ├── orders/      # Checkout, Success, and My Orders views
│               │   └── partials/    # Global fragments (navbar.jsp, login-modal.jsp)
│               └── web.xml          # Servlet mapping and deployment descriptor
└── pom.xml                          # Maven dependency configuration
```

---

## 🛠️ Installation & Local Setup

### Prerequisites
*   **Java Development Kit (JDK)**: JDK 11 or higher (JDK 17 recommended).
*   **IDE**: Eclipse IDE for Enterprise Java Developers.
*   **Server**: Apache Tomcat 9.0+.
*   **Database**: HSQLDB / Relational SQLite (included).
*   **Environment Variables**: Set up environment variables to supply Razorpay keys (refer to the settings below).

### ⚙️ Razorpay Integration & Configuration
The project loads Razorpay payment gateway credentials dynamically at runtime to prevent secret leakages. The following 5 environment variables must be configured on your local Tomcat environment:

*   `RAZORPAY_LIVE_MODE` (set to `true` or `false`)
*   `RAZORPAY_TEST_KEY_ID`
*   `RAZORPAY_TEST_KEY_SECRET`
*   `RAZORPAY_LIVE_KEY_ID`
*   `RAZORPAY_LIVE_KEY_SECRET`

**Local Setup (Tomcat `bin/setenv.sh`)**:
Create a file named `setenv.sh` (or `setenv.bat` on Windows) inside your Tomcat's `bin/` directory with the following exports (note: `setenv.sh` is excluded from git):
```sh
export RAZORPAY_LIVE_MODE="false"
export RAZORPAY_TEST_KEY_ID="rzp_test_..."
export RAZORPAY_TEST_KEY_SECRET="your_test_secret"
export RAZORPAY_LIVE_KEY_ID="rzp_live_..."
export RAZORPAY_LIVE_KEY_SECRET="your_live_secret"
```

**Eclipse IDE Launch Configuration**:
If launching Tomcat through Eclipse:
1. Double-click your **Tomcat Server** in the Eclipse **Servers** panel.
2. Click **Open launch configuration** under *General Information*.
3. Go to the **Environment** tab, click **New...**, and add all 5 variables.

### Local Deployment Steps
1.  **Clone the Repository**:
    ```bash
    git clone https://github.com/Mukund2007/AURAWEAR_E-Commerce_Application.git
    cd AURAWEAR_E-Commerce_Application
    ```
2.  **Import into Eclipse**:
    *   Open Eclipse IDE.
    *   Go to `File -> Import -> Existing Maven Projects`.
    *   Browse to the cloned folder and click `Finish`.
3.  **Configure Apache Tomcat Server**:
    *   Add Tomcat 9 under Eclipse `Servers` runtime.
    *   Right-click `AuraWear` project -> `Run As -> Run on Server`.
4.  **Local Access**:
    *   Open your browser and navigate to `http://localhost:8080/AuraWear/home`.

---

## 🔗 Design Inspiration & Credits
AuraWear’s micro-interactions, layout transitions, and bold color canvas toggles are inspired by the digital streetwear agency store ++hellohello (**outfit.hellohello.is**).
