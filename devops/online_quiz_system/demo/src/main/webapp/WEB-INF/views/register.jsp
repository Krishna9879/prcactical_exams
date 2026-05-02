<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register | Online Quiz System</title>
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
            <h2>Create Account</h2>
            <p>Join QuizMaster and start learning</p>
        </div>

        <!-- Error Messages -->
        <c:if test="${not empty error}">
            <div class="alert alert-custom alert-danger" role="alert">
                <i class="bi bi-exclamation-triangle-fill"></i>
                <span>${error}</span>
            </div>
        </c:if>

        <!-- Registration Form -->
        <form action="${pageContext.request.contextPath}/register" method="post" id="registerForm">
            <div class="form-floating mb-3">
                <input type="text" class="form-control" id="username" name="username"
                       placeholder="Username" value="${registerDTO.username}" required autofocus
                       minlength="3" maxlength="50">
                <label for="username"><i class="bi bi-person me-1"></i>Username</label>
            </div>

            <div class="form-floating mb-3">
                <input type="password" class="form-control" id="password" name="password"
                       placeholder="Password" required minlength="4">
                <label for="password"><i class="bi bi-lock me-1"></i>Password</label>
            </div>


            <div class="form-floating mb-4">
                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword"
                       placeholder="Confirm Password" required>
                <label for="confirmPassword"><i class="bi bi-lock-fill me-1"></i>Confirm Password</label>
            </div>

            <button type="submit" class="btn btn-primary-custom mb-3">
                <i class="bi bi-person-plus me-2"></i>Create Account
            </button>

            <!-- CSRF Token -->
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        </form>

        <div class="text-center mt-3">
            <span class="text-muted">Already have an account?</span>
            <a href="${pageContext.request.contextPath}/login" class="fw-bold" style="color: var(--primary);">
                Sign In <i class="bi bi-arrow-right"></i>
            </a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Client-side password match validation
    document.getElementById('registerForm').addEventListener('submit', function(e) {
        var pw = document.getElementById('password').value;
        var cpw = document.getElementById('confirmPassword').value;
        if (pw !== cpw) {
            e.preventDefault();
            alert('Passwords do not match!');
        }
    });
</script>
</body>
</html>
