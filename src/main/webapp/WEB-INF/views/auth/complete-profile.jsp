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
    
    <style>
        :root {
            --bg-color: #f0e9e2;
            --text-color: #0d0d0d;
            --border-color: rgba(13, 13, 13, 0.12);
            --border-color-solid: #0d0d0d;
            --accent-color: #ff0001;
            --card-bg: rgba(25, 25, 25, 0.05);
            --navbar-bg: rgba(240, 233, 226, 0.82);
            --input-bg: #ffffff;
        }

        html.theme-noir {
            --bg-color: #0d0d0d;
            --text-color: #ede4dd;
            --border-color: rgba(237, 228, 221, 0.15);
            --border-color-solid: #ede4dd;
            --accent-color: #ff0001;
            --card-bg: rgba(255, 255, 255, 0.05);
            --navbar-bg: rgba(13, 13, 13, 0.85);
            --input-bg: #1a1a1a;
        }

        html.theme-red {
            --bg-color: #ff0001;
            --text-color: #0d0d0d;
            --border-color: rgba(13, 13, 13, 0.25);
            --border-color-solid: #0d0d0d;
            --accent-color: #ede4dd;
            --card-bg: rgba(255, 255, 255, 0.2);
            --navbar-bg: rgba(255, 0, 1, 0.85);
            --input-bg: rgba(255, 255, 255, 0.4);
        }

        *, *::before, *::after { margin:0; padding:0; box-sizing:border-box; }
        
        html {
            background-color: var(--bg-color) !important;
            color: var(--text-color) !important;
            transition: background-color 0.8s cubic-bezier(0.76, 0, 0.24, 1), color 0.8s cubic-bezier(0.76, 0, 0.24, 1);
        }

        body.auth-body { font-family:'Outfit', 'DM Sans', Arial, sans-serif; background:transparent; color:var(--text-color); transition: color 0.8s; }
        .auth-page { min-height:100vh; display:grid !important; grid-template-columns:1fr 1fr; }
        
        .auth-left {
            background:var(--border-color-solid) !important; color:var(--bg-color); display:flex !important;
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
        .auth-left-brand { display:flex !important; align-items:center; gap:12px; margin-bottom:60px; }
        .auth-brand-logo {
            width:40px; height:40px; background:var(--bg-color); color:var(--text-color); font-size:13px;
            font-weight:900; border: 1.5px solid var(--border-color-solid); border-radius:0px; display:inline-flex !important;
            align-items:center; justify-content:center; flex-shrink:0;
            transition: all 0.8s;
        }
        .auth-brand-name { font-size:16px; font-weight:900; letter-spacing:4px; color:var(--bg-color); text-transform:uppercase; transition: color 0.8s; }
        .auth-left-headline { font-size:68px; font-weight:900; line-height:0.95; letter-spacing:-3px; margin-bottom:24px; text-transform:uppercase; }
        .auth-left-sub { font-size:14px; color:var(--bg-color); opacity:0.65; line-height:1.7; margin-bottom:48px; font-weight:700; text-transform:uppercase; transition: color 0.8s; }
        .auth-left-perks { display:flex !important; flex-direction:column; gap:14px; }
        .auth-perk { display:flex !important; align-items:center; gap:12px; font-size:13px; color:var(--bg-color); opacity:0.85; font-weight:800; text-transform:uppercase; transition: color 0.8s; }
        .auth-perk i {
            width:32px; height:32px; background:var(--accent-color); color:var(--bg-color);
            border: 1.5px solid var(--border-color-solid); border-radius:0px; display:inline-flex !important;
            align-items:center; justify-content:center; font-size:13px; flex-shrink:0;
            box-shadow: 2px 2px 0px var(--bg-color);
            transition: all 0.8s;
        }
        .auth-right {
            background:var(--bg-color); display:flex !important; align-items:center;
            justify-content:center; padding:60px 40px; overflow-y:auto;
            transition: background 0.8s;
        }
        .auth-form-wrap { width:100%; max-width:420px; }
        .auth-steps { display:flex !important; align-items:center; margin-bottom:36px; }
        .auth-step { display:flex !important; flex-direction:column; align-items:center; gap:6px; }
        .auth-step span { font-size:10px; letter-spacing:0.5px; text-transform:uppercase; color:var(--text-color); opacity:0.5; font-weight:800; transition: color 0.8s; }
        .auth-step.active span, .auth-step.done span { color:var(--text-color); opacity:1; }
        .auth-step-circle {
            width:34px; height:34px; border-radius:0px; border:1.5px solid var(--border-color-solid);
            background:var(--card-bg); color:var(--text-color); font-size:12px; font-weight:900;
            display:flex !important; align-items:center; justify-content:center;
            transition: all 0.8s;
        }
        .auth-step.active .auth-step-circle, .auth-step.done .auth-step-circle {
            background:var(--accent-color); color:var(--bg-color); border-color:var(--accent-color); box-shadow: 3px 3px 0px var(--border-color-solid);
        }
        .auth-step-line { flex:1; height:1.5px; background:var(--border-color-solid); margin:0 8px 20px; transition: background 0.8s; }
        .auth-heading { font-size:32px; font-weight:900; letter-spacing:-1.5px; margin-bottom:6px; text-transform:uppercase; line-height:0.95; color:var(--text-color); transition: color 0.8s; }
        .auth-sub { font-size:12px; color:var(--text-color); opacity:0.6; font-weight:800; text-transform:uppercase; margin-bottom:28px; transition: color 0.8s; }
        .auth-error { background:var(--card-bg); border:1.5px solid var(--accent-color); color:var(--accent-color); font-size:11px; font-weight:800; text-transform:uppercase; padding:12px 14px; border-radius:0px; margin-bottom:16px; box-shadow: 4px 4px 0px var(--border-color-solid); transition: all 0.8s; }
        .auth-row { display:grid !important; grid-template-columns:1fr 1fr; gap:14px; }
        .auth-field { margin-bottom:16px; display:flex !important; flex-direction:column; gap:7px; }
        .auth-field label { font-size:11px; font-weight:800; letter-spacing:1px; text-transform:uppercase; color:var(--text-color); transition: color 0.8s; }
        .auth-field input, .auth-field select {
            width:100%; padding:13px 16px; font-size:14px; border:1.5px solid var(--border-color-solid);
            border-radius:0px; background:var(--input-bg); color:var(--text-color); font-family:inherit; font-weight:700;
            outline:none; -webkit-appearance:none; appearance:none;
            transition: background 0.8s, border-color 0.8s, color 0.8s;
        }
        .auth-field input:focus, .auth-field select:focus { border-color:var(--accent-color); background:var(--input-bg); box-shadow:4px 4px 0px var(--border-color-solid); }
        .auth-field input::placeholder { color:var(--text-color); opacity:0.4; }
        .interests-label { font-size:11px; font-weight:800; letter-spacing:1px; text-transform:uppercase; color:var(--text-color); margin-bottom:10px; display:block; transition: color 0.8s; }
        .interests-grid { display:grid !important; grid-template-columns:1fr 1fr; gap:8px; margin-bottom:20px; }
        .interest-chip { display:flex !important; align-items:center; gap:8px; padding:10px 14px; border:1.5px solid var(--border-color-solid); border-radius:0px; cursor:pointer; font-size:13px; font-weight:800; color:var(--text-color); background:var(--input-bg); transition:all 0.2s, background 0.8s, border-color 0.8s, color 0.8s; user-select:none; text-transform:uppercase; }
        .interest-chip input[type="checkbox"] { display:none; }
        .interest-chip.checked { border-color:var(--accent-color); background:var(--accent-color); color:var(--bg-color); box-shadow: 3px 3px 0px var(--border-color-solid); }
        .auth-btn {
            width:100%; padding:15px; background:var(--border-color-solid); color:var(--bg-color); border:1.5px solid var(--border-color-solid);
            border-radius:0px; font-size:12px; font-weight:900; letter-spacing:1.5px;
            text-transform:uppercase; cursor:pointer; font-family:inherit; margin-top:8px; transition: all 0.25s ease;
        }
        .auth-btn:hover { background:var(--accent-color); border-color:var(--accent-color); color:var(--bg-color); transform: translate(-4px, -4px); box-shadow: 4px 4px 0px var(--border-color-solid); }
        @media (max-width:700px) {
            .auth-page { grid-template-columns:1fr !important; }
            .auth-left { display:none !important; }
            .auth-right { padding:40px 24px; }
            .auth-row { grid-template-columns:1fr !important; }
            .interests-grid { grid-template-columns:1fr !important; }
        }
    </style>
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
