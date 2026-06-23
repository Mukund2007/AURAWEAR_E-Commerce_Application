package com.aurawear.filter;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebFilter;

@WebFilter({
    "/cart", "/wishlist", "/profile", "/my-orders", "/orders",
    "/add-to-cart", "/remove-from-cart", "/update-cart",
    "/wishlist-toggle", "/wishlist-remove", "/review",
    "/checkout", "/checkout/cod", "/update-order-status",
    "/cart-count"
})
public class LoginFilter implements Filter {

    public void doFilter(
            ServletRequest request,
            ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);

        // ❌ Not logged in
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // ✅ Logged in → continue
        chain.doFilter(request, response);
    }
}