document.addEventListener("DOMContentLoaded", () => {
    init3DTilt();
    initDragToCart();
});

function init3DTilt() {
    const cards = document.querySelectorAll('.product-card');
    cards.forEach(card => {
        card.style.transformStyle = 'preserve-3d';
        
        card.addEventListener('mousemove', e => {
            // If card is dragging, don't apply tilt
            if (card.classList.contains('dragging')) return;
            
            const rect = card.getBoundingClientRect();
            const x = e.clientX - rect.left;
            const y = e.clientY - rect.top;
            const w = rect.width;
            const h = rect.height;
            
            const dx = (x / w) - 0.5;
            const dy = (y / h) - 0.5;
            
            const rx = -dy * 15; // Rotates around X axis
            const ry = dx * 15;  // Rotates around Y axis
            
            card.style.transition = 'transform 0.05s ease, box-shadow 0.05s ease';
            card.style.transform = `perspective(1000px) rotateX(${rx}deg) rotateY(${ry}deg) scale3d(1.02, 1.02, 1.02)`;
        });
        
        card.addEventListener('mouseleave', () => {
            if (card.classList.contains('dragging')) return;
            card.style.transition = 'transform 0.5s cubic-bezier(0.2, 0.8, 0.2, 1), box-shadow 0.3s ease';
            card.style.transform = 'perspective(1000px) rotateX(0deg) rotateY(0deg) scale3d(1, 1, 1)';
        });
    });
}

function initDragToCart() {
    const cards = document.querySelectorAll('.product-card');
    const cartLink = document.querySelector('.cart-link');
    
    if (!cartLink) return;
    
    cards.forEach(card => {
        let isDragging = false;
        let startX = 0;
        let startY = 0;
        let currentX = 0;
        let currentY = 0;
        
        // Prevent browser default image dragging inside card
        const img = card.querySelector('img');
        if (img) {
            img.addEventListener('dragstart', e => e.preventDefault());
        }
        
        card.addEventListener('mousedown', e => {
            // Check if clicking interactive element or card is out of stock
            if (card.classList.contains('oos-card')) {
                return;
            }
            if (e.target.closest('.wish') || 
                e.target.closest('.wishlist') || 
                e.target.closest('.quick-add') || 
                e.target.closest('button') || 
                e.target.closest('a')) {
                return;
            }
            
            e.preventDefault(); // Prevent text selection/highlighting
            
            startX = e.clientX;
            startY = e.clientY;
            isDragging = false;
            
            window.addEventListener('mousemove', handleMouseMove);
            window.addEventListener('mouseup', handleMouseUp);
        });
        
        function handleMouseMove(e) {
            const dx = e.clientX - startX;
            const dy = e.clientY - startY;
            
            if (!isDragging && Math.hypot(dx, dy) > 8) {
                isDragging = true;
                card.classList.add('dragging');
                card.style.zIndex = '99999';
                card.style.cursor = 'grabbing';
            }
            
            if (isDragging) {
                currentX = dx;
                currentY = dy;
                
                // Track with mouse + slight tilt while dragging
                card.style.transition = 'none';
                card.style.transform = `translate3d(${dx}px, ${dy}px, 150px) rotate(${dx * 0.04}deg) scale(1.04)`;
                card.style.boxShadow = '0 25px 50px rgba(0, 0, 0, 0.25)';
                
                // Check proximity to Cart
                const cartRect = cartLink.getBoundingClientRect();
                const cardRect = card.getBoundingClientRect();
                
                const cardCenterX = cardRect.left + cardRect.width / 2;
                const cardCenterY = cardRect.top + cardRect.height / 2;
                const cartCenterX = cartRect.left + cartRect.width / 2;
                const cartCenterY = cartRect.top + cartRect.height / 2;
                
                const dist = Math.hypot(cardCenterX - cartCenterX, cardCenterY - cartCenterY);
                
                if (dist < 150) {
                    cartLink.classList.add('cart-near-active');
                } else {
                    cartLink.classList.remove('cart-near-active');
                }
            }
        }
        
        function handleMouseUp(e) {
            window.removeEventListener('mousemove', handleMouseMove);
            window.removeEventListener('mouseup', handleMouseUp);
            
            if (isDragging) {
                card.classList.remove('dragging');
                
                // Prevent final click event
                const clickHandler = ev => {
                    ev.preventDefault();
                    ev.stopPropagation();
                    card.removeEventListener('click', clickHandler, true);
                };
                card.addEventListener('click', clickHandler, true);
                // Also prevent click event with short delay just in case
                setTimeout(() => card.removeEventListener('click', clickHandler, true), 50);
                
                // Check proximity to Cart for Drop
                const cartRect = cartLink.getBoundingClientRect();
                const cardRect = card.getBoundingClientRect();
                
                const cardCenterX = cardRect.left + cardRect.width / 2;
                const cardCenterY = cardRect.top + cardRect.height / 2;
                const cartCenterX = cartRect.left + cartRect.width / 2;
                const cartCenterY = cartRect.top + cartRect.height / 2;
                
                const dist = Math.hypot(cardCenterX - cartCenterX, cardCenterY - cartCenterY);
                
                if (dist < 150) {
                    // SUCCESS: Fly to cart!
                    cartLink.classList.remove('cart-near-active');
                    cartLink.classList.add('cart-success-flash');
                    
                    const flyX = cartCenterX - cardCenterX;
                    const flyY = cartCenterY - cardCenterY;
                    
                    card.style.transition = 'transform 0.6s cubic-bezier(0.2, 0.8, 0.2, 1), opacity 0.5s ease-out';
                    card.style.transform = `translate3d(${currentX + flyX}px, ${currentY + flyY}px, 0) scale(0.02) rotate(360deg)`;
                    card.style.opacity = '0';
                    
                    // Fetch product details
                    const pId = card.getAttribute('data-id');
                    const pName = card.getAttribute('data-name');
                    const pPrice = card.getAttribute('data-price') || '999';
                    const pSize = card.getAttribute('data-size') || 'M';
                    
                    triggerDragAddToCart(pId, pSize, pPrice, pName);
                    
                    setTimeout(() => {
                        card.style.transition = '';
                        card.style.transform = '';
                        card.style.opacity = '';
                        card.style.zIndex = '';
                        card.style.boxShadow = '';
                        card.style.cursor = '';
                        cartLink.classList.remove('cart-success-flash');
                    }, 700);
                } else {
                    // FAIL: Snap back elastically
                    card.style.transition = 'transform 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275), box-shadow 0.3s ease';
                    card.style.transform = 'perspective(1000px) rotateX(0deg) rotateY(0deg) scale3d(1, 1, 1)';
                    card.style.zIndex = '';
                    card.style.boxShadow = '';
                    card.style.cursor = '';
                    cartLink.classList.remove('cart-near-active');
                }
            }
        }
    });
}

function triggerDragAddToCart(id, size, price, name) {
    const contextPath = window.ctx || '';
    fetch(contextPath + "/add-to-cart", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            "X-CSRF-Token": window._csrf
        },
        body: "id=" + encodeURIComponent(id) + "&size=" + encodeURIComponent(size) + "&price=" + encodeURIComponent(price),
        credentials: "include"
    })
        .then(res => {
            if (res.status === 401) {
                // If not logged in, redirect to login page
                window.location.href = contextPath + "/login";
                return;
            }
            if (!res.ok) throw new Error("Failed to add to cart");
            return res.json();
        })
        .then(data => {
            if (!data) return;
            if (data.success) {
                // Show toast message if showToast function is available
                if (typeof window.showToast === 'function') {
                    window.showToast(name + " added to cart!");
                } else {
                    alert(name + " added to cart!");
                }
                // Update cart count
                if (typeof window.updateCartCount === 'function') {
                    window.updateCartCount();
                }
            } else {
                if (typeof window.showToast === 'function') {
                    window.showToast(data.message || "This item is out of stock");
                } else {
                    alert(data.message || "This item is out of stock");
                }
            }
        })
        .catch(err => {
            console.error("Error adding to cart:", err);
            if (typeof window.showToast === 'function') {
                window.showToast("Could not add to cart. Try again.");
            }
        });
}
