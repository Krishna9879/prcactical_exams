<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Admin Dashboard"/>
</jsp:include>

<div class="page-wrapper">
    <div class="container">
        <!-- Page Header -->
        <div class="page-header">
            <h1><i class="bi bi-speedometer2 me-2"></i>Admin Dashboard</h1>
            <p>Overview of your quiz system</p>
        </div>

        <!-- Stats Row -->
        <div class="row g-4 mb-4">
            <div class="col-md-4">
                <div class="stat-card primary">
                    <div class="d-flex align-items-center gap-3">
                        <div class="stat-icon primary">
                            <i class="bi bi-journal-text"></i>
                        </div>
                        <div>
                            <div class="stat-value">${totalQuizzes}</div>
                            <div class="stat-label">Total Quizzes</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-card success">
                    <div class="d-flex align-items-center gap-3">
                        <div class="stat-icon success">
                            <i class="bi bi-trophy"></i>
                        </div>
                        <div>
                            <div class="stat-value">${totalResults}</div>
                            <div class="stat-label">Total Attempts</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-card info">
                    <div class="d-flex align-items-center gap-3">
                        <div class="stat-icon info">
                            <i class="bi bi-lightning-charge"></i>
                        </div>
                        <div>
                            <div class="stat-value">Live</div>
                            <div class="stat-label">System Status</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="row g-4 mb-4">
            <div class="col-12">
                <div class="content-card">
                    <div class="card-header-custom">
                        <span><i class="bi bi-lightning-charge-fill"></i>Quick Actions</span>
                    </div>
                    <div class="card-body">
                        <div class="d-flex gap-3 flex-wrap">
                            <a href="${pageContext.request.contextPath}/admin/quizzes/new" class="btn btn-primary-custom" style="width:auto;">
                                <i class="bi bi-plus-circle me-2"></i>Create New Quiz
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/quizzes" class="btn btn-outline-custom">
                                <i class="bi bi-list-ul me-2"></i>Manage Quizzes
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/results" class="btn btn-outline-custom">
                                <i class="bi bi-bar-chart me-2"></i>View All Results
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Recent Quizzes -->
        <div class="row">
            <div class="col-12">
                <div class="content-card">
                    <div class="card-header-custom">
                        <span><i class="bi bi-journal-text"></i>Your Quizzes</span>
                        <a href="${pageContext.request.contextPath}/admin/quizzes/new"
                           class="btn btn-sm btn-success-custom">
                            <i class="bi bi-plus me-1"></i>Add New
                        </a>
                    </div>
                    <div class="card-body">
                        <c:if test="${empty quizzes}">
                            <div class="empty-state">
                                <i class="bi bi-journal-x"></i>
                                <h5>No Quizzes Yet</h5>
                                <p>Create your first quiz to get started!</p>
                            </div>
                        </c:if>
                        <c:if test="${not empty quizzes}">
                            <div class="table-responsive">
                                <table class="table table-custom mb-0">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Title</th>
                                            <th>Description</th>
                                            <th>Questions</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="quiz" items="${quizzes}" varStatus="loop">
                                            <tr>
                                                <td><strong>${loop.index + 1}</strong></td>
                                                <td>
                                                    <strong class="text-dark">${quiz.title}</strong>
                                                </td>
                                                <td>
                                                    <span class="text-muted">${quiz.description}</span>
                                                </td>
                                                <td>
                                                    <span class="badge bg-primary rounded-pill">${quiz.questions.size()}</span>
                                                </td>
                                                <td>
                                                    <div class="d-flex gap-1">
                                                        <a href="${pageContext.request.contextPath}/admin/quizzes/${quiz.id}/questions/new"
                                                           class="btn btn-sm btn-outline-custom" title="Add Questions">
                                                            <i class="bi bi-plus-circle"></i>
                                                        </a>
                                                        <a href="${pageContext.request.contextPath}/admin/quizzes/${quiz.id}/edit"
                                                           class="btn btn-sm btn-outline-custom" title="Edit Quiz">
                                                            <i class="bi bi-pencil"></i>
                                                        </a>
                                                        <a href="${pageContext.request.contextPath}/admin/quizzes/${quiz.id}/delete"
                                                           class="btn btn-sm btn-danger-custom"
                                                           onclick="return confirm('Are you sure you want to delete this quiz?')"
                                                           title="Delete Quiz">
                                                            <i class="bi bi-trash"></i>
                                                        </a>
                                                    </div>
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
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
