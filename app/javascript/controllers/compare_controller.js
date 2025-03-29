// app/javascript/controllers/compare_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["leftPanelSelect", "rightPanelSelect", "leftPanelResult", "rightPanelResult"];

  connect() {
    const promptSelect = document.getElementById('prompt-id-select');
    if (promptSelect.value) {
      this.loadTestRuns({ target: { value: promptSelect.value } });
    }
  }

  loadTestRuns(event) {
    const promptId = event.target.value;

    if (!promptId) {
      this.clearAll();
      return;
    }
    fetch(`/test_runs.json?prompt_id=${promptId}`)
      .then(response => response.json())
      .then(data => {
        const testRunSelect = document.getElementById('test-run-select');
        this.clearOptions(testRunSelect);
        if (data.length === 0) {
          this.clearAll();
          return;
        }
        data.forEach(testRun => {
          const option = document.createElement('option');
          option.value = testRun.id;
          option.textContent = testRun.name;
          testRunSelect.appendChild(option);
        });

        if (data.length > 0) {
          this.loadModelVersions({ target: { value: data[0].id } });
        }
      });
  }

  loadModelVersions(event) {
    const testRunId = event.target.value;
    if (!testRunId) {
      this.clearPanelModels();
      return;
    }
    fetch(`/compare/model_versions?test_run_id=${testRunId}`)
      .then(response => response.json())
      .then(data => {
        this.clearPanelModels();
        this.updateModelSelects(data);
        if (data.length > 0) {
          const promptId = document.getElementById('prompt-id-select').value;
          this.fetchLatestTestResult("left", data[0].id, promptId, testRunId);
          this.fetchLatestTestResult("right", data[0].id, promptId, testRunId);
        }
      });
  }

  updateModelSelects(data) {
    this.clearOptions(this.leftPanelSelectTarget);
    this.clearOptions(this.rightPanelSelectTarget);

    data.forEach(modelVersion => {
      const option = document.createElement('option');
      option.value = modelVersion.id;
      option.textContent = modelVersion.full_name;
      this.leftPanelSelectTarget.appendChild(option.cloneNode(true));
      this.rightPanelSelectTarget.appendChild(option);
    });
  }

  fetchLatestTestResult(panel, modelVersionId, promptId, testRunId) {
    if (!modelVersionId) {
      this[`${panel}PanelResultTarget`].innerHTML = "";
      return;
    }
    
    fetch(`/test_results.json?&model_version_id=${modelVersionId}&status=completed&test_run_id=${testRunId}`)
      .then(response => response.json())
      .then(data => {
        const result = data[0];
        const resultDiv = this[`${panel}PanelResultTarget`];
        if (result) {
          resultDiv.innerHTML = `
            <div class="result-container">
              <p>Created At: ${result.created_at}</p>
              <div class="flex items-center" data-test-result-id="${result.id}">
                ${this.renderStars(result.rating)}
              </div>
              <p>Result: ${result.content}</p>
            </div>
          `;
          this.setupStarRating(resultDiv);
        } else {
          resultDiv.innerHTML = `<p>No test results available</p>`;
        }
      });
  }

  renderStars(rating) {
    let stars = '';
    for (let i = 1; i <= 5; i++) {
      stars += `<span class="star ${rating && rating >= i ? 'selected' : ''}" data-value="${i}">&#9733;</span>`;
    }
    return stars;
  }

  setupStarRating(resultDiv) {
    const stars = resultDiv.querySelectorAll('.star');
    stars.forEach(star => {
      star.addEventListener('click', () => {
        const rating = star.getAttribute('data-value');
        const testResultId = star.parentNode.getAttribute('data-test-result-id');
        this.updateStars(star, rating);
        this.sendRatingToServer(testResultId, rating);
      });
    });
  }

  updateStars(star, rating) {
    const allStars = star.parentNode.querySelectorAll('.star');
    allStars.forEach(s => s.classList.remove('selected'));
    for (let i = 0; i < rating; i++) {
      allStars[i].classList.add('selected');
    }
  }

  sendRatingToServer(testResultId, rating) {
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
  }

  clearOptions(selectElement) {
    while (selectElement?.firstChild) {
      selectElement.removeChild(selectElement.firstChild);
    }
  }

  clearAll() {
    this.clearOptions(this.testRunSelectTarget);
    this.clearPanelModels();
  }

  clearPanelModels() {
    this.clearOptions(this.leftPanelSelectTarget);
    this.clearOptions(this.rightPanelSelectTarget);
    this.leftPanelResultTarget.innerHTML = "";
    this.rightPanelResultTarget.innerHTML = "";
  }
}
