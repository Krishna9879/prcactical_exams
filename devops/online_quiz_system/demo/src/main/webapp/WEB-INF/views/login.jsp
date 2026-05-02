<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | Online Quiz System</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>
<div class="auth-wrapper">
    <div class="auth-card">
        <!-- Logo / Header -->
        <div class="auth-logo">
            <i class="bi bi-mortarboard-fill"></i>
            <h2>Welcome Back</h2>
            <p>Sign in to your QuizMaster account</p>
        </div>

        <!-- Success Message (e.g., after registration) -->
        <c:if test="${not empty success}">
            <div class="alert alert-custom alert-success" role="alert">
                <i class="bi bi-check-circle-fill"></i>
                <span>${success}</span>
            </div>
        </c:if>

        <!-- Error Messages -->
        <c:if test="${param.error != null}">
            <div class="alert alert-custom alert-danger" role="alert">
                <i class="bi bi-exclamation-triangle-fill"></i>
                <span>Invalid username or password. Please try again.</span>
            </div>
        </c:if>

        <c:if test="${param.logout != null}">
            <div class="alert alert-custom alert-info" role="alert">
                <i class="bi bi-info-circle-fill"></i>
                <span>You have been logged out successfully.</span>
            </div>
        </c:if>

        <c:if test="${param.accessDenied != null}">
            <div class="alert alert-custom alert-warning" role="alert">
                <i class="bi bi-shield-exclamation"></i>
                <span>Access denied. Please login with appropriate credentials.</span>
            </div>
        </c:if>

        <!-- Login Form -->
        <form action="${pageContext.request.contextPath}/login" method="post" id="loginForm">
            <div class="form-floating mb-3">
                <input type="text" class="form-control" id="username" name="username"
                       placeholder="Username" required autofocus>
                <label for="username"><i class="bi bi-person me-1"></i>Username</label>
            </div>

            <div class="form-floating mb-4">
                <input type="password" class="form-control" id="password" name="password"
                       placeholder="Password" required>
                <label for="password"><i class="bi bi-lock me-1"></i>Password</label>
            </div>

            <button type="submit" class="btn btn-primary-custom mb-3">
                <i class="bi bi-box-arrow-in-right me-2"></i>Sign In
            </button>

            <!-- CSRF Token -->
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        </form>

        <div class="text-center mt-3">
            <span class="text-muted">Don't have an account?</span>
            <a href="${pageContext.request.contextPath}/register" class="fw-bold" style="color: var(--primary);">
                Create Account <i class="bi bi-arrow-right"></i>
            </a>
        </div>

        <!-- Demo Credentials -->
        <div class="mt-4 p-3 rounded-3" style="background: var(--gray-100); font-size: .85rem;">
            <p class="mb-1 fw-bold text-muted"><i class="bi bi-info-circle me-1"></i>Demo Credentials:</p>
            <p class="mb-0 text-muted">Admin: <code>admin / admin123</code></p>
            <p class="mb-0 text-muted">User: <code>user / user123</code></p>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
