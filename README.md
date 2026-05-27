# 🌌 AURAWEAR — Premium Streetwear E-Commerce Storefront

AuraWear is a highly polished, editorial, and design-forward e-commerce web application inspired by high-end boutique storefront design systems. Built on a robust **Java EE Enterprise Stack** (Tomcat, Servlets, JSTL, Relational SQLite Database), it merges architectural backend logic with rich, cinematic frontend micro-interactions.

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

### Local Deployment Steps
1.  **Clone the Repository**:
    ```bash
    git clone https://github.com/Mukund2007/AURAWEAR_E-Commerce_Apllication.git
    cd AURAWEAR_E-Commerce_Apllication
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
