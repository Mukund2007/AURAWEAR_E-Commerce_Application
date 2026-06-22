package com.aurawear.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Set;
import java.util.UUID;
import java.util.logging.Logger;

/**
 * Synchronizer-token-pattern CSRF filter.
 *
 * <ul>
 *   <li>Ensures every session carries a {@code _csrf} token.</li>
 *   <li>Exposes the token as a request attribute so JSPs can render it in forms.</li>
 *   <li>Validates the token on state-changing (POST) requests, rejecting
 *       mismatches with HTTP 403.</li>
 *   <li>Skips validation for initial authentication endpoints where a token
 *       may not yet exist on the client side.</li>
 * </ul>
 */
@WebFilter("/*")
public class CsrfFilter implements Filter {

    private static final Logger logger = Logger.getLogger(CsrfFilter.class.getName());

    private static final String CSRF_ATTR = "_csrf";
    private static final String CSRF_HEADER = "X-CSRF-Token";

    /** Paths exempt from CSRF validation (initial form submissions). */
    private static final Set<String> EXEMPT_PATHS = Set.of(
            "/login",
            "/admin/login",
            "/register"
    );

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        logger.info("CsrfFilter initialized");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        if (!(request instanceof HttpServletRequest httpRequest)
                || !(response instanceof HttpServletResponse httpResponse)) {
            chain.doFilter(request, response);
            return;
        }

        // --- Ensure a CSRF token exists in the session ---
        HttpSession session = httpRequest.getSession(true);
        String token = (String) session.getAttribute(CSRF_ATTR);
        if (token == null || token.isBlank()) {
            token = UUID.randomUUID().toString();
            session.setAttribute(CSRF_ATTR, token);
            logger.fine(() -> "Generated new CSRF token for session " + session.getId());
        }

        // Always expose the token as a request attribute for JSP access.
        httpRequest.setAttribute(CSRF_ATTR, token);

        // --- Validate on POST (unless exempt) ---
        if ("POST".equalsIgnoreCase(httpRequest.getMethod())) {
            String path = httpRequest.getServletPath();
            if (!isExempt(path)) {
                String clientToken = httpRequest.getParameter(CSRF_ATTR);
                if (clientToken == null || clientToken.isBlank()) {
                    clientToken = httpRequest.getHeader(CSRF_HEADER);
                }

                if (!token.equals(clientToken)) {
                    logger.warning(() -> "CSRF validation failed for " + path);
                    httpResponse.setStatus(HttpServletResponse.SC_FORBIDDEN);
                    httpResponse.setContentType("text/plain");
                    httpResponse.getWriter().write("CSRF token validation failed");
                    return;
                }
            }
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        logger.info("CsrfFilter destroyed");
    }

    /**
     * Returns {@code true} if the given path is exempt from CSRF validation.
     * Comparison uses the context-relative servlet path.
     */
    private boolean isExempt(String path) {
        if (path == null) {
            return false;
        }
        return EXEMPT_PATHS.contains(path);
    }
}
