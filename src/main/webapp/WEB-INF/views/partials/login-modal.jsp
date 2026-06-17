<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<link rel="stylesheet" href="${ctx}/assets/css/login-modal.css">

<div class="login-overlay" id="loginOverlay" onclick="closeLoginModal(event)">
    <div class="login-modal" id="loginModal">

        <button class="modal-close" onclick="closeLoginModal()">
            <i class="fa-solid fa-xmark"></i>
        </button>

        <div class="modal-brand">
            <span class="modal-brand-logo">AW</span>
            <div>
                <div class="modal-brand-name">AURAWEAR</div>
                <div class="modal-brand-sub">WEAR YOUR AURA</div>
            </div>
        </div>

        <h2 class="modal-title">Welcome Back</h2>
        <p class="modal-sub">Sign in to your account</p>

        <div class="modal-error" id="modalError" <c:if test="${empty param.loginError}">style="display:none;"</c:if>>
            <c:if test="${not empty param.loginError}">
                Invalid email or password.
            </c:if>
        </div>

        <form action="${ctx}/login" method="post">
            <div class="modal-field">
                <label>Email</label>
                <input type="email" name="email" placeholder="your@email.com" required autocomplete="email">
            </div>
            <div class="modal-field">
                <label>Password</label>
                <input type="password" name="password" placeholder="••••••••" required autocomplete="current-password">
                <a href="#" class="modal-forgot">Forgot password?</a>
            </div>
            <button type="submit" class="modal-signin-btn">Sign In</button>
        </form>

        <div class="modal-divider"><span>or</span></div>

        <div class="modal-register-cta">
            Not a member? <a href="${ctx}/register">Create Account &rarr;</a>
        </div>

        <div class="modal-perks">
            <span>✨ Member Exclusives</span>
            <span>⚡ Early Access</span>
            <span>🌌 Premium Drops</span>
        </div>

    </div>
</div>

<script>
function openLoginModal() {
    document.getElementById("loginOverlay").classList.add("active");
    document.body.style.overflow = "hidden";
    setTimeout(() => {
        const inp = document.querySelector("#loginModal input[type='email']");
        if (inp) inp.focus();
    }, 300);
}
function closeLoginModal(e) {
    if (e && e.target !== document.getElementById("loginOverlay")) return;
    document.getElementById("loginOverlay").classList.remove("active");
    document.body.style.overflow = "";
}
document.addEventListener("keydown", function(e) {
    if (e.key === "Escape") {
        document.getElementById("loginOverlay").classList.remove("active");
        document.body.style.overflow = "";
    }
});

// Auto-open modal on redirect from LoginFilter or LoginServlet errors
document.addEventListener("DOMContentLoaded", function() {
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.has('login') || urlParams.has('loginError')) {
        openLoginModal();
    }
});
</script>
