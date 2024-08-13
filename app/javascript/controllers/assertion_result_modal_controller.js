import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content", "label"]

  connect() {
    this.modal = document.getElementById('assertion-result-modal')
  }

  show(event) {
    const jsonData = event.currentTarget.dataset.json
    const prettyJson = JSON.stringify(JSON.parse(jsonData), null, 2)
    this.contentTarget.textContent = prettyJson
    this.labelTarget.textContent = `${event.currentTarget.dataset.assertion} full response`
    this.modal.classList.remove('hidden')
  }

  close() {
    this.modal.classList.add('hidden')
  }
}
