<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="${quiz.id != null ? 'Edit Quiz' : 'Create Quiz'}"/>
</jsp:include>

<div class="page-wrapper">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-7">
                <!-- Page Header -->
                <div class="page-header">
                    <h1>
                        <i class="bi bi-${quiz.id != null ? 'pencil-square' : 'plus-circle'} me-2"></i>
                        ${quiz.id != null ? 'Edit Quiz' : 'Create New Quiz'}
                    </h1>
                    <p>${quiz.id != null ? 'Update quiz details below' : 'Fill in the details to create a new quiz'}</p>
                </div>

                <!-- Quiz Form -->
                <div class="content-card">
                    <div class="card-header-custom">
                        <span><i class="bi bi-journal-plus"></i>Quiz Details</span>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/admin/quizzes/${quiz.id != null ? quiz.id.toString().concat('/edit') : 'new'}"
                              method="post">

                            <div class="mb-4">
                                <label for="title" class="form-label fw-bold">
                                    <i class="bi bi-type me-1"></i>Quiz Title <span class="text-danger">*</span>
                                </label>
                                <input type="text" class="form-control" id="title" name="title"
                                       value="${quiz.title}" placeholder="e.g., Java Programming Fundamentals"
                                       required maxlength="200" style="border: 2px solid var(--gray-200); border-radius: var(--radius-sm); padding: .75rem;">
                            </div>

                            <div class="mb-4">
                                <label for="description" class="form-label fw-bold">
                                    <i class="bi bi-text-paragraph me-1"></i>Description
                                </label>
                                <textarea class="form-control" id="description" name="description" rows="4"
                                          placeholder="Describe what this quiz covers..."
                                          style="border: 2px solid var(--gray-200); border-radius: var(--radius-sm); padding: .75rem;">${quiz.description}</textarea>
                            </div>

                            <div class="d-flex gap-3">
                                <button type="submit" class="btn btn-primary-custom" style="width:auto;">
                                    <i class="bi bi-check-lg me-2"></i>
                                    ${quiz.id != null ? 'Update Quiz' : 'Create Quiz'}
                                </button>
                                <a href="${pageContext.request.contextPath}/admin/quizzes" class="btn btn-outline-custom">
                                    <i class="bi bi-x-lg me-1"></i>Cancel
                                </a>
                            </div>

                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
