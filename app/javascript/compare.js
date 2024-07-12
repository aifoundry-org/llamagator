function fetchLatestTestResult(panel, modelVersionId, promptId) {
  if (modelVersionId === "") {
    document.getElementById(`${panel}-panel-result`).innerHTML = "";
    return;
  }
  fetch(`/test_results.json?prompt_id=${promptId}&model_version_id=${modelVersionId}`)
    .then(response => response.json())
    .then(data => {
      const result = data[0]
      const resultDiv = document.getElementById(`${panel}-panel-result`);
      if (result) {
        resultDiv.innerHTML = `
          <div class="result-container">
            <p>Created At: ${result.created_at}</p>
            <div class="flex items-center" data-test-result-id="${result.id}">
              <span class="star ${result.rating && result.rating >= 1 ? 'selected' : '' }" data-value="1">&#9733;</span>
              <span class="star ${result.rating && result.rating >= 2 ? 'selected' : '' }" data-value="2">&#9733;</span>
              <span class="star ${result.rating && result.rating >= 3 ? 'selected' : '' }" data-value="3">&#9733;</span>
              <span class="star ${result.rating && result.rating >= 4 ? 'selected' : '' }" data-value="4">&#9733;</span>
              <span class="star ${result.rating && result.rating >= 5 ? 'selected' : '' }" data-value="5">&#9733;</span>
            </div>
            <p>Result: ${result.content}</p>
          </div>
        `;

      } else {
        resultDiv.innerHTML = `<p>No test results available</p>`;
      }
      const stars = document.querySelectorAll('.star');

      stars.forEach(star => {
        star.addEventListener('click', () => {
          const rating = star.getAttribute('data-value');
          const testResultId = star.parentNode.getAttribute('data-test-result-id');
          const allStars = star.parentNode.querySelectorAll('.star');

          // Update stars display
          allStars.forEach(s => {
            s.classList.remove('selected');
          });

          for (let i = 0; i < rating; i++) {
            allStars[i].classList.add('selected');
          }

          // Send rating to server
          fetch(`/test_results/${testResultId}`, {
            method: 'PATCH',
            headers: {
              'Content-Type': 'application/json',
              'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
            },
            body: JSON.stringify({ test_result: { rating: rating } })
          })
          .then(response => response.json())
          .then(data => {
            if (data.success) {
              console.log(`Rating for TestResult ${testResultId} updated to ${rating}`);
            } else {
              console.error(`Failed to update rating: ${data.errors.join(', ')}`);
            }
          });
        });
      });
    });
}


window.fetchLatestTestResult = fetchLatestTestResult
