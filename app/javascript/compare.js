document.addEventListener('DOMContentLoaded', function() {
  function fetchLatestTestResult(panel, modelVersionId, promptId) {
    if (modelVersionId === "") {
      document.getElementById(`${panel}-panel-result`).innerHTML = "";
      return;
    }
    fetch(`/test_results?prompt_id=${promptId}&model_version_id=${modelVersionId}`)
      .then(response => response.json())
      .then(data => {
        const result = data[0]
        const resultDiv = document.getElementById(`${panel}-panel-result`);
        if (result) {
          resultDiv.innerHTML = `
            <div class="result-container">
              <p>Result: ${result.result}</p>
              <p>Created At: ${result.created_at}</p>
            </div>
          `;
        } else {
          resultDiv.innerHTML = `<p>No test results available</p>`;
        }
      });
  }

  document.querySelector('select[name="left-panel-model"]').addEventListener('change', function() {
    const promptId = this.getAttribute('data-prompt-id');
    fetchLatestTestResult('left', this.value, promptId);
  });

  document.querySelector('select[name="right-panel-model"]').addEventListener('change', function() {
    const promptId = this.getAttribute('data-prompt-id');
    fetchLatestTestResult('right', this.value, promptId);
  });
});
