<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Dashboard"/>
</jsp:include>

<div class="page-wrapper">
    <div class="container">
        <!-- Page Header -->
        <div class="page-header">
            <h1><i class="bi bi-speedometer2 me-2"></i>Welcome, ${username}!</h1>
            <p>Choose a quiz to test your knowledge</p>
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

        <!-- Quick Stats -->
        <div class="row g-4 mb-4">
            <div class="col-md-4">
                <div class="stat-card primary">
                    <div class="d-flex align-items-center gap-3">
                        <div class="stat-icon primary">
                            <i class="bi bi-journal-text"></i>
                        </div>
                        <div>
                            <div class="stat-value">${quizzes.size()}</div>
                            <div class="stat-label">Available Quizzes</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-card success">
                    <div class="d-flex align-items-center gap-3">
                        <div class="stat-icon success">
                            <i class="bi bi-check2-all"></i>
                        </div>
                        <div>
                            <c:set var="completedCount" value="0"/>
                            <c:forEach var="entry" items="${attemptedMap}">
                                <c:if test="${entry.value}">
                                    <c:set var="completedCount" value="${completedCount + 1}"/>
                                </c:if>
                            </c:forEach>
                            <div class="stat-value">${completedCount}</div>
                            <div class="stat-label">Completed</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-card warning">
                    <div class="d-flex align-items-center gap-3">
                        <div class="stat-icon warning">
                            <i class="bi bi-hourglass-split"></i>
                        </div>
                        <div>
                            <div class="stat-value">${quizzes.size() - completedCount}</div>
                            <div class="stat-label">Remaining</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Available Quizzes -->
        <div class="page-header">
            <h1 style="font-size:1.4rem;"><i class="bi bi-collection me-2"></i>Available Quizzes</h1>
        </div>

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
                        </div>
                        <div class="quiz-actions">
                            <c:choose>
                                <c:when test="${attemptedMap[quiz.id]}">
                                    <button class="btn btn-sm btn-outline-custom" disabled style="opacity:.6;">
                                        <i class="bi bi-check-circle me-1"></i>Already Completed
                                    </button>
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
