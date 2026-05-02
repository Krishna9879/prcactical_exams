<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Take Quiz"/>
</jsp:include>

<!-- Timer Bar -->
<div class="timer-bar" id="timerBar">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center">
            <div>
                <strong class="text-dark">${quiz.title}</strong>
                <span class="text-muted ms-2">${questions.size()} Questions</span>
            </div>
            <div class="text-end">
                <span class="timer-display" id="timerDisplay">
                    <i class="bi bi-stopwatch me-1"></i>
                    <span id="timerText">--:--</span>
                </span>
            </div>
        </div>
        <div class="timer-progress">
            <div class="timer-progress-bar" id="timerProgressBar" style="width: 100%"></div>
        </div>
    </div>
</div>

<div class="page-wrapper" style="padding-top: 1rem;">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <!-- Quiz Info -->
                <div class="content-card mb-4">
                    <div class="card-header-custom">
                        <span><i class="bi bi-journal-text"></i>${quiz.title}</span>
                    </div>
                    <div class="card-body">
                        <p class="text-muted mb-2">${quiz.description}</p>
                        <div class="d-flex gap-3 flex-wrap" style="font-size:.88rem;">
                            <span class="text-muted"><i class="bi bi-question-circle me-1"></i>${questions.size()} Questions</span>
                            <span class="text-muted"><i class="bi bi-clock me-1"></i>${questions.size() * 30} seconds total</span>
                            <span class="text-muted"><i class="bi bi-trophy me-1"></i>Max Score: ${questions.size()}</span>
                        </div>
                    </div>
                </div>

                <!-- Quiz Form -->
                <form action="${pageContext.request.contextPath}/user/quizzes/${quiz.id}/submit"
                      method="post" id="quizForm">

                    <c:forEach var="question" items="${questions}" varStatus="loop">
                        <div class="question-card" style="animation-delay: ${loop.index * 0.08}s;">
                            <div class="d-flex align-items-start mb-3">
                                <span class="question-number">${loop.index + 1}</span>
                                <span class="question-text">${question.questionText}</span>
                            </div>
                            <div class="ms-4">
                                <c:forEach var="opt" items="${question.options}">
                                    <label class="option-label">
                                        <input type="radio"
                                               name="answer_${question.id}"
                                               value="${opt.id}"
                                               required>
                                        <span>${opt.optionText}</span>
                                    </label>
                                </c:forEach>
                            </div>
                        </div>
                    </c:forEach>

                    <!-- Submit Button -->
                    <div class="d-flex justify-content-between align-items-center mt-4 mb-4">
                        <a href="${pageContext.request.contextPath}/user/quizzes" class="btn btn-outline-custom">
                            <i class="bi bi-arrow-left me-1"></i>Cancel
                        </a>
                        <button type="submit" class="btn btn-primary-custom" style="width:auto; min-width:200px;"
                                id="submitBtn">
                            <i class="bi bi-check-circle me-2"></i>Submit Quiz
                        </button>
                    </div>

                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    // ====== Quiz Timer: 30 seconds per question ======
    (function() {
        var totalQuestions = ${questions.size()};
        var totalSeconds = totalQuestions * 30;
        var remainingSeconds = totalSeconds;
        var timerText = document.getElementById('timerText');
        var timerDisplay = document.getElementById('timerDisplay');
        var progressBar = document.getElementById('timerProgressBar');
        var quizForm = document.getElementById('quizForm');
        var submitted = false;

        function updateDisplay() {
            var mins = Math.floor(remainingSeconds / 60);
            var secs = remainingSeconds % 60;
            timerText.textContent = String(mins).padStart(2, '0') + ':' + String(secs).padStart(2, '0');

            // Update progress bar
            var pct = (remainingSeconds / totalSeconds) * 100;
            progressBar.style.width = pct + '%';

            // Color changes based on time remaining
            timerDisplay.classList.remove('warning', 'danger');
            progressBar.classList.remove('warning', 'danger');

            if (remainingSeconds <= totalSeconds * 0.2) {
                timerDisplay.classList.add('danger');
                progressBar.classList.add('danger');
            } else if (remainingSeconds <= totalSeconds * 0.5) {
                timerDisplay.classList.add('warning');
                progressBar.classList.add('warning');
            }
        }

        function tick() {
            if (submitted) return;
            remainingSeconds--;
            updateDisplay();

            if (remainingSeconds <= 0) {
                // Auto-submit when time runs out
                submitted = true;
                alert('Time is up! Your quiz will be submitted automatically.');
                quizForm.submit();
            }
        }

        // Initialize display
        updateDisplay();

        // Start countdown
        setInterval(tick, 1000);

        // Confirm before submit
        quizForm.addEventListener('submit', function(e) {
            if (!submitted) {
                var unanswered = 0;
                var questions = document.querySelectorAll('.question-card');
                questions.forEach(function(q) {
                    var inputs = q.querySelectorAll('input[type="radio"]');
                    var answered = false;
                    inputs.forEach(function(inp) { if (inp.checked) answered = true; });
                    if (!answered) unanswered++;
                });

                if (unanswered > 0) {
                    if (!confirm('You have ' + unanswered + ' unanswered question(s). Submit anyway?')) {
                        e.preventDefault();
                        return;
                    }
                }
                submitted = true;
            }
        });
    })();
</script>

<jsp:include page="../common/footer.jsp"/>
