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
    <link rel="stylesheet" href="${ctx}/assets/css/auth-theme.css">
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
                        <label for="terms" class="auth-terms-label">
                            I agree to the <a href="#" class="auth-terms-link">Terms &amp; Privacy Policy</a>
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

                    <button id="resendBtn" class="auth-btn auth-btn-outline auth-btn-resend" type="button"
                            onclick="window.location='${ctx}/register?resend=true'"
                            style="display:none;">
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
