<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<style>
.login-overlay {
    position: fixed !important;
    top: 0 !important; left: 0 !important;
    right: 0 !important; bottom: 0 !important;
    background: rgba(0, 0, 0, 0.4);
    backdrop-filter: blur(8px);
    -webkit-backdrop-filter: blur(8px);
    z-index: 99999 !important;
    display: flex !important;
    align-items: center;
    justify-content: center;
    padding: 20px;
    opacity: 0;
    visibility: hidden;
    transition: opacity 0.3s ease, visibility 0.3s ease;
}
.login-overlay.active {
    opacity: 1 !important;
    visibility: visible !important;
}
.login-modal {
    width: 100%;
    max-width: 440px;
    max-height: 90vh;
    background: var(--bg-color); /* Theme-aware Background */
    border: 1.5px solid var(--border-color-solid);
    border-radius: 0px; /* Flat */
    padding: 44px 40px;
    overflow-y: auto;
    position: relative;
    transform: scale(0.94) translateY(12px);
    transition: transform 0.4s cubic-bezier(0.16, 1, 0.3, 1), background 0.8s, border-color 0.8s, color 0.8s;
    box-shadow: 8px 8px 0px var(--border-color-solid); /* Solid Offset Shadow */
    color: var(--text-color);
}
.login-overlay.active .login-modal {
    transform: scale(1) translateY(0);
}
.modal-close {
    position: absolute; top: 20px; right: 20px;
    background: var(--card-bg); border: 1.5px solid var(--border-color-solid); font-size: 14px;
    cursor: pointer; color: var(--text-color); width: 34px; height: 34px;
    border-radius: 0%; display: flex; align-items: center;
    justify-content: center; transition: all 0.2s ease, background 0.8s, border-color 0.8s, color 0.8s;
}
.modal-close:hover { background: var(--accent-color); color: var(--bg-color); border-color: var(--accent-color); transform: rotate(90deg); }
.modal-brand { display: flex; align-items: center; gap: 12px; margin-bottom: 28px; }
.modal-brand-logo {
    width: 40px; height: 40px; background: var(--border-color-solid); color: var(--bg-color);
    font-size: 13px; font-weight: 900; letter-spacing: 1px;
    border-radius: 0px; display: flex; align-items: center;
    justify-content: center; flex-shrink: 0;
    border: 1.5px solid var(--border-color-solid);
    transition: background 0.8s, color 0.8s, border-color 0.8s;
}
.modal-brand-name { font-size: 16px; font-weight: 900; letter-spacing: 2px; color: var(--text-color); text-transform: uppercase; transition: color 0.8s; }
.modal-brand-sub  { font-size: 9px; letter-spacing: 3px; color: var(--text-color); opacity: 0.6; text-transform: uppercase; margin-top: 2px; transition: color 0.8s; }
.modal-title { font-size: 26px; font-weight: 900; letter-spacing: -1px; margin-bottom: 6px; color: var(--text-color); text-transform: uppercase; transition: color 0.8s; }
.modal-sub   { font-size: 14px; color: var(--text-color); opacity: 0.6; margin-bottom: 26px; font-weight: 600; transition: color 0.8s; }
.modal-error {
    background: rgba(255, 0, 1, 0.1); border: 1.5px solid var(--accent-color); color: var(--accent-color);
    font-size: 13px; font-weight: 800; padding: 12px 16px;
    border-radius: 0px; margin-bottom: 16px; text-transform: uppercase;
    transition: border-color 0.8s, color 0.8s;
}
.modal-field { margin-bottom: 18px; }
.modal-field label {
    display: block; font-size: 11px; font-weight: 800;
    letter-spacing: 1.5px; text-transform: uppercase;
    color: var(--text-color); margin-bottom: 8px;
    transition: color 0.8s;
}
.modal-field input {
    width: 100%; padding: 13px 16px; font-size: 14px;
    border: 1.5px solid var(--border-color-solid); border-radius: 0px;
    background: var(--input-bg); color: var(--text-color); font-family: inherit;
    outline: none; transition: all 0.25s ease, background 0.8s, border-color 0.8s, color 0.8s;
    font-weight: 600;
}
.modal-field input:focus {
    border-color: var(--accent-color);
    box-shadow: 4px 4px 0px var(--border-color-solid);
}
.modal-field input::placeholder { color: var(--text-color); opacity: 0.4; }
.modal-forgot {
    display: block; text-align: right; font-size: 12px;
    color: var(--text-color); opacity: 0.6; margin-top: 6px; text-decoration: none;
    transition: color 0.2s, opacity 0.8s;
    font-weight: 700;
}
.modal-forgot:hover { color: var(--accent-color); opacity: 1; }
.modal-signin-btn {
    width: 100%; padding: 15px; background: var(--border-color-solid); color: var(--bg-color);
    border: 1.5px solid var(--border-color-solid); border-radius: 0px; font-size: 13px;
    font-weight: 800; letter-spacing: 1.5px; text-transform: uppercase;
    cursor: pointer; font-family: inherit; margin-top: 8px;
    transition: all 0.25s ease, background 0.8s, color 0.8s, border-color 0.8s;
}
.modal-signin-btn:hover { background: var(--accent-color); border-color: var(--accent-color); color: var(--bg-color); transform: translate(-3px, -3px); box-shadow: 4px 4px 0px var(--border-color-solid); }
.modal-signin-btn:active { transform: translate(0, 0); }
.modal-divider {
    text-align: center; margin: 20px 0; position: relative;
    font-size: 11px; color: var(--text-color); letter-spacing: 2px;
    font-weight: 800; text-transform: uppercase;
    transition: color 0.8s;
}
.modal-divider::before, .modal-divider::after {
    content: ""; position: absolute; top: 50%;
    width: 43%; height: 1.5px; background: var(--border-color-solid);
    transition: background 0.8s;
}
.modal-divider::before { left: 0; }
.modal-divider::after  { right: 0; }
.modal-register-cta { text-align: center; font-size: 14px; color: var(--text-color); opacity: 0.6; margin-bottom: 26px; font-weight: 600; transition: color 0.8s; }
.modal-register-cta a {
    color: var(--accent-color); font-weight: 800; text-decoration: none;
    margin-left: 4px; border-bottom: 1.5px solid var(--accent-color); padding-bottom: 2px;
    transition: color 0.2s, border-color 0.2s;
}
.modal-register-cta a:hover {
    color: var(--text-color);
    border-color: var(--border-color-solid);
}
.modal-perks { display: flex; flex-direction: column; gap: 8px; padding-top: 22px; border-top: 1.5px solid var(--border-color-solid); transition: border-color 0.8s; }
.modal-perks span { font-size: 12px; color: var(--text-color); display: flex; align-items: center; gap: 8px; font-weight: 700; text-transform: uppercase; transition: color 0.8s; }
</style>

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

        <div class="modal-error" id="modalError" style="display:none;"></div>

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
</script>
