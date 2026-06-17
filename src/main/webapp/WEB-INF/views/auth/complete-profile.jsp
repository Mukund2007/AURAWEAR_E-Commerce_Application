<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Complete Profile — AuraWear</title>
    
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
<body class="auth-body">

<div class="auth-page">

    <!-- LEFT PANEL -->
    <div class="auth-left">
        <div class="auth-left-inner">
            <div class="auth-left-brand">
                <span class="auth-brand-logo">AW</span>
                <span class="auth-brand-name">AURAWEAR</span>
            </div>
            <h1 class="auth-left-headline">Almost<br>There.</h1>
            <p class="auth-left-sub">
                Tell us your style.<br>
                We'll curate your experience.<br>
                Personalized drops await.
            </p>
            <div class="auth-left-perks">
                <div class="auth-perk"><i class="fa-solid fa-wand-magic-sparkles"></i> Personalized recommendations</div>
                <div class="auth-perk"><i class="fa-solid fa-bolt"></i> Early access to drops</div>
                <div class="auth-perk"><i class="fa-solid fa-crown"></i> Member-only perks</div>
            </div>
        </div>
    </div>

    <!-- RIGHT PANEL -->
    <div class="auth-right">
        <div class="auth-form-wrap">

            <!-- STEP INDICATOR -->
            <div class="auth-steps">
                <div class="auth-step done">
                    <div class="auth-step-circle">✓</div>
                    <span>Account</span>
                </div>
                <div class="auth-step-line"></div>
                <div class="auth-step done">
                    <div class="auth-step-circle">✓</div>
                    <span>Verify</span>
                </div>
                <div class="auth-step-line"></div>
                <div class="auth-step active">
                    <div class="auth-step-circle">3</div>
                    <span>Profile</span>
                </div>
            </div>

            <h2 class="auth-heading">Complete Profile</h2>
            <p class="auth-sub">Personalize your AuraWear experience</p>

            <c:if test="${not empty profileError}">
                <div class="auth-error">${profileError}</div>
            </c:if>

            <form action="${ctx}/complete-profile" method="post">

                <div class="auth-field">
                    <label>Username</label>
                    <input type="text" name="username" placeholder="@yourhandle" required>
                </div>

                <div class="auth-row">
                    <div class="auth-field">
                        <label>Style</label>
                        <select name="style">
                            <option value="Minimal">Minimal</option>
                            <option value="Streetwear">Streetwear</option>
                            <option value="Luxury">Luxury</option>
                            <option value="Techwear">Techwear</option>
                        </select>
                    </div>
                    <div class="auth-field">
                        <label>Default Size</label>
                        <select name="size">
                            <option value="S">S</option>
                            <option value="M">M</option>
                            <option value="L">L</option>
                            <option value="XL">XL</option>
                        </select>
                    </div>
                </div>

                <div class="auth-field">
                    <label>Fit Preference</label>
                    <select name="fit">
                        <option value="Slim">Slim Fit</option>
                        <option value="Regular">Regular Fit</option>
                        <option value="Oversized">Oversized</option>
                    </select>
                </div>

                <span class="interests-label">Interests</span>
                <div class="interests-grid">
                    <label class="interest-chip" onclick="toggleChip(this)">
                        <input type="checkbox" name="interests" value="Drops">
                        <i class="fa-solid fa-fire"></i> New Drops
                    </label>
                    <label class="interest-chip" onclick="toggleChip(this)">
                        <input type="checkbox" name="interests" value="Sneakers">
                        <i class="fa-solid fa-shoe-prints"></i> Sneakers
                    </label>
                    <label class="interest-chip" onclick="toggleChip(this)">
                        <input type="checkbox" name="interests" value="Exclusive">
                        <i class="fa-solid fa-crown"></i> Exclusives
                    </label>
                    <label class="interest-chip" onclick="toggleChip(this)">
                        <input type="checkbox" name="interests" value="Streetwear">
                        <i class="fa-solid fa-shirt"></i> Streetwear
                    </label>
                </div>

                <button type="submit" class="auth-btn">
                    Finish Setup <i class="fa-solid fa-arrow-right"></i>
                </button>

            </form>

        </div>
    </div>

</div>

<script>
function toggleChip(label) {
    const checkbox = label.querySelector('input[type="checkbox"]');
    checkbox.checked = !checkbox.checked;
    label.classList.toggle('checked', checkbox.checked);
}
</script>

</body>
</html>
