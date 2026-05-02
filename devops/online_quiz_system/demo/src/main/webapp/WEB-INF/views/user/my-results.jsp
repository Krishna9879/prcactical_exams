<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="My Results"/>
</jsp:include>

<div class="page-wrapper">
    <div class="container">
        <!-- Page Header -->
        <div class="page-header">
            <h1><i class="bi bi-bar-chart-line me-2"></i>My Results</h1>
            <p>View your quiz performance and scores</p>
        </div>

        <!-- Flash Messages -->
        <c:if test="${not empty success}">
            <div class="alert alert-custom alert-success" role="alert">
                <i class="bi bi-check-circle-fill"></i>
                <span>${success}</span>
            </div>
        </c:if>

        <div class="content-card">
            <div class="card-header-custom">
                <span><i class="bi bi-trophy"></i>Your Quiz Results</span>
                <span class="badge bg-light text-dark rounded-pill">${results.size()} Attempts</span>
            </div>
            <div class="card-body">
                <c:if test="${empty results}">
                    <div class="empty-state">
                        <i class="bi bi-emoji-neutral"></i>
                        <h5>No Results Yet</h5>
                        <p>You haven't attempted any quizzes yet. Go take a quiz!</p>
                        <a href="${pageContext.request.contextPath}/user/quizzes" class="btn btn-primary-custom mt-3" style="width:auto;">
                            <i class="bi bi-play-circle me-2"></i>Browse Quizzes
                        </a>
                    </div>
                </c:if>

                <c:if test="${not empty results}">
                    <!-- Results Cards for Mobile -->
                    <div class="d-md-none">
                        <c:forEach var="result" items="${results}" varStatus="loop">
                            <div class="question-card" style="padding: 1.25rem; animation-delay: ${loop.index * 0.05}s;">
                                <h6 class="fw-bold mb-2">${result.quizTitle}</h6>
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <span class="text-muted">Score</span>
                                    <strong>${result.score} / ${result.totalQuestions}</strong>
                                </div>
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <span class="text-muted">Percentage</span>
                                    <c:choose>
                                        <c:when test="${result.percentage >= 70}">
                                            <span class="badge-score high">${result.percentage}%</span>
                                        </c:when>
                                        <c:when test="${result.percentage >= 40}">
                                            <span class="badge-score mid">${result.percentage}%</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge-score low">${result.percentage}%</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="d-flex justify-content-between align-items-center">
                                    <span class="text-muted">Date</span>
                                    <span class="text-muted small">${result.attemptedAt}</span>
                                </div>
                                <!-- Score Progress Bar -->
                                <div class="progress mt-3" style="height: 8px; border-radius: 4px;">
                                    <div class="progress-bar
                                        <c:choose>
                                            <c:when test='${result.percentage >= 70}'>bg-success</c:when>
                                            <c:when test='${result.percentage >= 40}'>bg-warning</c:when>
                                            <c:otherwise>bg-danger</c:otherwise>
                                        </c:choose>"
                                         role="progressbar"
                                         style="width: ${result.percentage}%; border-radius: 4px;"
                                         aria-valuenow="${result.percentage}" aria-valuemin="0" aria-valuemax="100">
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- Results Table for Desktop -->
                    <div class="d-none d-md-block">
                        <div class="table-responsive">
                            <table class="table table-custom mb-0">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Quiz</th>
                                        <th>Score</th>
                                        <th>Percentage</th>
                                        <th>Status</th>
                                        <th>Attempted At</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="result" items="${results}" varStatus="loop">
                                        <tr>
                                            <td><strong>${loop.index + 1}</strong></td>
                                            <td><strong class="text-dark">${result.quizTitle}</strong></td>
                                            <td>
                                                <strong>${result.score}</strong> / ${result.totalQuestions}
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${result.percentage >= 70}">
                                                        <span class="badge-score high">${result.percentage}%</span>
                                                    </c:when>
                                                    <c:when test="${result.percentage >= 40}">
                                                        <span class="badge-score mid">${result.percentage}%</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge-score low">${result.percentage}%</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${result.percentage >= 70}">
                                                        <span class="text-success fw-bold">
                                                            <i class="bi bi-emoji-smile me-1"></i>Passed
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${result.percentage >= 40}">
                                                        <span class="text-warning fw-bold">
                                                            <i class="bi bi-emoji-neutral me-1"></i>Average
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-danger fw-bold">
                                                            <i class="bi bi-emoji-frown me-1"></i>Failed
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <span class="text-muted">
                                                    <i class="bi bi-clock me-1"></i>${result.attemptedAt}
                                                </span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
