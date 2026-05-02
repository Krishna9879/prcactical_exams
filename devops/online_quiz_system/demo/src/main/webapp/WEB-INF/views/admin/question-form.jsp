<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Manage Questions"/>
</jsp:include>

<div class="page-wrapper">
    <div class="container">
        <!-- Page Header -->
        <div class="page-header">
            <h1><i class="bi bi-question-circle me-2"></i>Manage Questions</h1>
            <p>Quiz: <strong>${quiz.title}</strong></p>
        </div>

        <!-- Flash Messages -->
        <c:if test="${not empty success}">
            <div class="alert alert-custom alert-success" role="alert">
                <i class="bi bi-check-circle-fill"></i>
                <span>${success}</span>
            </div>
        </c:if>

        <div class="row g-4">
            <!-- Left: Add Question Form -->
            <div class="col-lg-6">
                <div class="content-card">
                    <div class="card-header-custom">
                        <span><i class="bi bi-plus-circle"></i>Add New Question</span>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/admin/quizzes/${quiz.id}/questions/new"
                              method="post" id="questionForm">

                            <div class="mb-4">
                                <label for="questionText" class="form-label fw-bold">
                                    <i class="bi bi-chat-left-text me-1"></i>Question Text <span class="text-danger">*</span>
                                </label>
                                <textarea class="form-control" id="questionText" name="questionText" rows="3"
                                          placeholder="Enter your question here..."
                                          required
                                          style="border: 2px solid var(--gray-200); border-radius: var(--radius-sm); padding: .75rem;"></textarea>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold">
                                    <i class="bi bi-list-check me-1"></i>Options <span class="text-danger">*</span>
                                </label>
                                <p class="text-muted small mb-3">Enter 4 options and select the correct answer</p>

                                <c:forEach begin="0" end="3" var="i">
                                    <div class="d-flex align-items-center gap-2 mb-3">
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="correctOption"
                                                   value="${i}" id="correct${i}" ${i == 0 ? 'checked' : ''}
                                                   style="width:20px; height:20px; accent-color: var(--primary);">
                                        </div>
                                        <input type="text" class="form-control" name="option"
                                               placeholder="Option ${i + 1}"
                                               required
                                               style="border: 2px solid var(--gray-200); border-radius: var(--radius-sm); padding: .6rem .75rem;">
                                        <c:if test="${i == 0}">
                                            <span class="badge bg-success rounded-pill" style="font-size:.7rem; white-space:nowrap;">Correct</span>
                                        </c:if>
                                    </div>
                                </c:forEach>

                                <div class="alert alert-custom alert-info mt-2" style="font-size:.85rem;">
                                    <i class="bi bi-info-circle"></i>
                                    <span>Select the radio button next to the correct answer</span>
                                </div>
                            </div>

                            <button type="submit" class="btn btn-success-custom w-100">
                                <i class="bi bi-plus-circle me-2"></i>Add Question
                            </button>

                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        </form>
                    </div>
                </div>

                <!-- Back Button -->
                <div class="mt-3">
                    <a href="${pageContext.request.contextPath}/admin/quizzes" class="btn btn-outline-custom">
                        <i class="bi bi-arrow-left me-1"></i>Back to Quizzes
                    </a>
                </div>
            </div>

            <!-- Right: Existing Questions List -->
            <div class="col-lg-6">
                <div class="content-card">
                    <div class="card-header-custom">
                        <span><i class="bi bi-list-ol"></i>Existing Questions (${questions.size()})</span>
                    </div>
                    <div class="card-body">
                        <c:if test="${empty questions}">
                            <div class="empty-state">
                                <i class="bi bi-question-square"></i>
                                <h5>No Questions Yet</h5>
                                <p>Use the form to add questions to this quiz.</p>
                            </div>
                        </c:if>

                        <c:forEach var="question" items="${questions}" varStatus="loop">
                            <div class="question-card" style="padding: 1.25rem; margin-bottom: 1rem;">
                                <div class="d-flex align-items-start mb-2">
                                    <span class="question-number">${loop.index + 1}</span>
                                    <span class="question-text flex-grow-1">${question.questionText}</span>
                                    <a href="${pageContext.request.contextPath}/admin/quizzes/${quiz.id}/questions/${question.id}/delete"
                                       class="btn btn-sm btn-danger-custom ms-2"
                                       onclick="return confirm('Delete this question?')"
                                       title="Delete Question">
                                        <i class="bi bi-trash"></i>
                                    </a>
                                </div>
                                <div class="ms-5">
                                    <c:forEach var="opt" items="${question.options}">
                                        <div class="d-flex align-items-center gap-2 mb-1" style="font-size:.88rem;">
                                            <c:choose>
                                                <c:when test="${opt.isCorrect}">
                                                    <i class="bi bi-check-circle-fill text-success"></i>
                                                    <span class="fw-bold text-success">${opt.optionText}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="bi bi-circle text-muted"></i>
                                                    <span class="text-muted">${opt.optionText}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Dynamically update "Correct" badge based on selected radio
    document.querySelectorAll('input[name="correctOption"]').forEach(function(radio) {
        radio.addEventListener('change', function() {
            document.querySelectorAll('.badge.bg-success').forEach(function(b) { b.remove(); });
            var badge = document.createElement('span');
            badge.className = 'badge bg-success rounded-pill';
            badge.style.fontSize = '.7rem';
            badge.style.whiteSpace = 'nowrap';
            badge.textContent = 'Correct';
            this.closest('.d-flex').appendChild(badge);
        });
    });
</script>

<jsp:include page="../common/footer.jsp"/>
