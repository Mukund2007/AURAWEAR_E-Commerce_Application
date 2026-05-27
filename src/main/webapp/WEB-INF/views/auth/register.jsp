<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account — AuraWear</title>
    
    <script>
        (function() {
            var savedTheme = localStorage.getItem('auraTheme') || 'canvas';
            if (savedTheme !== 'canvas') {
                document.documentElement.classList.add('theme-' + savedTheme);
            }
        })();
    </script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --bg-color: #f0e9e2;
            --text-color: #0d0d0d;
            --border-color: rgba(13, 13, 13, 0.12);
            --border-color-solid: #0d0d0d;
            --accent-color: #ff0001;
            --card-bg: rgba(255, 255, 255, 0.45);
            --navbar-bg: rgba(240, 233, 226, 0.82);
            --input-bg: #ffffff;
        }

        html.theme-noir {
            --bg-color: #0d0d0d;
            --text-color: #ede4dd;
            --border-color: rgba(237, 228, 221, 0.15);
            --border-color-solid: #ede4dd;
            --accent-color: #ff0001;
            --card-bg: rgba(25, 25, 25, 0.5);
            --navbar-bg: rgba(13, 13, 13, 0.85);
            --input-bg: #1a1a1a;
        }

        html.theme-red {
            --bg-color: #ff0001;
            --text-color: #0d0d0d;
            --border-color: rgba(13, 13, 13, 0.25);
            --border-color-solid: #0d0d0d;
            --accent-color: #ede4dd;
            --card-bg: rgba(255, 255, 255, 0.25);
            --navbar-bg: rgba(255, 0, 1, 0.85);
            --input-bg: rgba(255, 255, 255, 0.4);
        }

        *, *::before, *::after { margin:0; padding:0; box-sizing:border-box; }
        
        html {
            background-color: var(--bg-color) !important;
            color: var(--text-color) !important;
            transition: background-color 0.8s cubic-bezier(0.76, 0, 0.24, 1), color 0.8s cubic-bezier(0.76, 0, 0.24, 1);
        }

        body { font-family:'Outfit', 'DM Sans', Arial, sans-serif; background:transparent; color:var(--text-color); transition: color 0.8s; }
        .auth-page { min-height:100vh; display:grid; grid-template-columns:1fr 1fr; }
        
        .auth-left {
            background:var(--border-color-solid); color:var(--bg-color); display:flex;
            align-items:center; justify-content:center; padding:60px 70px;
            position:relative; overflow:hidden;
            border-right: 1.5px solid var(--border-color-solid);
            transition: background 0.8s, border-color 0.8s, color 0.8s;
        }
        .auth-left::before {
            content:"AW"; position:absolute; bottom:-40px; right:-20px;
            font-size:260px; font-weight:900; letter-spacing:-10px;
            color:var(--bg-color); opacity:0.03; line-height:1; pointer-events:none;
            transition: color 0.8s;
        }
        .auth-left-inner { position:relative; z-index:2; max-width:380px; }
        .auth-left-brand { display:flex; align-items:center; gap:12px; margin-bottom:60px; }
        .auth-brand-logo {
            width:40px; height:40px; background:var(--bg-color); color:var(--text-color); font-size:13px;
            font-weight:900; border: 1.5px solid var(--border-color-solid); border-radius:0px; display:flex;
            align-items:center; justify-content:center; flex-shrink:0;
            transition: all 0.8s;
        }
        .auth-brand-name { font-size:16px; font-weight:900; letter-spacing:4px; color:var(--bg-color); text-transform:uppercase; transition: color 0.8s; }
        .auth-left-headline { font-size:68px; font-weight:900; line-height:0.95; letter-spacing:-3px; margin-bottom:24px; text-transform:uppercase; }
        .auth-left-sub { font-size:14px; color:var(--bg-color); opacity:0.65; line-height:1.7; margin-bottom:48px; font-weight:700; text-transform:uppercase; transition: color 0.8s; }
        .auth-left-perks { display:flex; flex-direction:column; gap:14px; }
        .auth-perk { display:flex; align-items:center; gap:12px; font-size:13px; color:var(--bg-color); opacity:0.85; font-weight:800; text-transform:uppercase; transition: color 0.8s; }
        .auth-perk i {
            width:32px; height:32px; background:var(--accent-color); color:var(--bg-color);
            border: 1.5px solid var(--border-color-solid); border-radius:0px; display:flex; align-items:center;
            justify-content:center; font-size:13px; flex-shrink:0;
            box-shadow: 2px 2px 0px var(--bg-color);
            transition: all 0.8s;
        }
        .auth-right {
            background:var(--bg-color); display:flex; align-items:center;
            justify-content:center; padding:60px 40px; overflow-y:auto;
            transition: background 0.8s;
        }
        .auth-form-wrap { width:100%; max-width:420px; }
        .auth-top-link { text-align:right; font-size:13px; color:var(--text-color); opacity:0.7; margin-bottom:40px; font-weight:700; text-transform:uppercase; transition: color 0.8s; }
        .auth-top-link a { color:var(--accent-color); font-weight:900; text-decoration:none; border-bottom:1.5px solid var(--accent-color); margin-left:4px; }
        .auth-steps { display:flex; align-items:center; margin-bottom:36px; }
        .auth-step { display:flex; flex-direction:column; align-items:center; gap:6px; }
        .auth-step span { font-size:10px; letter-spacing:0.5px; text-transform:uppercase; color:var(--text-color); opacity:0.5; font-weight:800; transition: color 0.8s; }
        .auth-step.active span, .auth-step.done span { color:var(--text-color); opacity:1; }
        .auth-step-circle {
            width:34px; height:34px; border-radius:0px; border:1.5px solid var(--border-color-solid);
            background:var(--card-bg); color:var(--text-color); font-size:12px; font-weight:900;
            display:flex; align-items:center; justify-content:center;
            transition: all 0.8s;
        }
        .auth-step.active .auth-step-circle, .auth-step.done .auth-step-circle {
            background:var(--accent-color); color:var(--bg-color); border-color:var(--accent-color); box-shadow: 3px 3px 0px var(--border-color-solid);
        }
        .auth-step-line { flex:1; height:1.5px; background:var(--border-color-solid); margin:0 8px 20px; transition: background 0.8s; }
        .auth-heading { font-size:32px; font-weight:900; letter-spacing:-1.5px; margin-bottom:6px; text-transform:uppercase; line-height:0.95; color:var(--text-color); transition: color 0.8s; }
        .auth-sub { font-size:12px; color:var(--text-color); opacity:0.6; font-weight:800; text-transform:uppercase; margin-bottom:28px; transition: color 0.8s; }
        .auth-error { background:var(--card-bg); border:1.5px solid var(--accent-color); color:var(--accent-color); font-size:11px; font-weight:800; text-transform:uppercase; padding:12px 14px; border-radius:0px; margin-bottom:16px; box-shadow: 4px 4px 0px var(--border-color-solid); transition: all 0.8s; }
        .auth-row { display:grid; grid-template-columns:1fr 1fr; gap:14px; }
        .auth-field { margin-bottom:16px; display:flex; flex-direction:column; gap:7px; }
        .auth-field label { font-size:11px; font-weight:800; letter-spacing:1px; text-transform:uppercase; color:var(--text-color); transition: color 0.8s; }
        .auth-field input {
            width:100%; padding:13px 16px; font-size:14px; border:1.5px solid var(--border-color-solid);
            border-radius:0px; background:var(--input-bg); color:var(--text-color); font-family:inherit; font-weight:700; outline:none;
            transition: background 0.8s, border-color 0.8s, color 0.8s, box-shadow 0.2s;
        }
        .auth-field input:focus { border-color:var(--accent-color); background:var(--input-bg); box-shadow:4px 4px 0px var(--border-color-solid); }
        .auth-field input::placeholder { color:var(--text-color); opacity:0.4; }
        .auth-terms { display:flex; align-items:flex-start; gap:10px; margin:6px 0 20px; }
        .auth-terms input[type="checkbox"] { margin-top:2px; accent-color:var(--accent-color); width:15px; height:15px; flex-shrink:0; border:1.5px solid var(--border-color-solid); border-radius:0px; }
        .auth-btn {
            width:100%; padding:15px; background:var(--border-color-solid); color:var(--bg-color); border:1.5px solid var(--border-color-solid);
            border-radius:0px; font-size:12px; font-weight:900; letter-spacing:1.5px;
            text-transform:uppercase; cursor:pointer; font-family:inherit; transition: all 0.25s ease;
        }
        .auth-btn:hover { background:var(--accent-color); border-color:var(--accent-color); color:var(--bg-color); transform: translate(-4px, -4px); box-shadow: 4px 4px 0px var(--border-color-solid); }
        .auth-btn:disabled { opacity:0.3; cursor:not-allowed; transform:none; box-shadow:none; }
        .auth-btn-outline { background:transparent; color:var(--text-color); border:1.5px solid var(--border-color-solid); }
        .auth-btn-outline:hover { background:var(--accent-color); color:var(--bg-color); border-color:var(--accent-color); }
        .otp-boxes { display:flex; justify-content:center; gap:10px; margin:28px 0; }
        .otp-boxes input { width:52px !important; height:58px !important; padding:0 !important; text-align:center; font-size:22px; font-weight:900; border:1.5px solid var(--border-color-solid); border-radius:0px; background:var(--input-bg); color:var(--text-color); outline:none; font-family:inherit; transition: all 0.2s, background 0.8s, border-color 0.8s, color 0.8s; }
        .otp-boxes input:focus { border-color:var(--accent-color); background:var(--input-bg); box-shadow: 3px 3px 0px var(--border-color-solid); transform: translateY(-2px); }
        .otp-resend { text-align:center; font-size:12px; color:var(--text-color); opacity:0.7; font-weight:800; text-transform:uppercase; margin-bottom:18px; transition: color 0.8s; }
        .otp-resend span { color:var(--accent-color); }

        /* PASSWORD TOGGLE */
        .pass-wrap { position:relative; }
        .pass-wrap input { padding-right:44px !important; }
        .pass-toggle {
            position:absolute; right:14px; top:50%;
            transform:translateY(-50%);
            cursor:pointer; color:var(--text-color); opacity:0.5; font-size:15px;
            background:none; border:none; padding:0;
            transition:color 0.2s, opacity 0.2s;
        }
        .pass-toggle:hover { color:var(--accent-color); opacity:1; }

        @media (max-width:700px) {
            .auth-page { grid-template-columns:1fr; }
            .auth-left { display:none; }
            .auth-right { padding:40px 24px; }
            .auth-row { grid-template-columns:1fr; }
        }
    </style>
</head>
<body>

<div class="auth-page">

    <!-- LEFT -->
    <div class="auth-left">
        <div class="auth-left-inner">
            <div class="auth-left-brand">
                <span class="auth-brand-logo">AW</span>
                <span class="auth-brand-name">AURAWEAR</span>
            </div>
            <h1 class="auth-left-headline">Define<br>Your<br>Aura.</h1>
            <p class="auth-left-sub">
                Join thousands who wear their identity.<br>
                Exclusive drops. Member perks. Your style.
            </p>
            <div class="auth-left-perks">
                <div class="auth-perk"><i class="fa-solid fa-bolt"></i> Early access to new drops</div>
                <div class="auth-perk"><i class="fa-solid fa-tag"></i> Member-only discounts</div>
                <div class="auth-perk"><i class="fa-solid fa-crown"></i> Premium collections</div>
            </div>
        </div>
    </div>

    <!-- RIGHT -->
    <div class="auth-right">
        <div class="auth-form-wrap">

            <div class="auth-top-link">
                Already have an account?
                <a href="${ctx}/home">Sign In</a>
            </div>

            <!-- STEPS -->
            <div class="auth-steps">
                <div class="auth-step ${not empty showOtp ? 'done' : 'active'}">
                    <div class="auth-step-circle">${not empty showOtp ? '✓' : '1'}</div>
                    <span>Account</span>
                </div>
                <div class="auth-step-line"></div>
                <div class="auth-step ${not empty showOtp ? 'active' : ''}">
                    <div class="auth-step-circle">2</div>
                    <span>Verify</span>
                </div>
                <div class="auth-step-line"></div>
                <div class="auth-step">
                    <div class="auth-step-circle">3</div>
                    <span>Profile</span>
                </div>
            </div>

            <!-- STEP 1 -->
            <div id="step1" ${not empty showOtp ? 'style="display:none"' : ''}>

                <h2 class="auth-heading">Create Account</h2>
                <p class="auth-sub">Join the AuraWear community</p>

                <c:if test="${not empty emailError}">
                    <div class="auth-error">${emailError}</div>
                </c:if>

                <form action="${ctx}/register" method="post">

                    <div class="auth-row">
                        <div class="auth-field">
                            <label>First Name</label>
                            <input type="text" name="firstName" placeholder="John" required>
                        </div>
                        <div class="auth-field">
                            <label>Last Name</label>
                            <input type="text" name="lastName" placeholder="Doe" required>
                        </div>
                    </div>

                    <div class="auth-field">
                        <label>Email Address</label>
                        <input type="email" name="email" placeholder="your@email.com" required>
                    </div>

                    <!-- PASSWORD -->
                    <div class="auth-field">
                        <label>Password</label>
                        <div class="pass-wrap">
                            <input type="password" name="password" id="password"
                                   placeholder="Min. 8 characters" required>
                            <button type="button" class="pass-toggle"
                                    onclick="togglePass('password', this)">
                                <i class="fa fa-eye"></i>
                            </button>
                        </div>
                    </div>

                    <!-- CONFIRM PASSWORD -->
                    <div class="auth-field">
                        <label>Confirm Password</label>
                        <div class="pass-wrap">
                            <input type="password" name="confirmPassword" id="confirmPassword"
                                   placeholder="Repeat password" required>
                            <button type="button" class="pass-toggle"
                                    onclick="togglePass('confirmPassword', this)">
                                <i class="fa fa-eye"></i>
                            </button>
                        </div>
                    </div>

                    <div class="auth-terms">
                        <input type="checkbox" id="terms" required>
                        <label for="terms" style="font-size:13px; text-transform:none; letter-spacing:0; color:#666;">
                            I agree to the <a href="#" style="color:#111; text-decoration:underline;">Terms &amp; Privacy Policy</a>
                        </label>
                    </div>

                    <div class="auth-error" id="passError" style="display:none;">
                        Passwords do not match!
                    </div>

                    <button type="submit" class="auth-btn" onclick="return checkPasswords()">
                        Create Account
                    </button>

                </form>

            </div>

            <!-- STEP 2: OTP -->
            <div id="step2" ${empty showOtp ? 'style="display:none"' : ''}>

                <h2 class="auth-heading">Verify Email</h2>
                <p class="auth-sub">Enter the 6-digit code sent to your email</p>

                <c:if test="${not empty otpError}">
                    <div class="auth-error">${otpError}</div>
                </c:if>

                <form action="${ctx}/otp-verify" method="post" id="otpForm">
                    <input type="hidden" name="otp" id="fullOtp">

                    <div class="otp-boxes">
                        <input maxlength="1" inputmode="numeric">
                        <input maxlength="1" inputmode="numeric">
                        <input maxlength="1" inputmode="numeric">
                        <input maxlength="1" inputmode="numeric">
                        <input maxlength="1" inputmode="numeric">
                        <input maxlength="1" inputmode="numeric">
                    </div>

                    <div class="otp-resend">
                        Resend code in <span id="timer">30</span>s
                    </div>

                    <button id="resendBtn" class="auth-btn auth-btn-outline" type="button"
                            onclick="window.location='${ctx}/register?resend=true'"
                            style="display:none; margin-bottom:12px;">
                        Resend Code
                    </button>

                    <button id="verifyBtn" class="auth-btn" type="submit" disabled>
                        Verify Email
                    </button>

                </form>

            </div>

        </div>
    </div>

</div>

<script>
// OTP navigation
const otpInputs = document.querySelectorAll('.otp-boxes input');
otpInputs.forEach((input, i) => {
    input.addEventListener('input', function () {
        if (this.value.length === 1 && i < otpInputs.length - 1)
            otpInputs[i + 1].focus();
        updateOtp();
    });
    input.addEventListener('keydown', function (e) {
        if (e.key === "Backspace" && !this.value && i > 0)
            otpInputs[i - 1].focus();
    });
});

function updateOtp() {
    let code = "";
    otpInputs.forEach(b => code += b.value);
    document.getElementById("fullOtp").value = code;
    document.getElementById("verifyBtn").disabled = code.length !== 6;
}

document.getElementById("otpForm")?.addEventListener("submit", updateOtp);

// Countdown
let seconds = 30;
const timerEl = document.getElementById("timer");
if (timerEl) {
    let countdown = setInterval(() => {
        seconds--;
        timerEl.innerText = seconds;
        if (seconds <= 0) {
            clearInterval(countdown);
            document.querySelector(".otp-resend").style.display = "none";
            document.getElementById("resendBtn").style.display = "block";
        }
    }, 1000);
}

// Password validation
function checkPasswords() {
    const pass    = document.getElementById("password").value;
    const confirm = document.getElementById("confirmPassword").value;
    const errEl   = document.getElementById("passError");

    if (pass.length < 8) {
        errEl.innerText = "Password must be at least 8 characters!";
        errEl.style.display = "block";
        return false;
    }

    if (pass !== confirm) {
        errEl.innerText = "Passwords do not match!";
        errEl.style.display = "block";
        document.getElementById("confirmPassword").style.borderColor = "#c00";
        return false;
    }

    errEl.style.display = "none";
    return true;
}

// Show/hide password
function togglePass(fieldId, btn) {
    const input = document.getElementById(fieldId);
    const icon  = btn.querySelector('i');
    if (input.type === "password") {
        input.type     = "text";
        icon.className = "fa fa-eye-slash";
    } else {
        input.type     = "password";
        icon.className = "fa fa-eye";
    }
}
</script>

</body>
</html>
