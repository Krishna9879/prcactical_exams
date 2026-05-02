<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Manage Quizzes"/>
</jsp:include>

<div class="page-wrapper">
    <div class="container">
        <!-- Page Header -->
        <div class="page-header d-flex justify-content-between align-items-center flex-wrap gap-3">
            <div>
                <h1><i class="bi bi-journal-text me-2"></i>Manage Quizzes</h1>
                <p>Create, edit, and manage your quizzes</p>
            </div>
            <a href="${pageContext.request.contextPath}/admin/quizzes/new" class="btn btn-primary-custom" style="width:auto;">
                <i class="bi bi-plus-circle me-2"></i>Create New Quiz
            </a>
        </div>

        <!-- Flash Messages -->
        <c:if test="${not empty success}">
            <div class="alert alert-custom alert-success" role="alert">
                <i class="bi bi-check-circle-fill"></i>
                <span>${success}</span>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-custom alert-danger" role="alert">
                <i class="bi bi-exclamation-triangle-fill"></i>
                <span>${error}</span>
            </div>
        </c:if>

        <!-- Quiz Cards Grid -->
        <c:if test="${empty quizzes}">
            <div class="content-card">
                <div class="card-body">
                    <div class="empty-state">
                        <i class="bi bi-journal-x"></i>
                        <h5>No Quizzes Found</h5>
                        <p>Start by creating your first quiz. Click the button above to get started!</p>
                    </div>
                </div>
            </div>
        </c:if>

        <div class="row g-4">
            <c:forEach var="quiz" items="${quizzes}">
                <div class="col-md-6 col-lg-4">
                    <div class="quiz-card" style="animation: fadeUp .4s ease backwards;">
                        <h5 class="quiz-title">${quiz.title}</h5>
                        <p class="quiz-desc">${quiz.description}</p>
                        <div class="quiz-meta">
                            <span><i class="bi bi-question-circle"></i>${quiz.questions.size()} Questions</span>
                            <c:if test="${quiz.createdAt != null}">
                                <span><i class="bi bi-calendar3"></i>${quiz.createdAt.toLocalDate()}</span>
                            </c:if>
                        </div>
                        <div class="quiz-actions">
                            <a href="${pageContext.request.contextPath}/admin/quizzes/${quiz.id}/questions/new"
                               class="btn btn-sm btn-success-custom">
                                <i class="bi bi-plus me-1"></i>Questions
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/quizzes/${quiz.id}/edit"
                               class="btn btn-sm btn-outline-custom">
                                <i class="bi bi-pencil me-1"></i>Edit
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/quizzes/${quiz.id}/delete"
                               class="btn btn-sm btn-danger-custom"
                               onclick="return confirm('Delete this quiz and all its questions?')">
                                <i class="bi bi-trash me-1"></i>Delete
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
