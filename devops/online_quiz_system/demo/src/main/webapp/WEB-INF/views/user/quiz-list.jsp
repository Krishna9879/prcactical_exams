<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Browse Quizzes"/>
</jsp:include>

<div class="page-wrapper">
    <div class="container">
        <!-- Page Header -->
        <div class="page-header">
            <h1><i class="bi bi-journal-text me-2"></i>Browse Quizzes</h1>
            <p>Select a quiz to test your knowledge</p>
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

        <c:if test="${empty quizzes}">
            <div class="content-card">
                <div class="card-body">
                    <div class="empty-state">
                        <i class="bi bi-journal-x"></i>
                        <h5>No Quizzes Available</h5>
                        <p>Check back later for new quizzes!</p>
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
                            <span><i class="bi bi-clock"></i>${quiz.questions.size() * 30}s</span>
                            <c:if test="${quiz.createdAt != null}">
                                <span><i class="bi bi-calendar3"></i>${quiz.createdAt.toLocalDate()}</span>
                            </c:if>
                        </div>
                        <div class="quiz-actions">
                            <c:choose>
                                <c:when test="${attemptedMap[quiz.id]}">
                                    <span class="badge-score high">
                                        <i class="bi bi-check-circle me-1"></i>Completed
                                    </span>
                                </c:when>
                                <c:when test="${quiz.questions.size() == 0}">
                                    <button class="btn btn-sm btn-outline-custom" disabled style="opacity:.6;">
                                        <i class="bi bi-exclamation-circle me-1"></i>No Questions
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/user/quizzes/${quiz.id}/take"
                                       class="btn btn-sm btn-primary-custom" style="width:auto;">
                                        <i class="bi bi-play-circle me-1"></i>Start Quiz
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
