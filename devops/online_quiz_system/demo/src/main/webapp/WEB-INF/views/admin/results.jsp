<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="All Results"/>
</jsp:include>

<div class="page-wrapper">
    <div class="container">
        <!-- Page Header -->
        <div class="page-header">
            <h1><i class="bi bi-trophy me-2"></i>All Quiz Results</h1>
            <p>View results from all users across all quizzes</p>
        </div>

        <div class="content-card">
            <div class="card-header-custom">
                <span><i class="bi bi-bar-chart-line"></i>Results Overview</span>
                <span class="badge bg-light text-dark rounded-pill">${results.size()} Total</span>
            </div>
            <div class="card-body">
                <c:if test="${empty results}">
                    <div class="empty-state">
                        <i class="bi bi-emoji-neutral"></i>
                        <h5>No Results Yet</h5>
                        <p>No users have attempted any quizzes yet.</p>
                    </div>
                </c:if>

                <c:if test="${not empty results}">
                    <div class="table-responsive">
                        <table class="table table-custom mb-0">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>User</th>
                                    <th>Quiz</th>
                                    <th>Score</th>
                                    <th>Percentage</th>
                                    <th>Attempted At</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="result" items="${results}" varStatus="loop">
                                    <tr>
                                        <td><strong>${loop.index + 1}</strong></td>
                                        <td>
                                            <div class="d-flex align-items-center gap-2">
                                                <div class="stat-icon primary" style="width:32px; height:32px; font-size:.8rem; border-radius:50%;">
                                                    <i class="bi bi-person"></i>
                                                </div>
                                                <strong>${result.username}</strong>
                                            </div>
                                        </td>
                                        <td>${result.quizTitle}</td>
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
                                            <span class="text-muted">
                                                <i class="bi bi-clock me-1"></i>${result.attemptedAt}
                                            </span>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
