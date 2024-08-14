import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modelVersionSelector", "valueLabel"]

  connect() {
    this.toggleModelVersion()
  }

  toggleModelVersion() {
    const assertionType = this.element.querySelector('select[name="assertion[assertion_type]"]').value
    if (assertionType === "model_version") {
      this.modelVersionSelectorTarget.style.display = "block"
      this.valueLabelTarget.textContent = "Enter an expression to query the model (e.g., 'return true or false', 'return true if condition else false', etc.)"
    } else {
      this.modelVersionSelectorTarget.style.display = "none"
      this.valueLabelTarget.textContent = "Write each expression on a separate row"
    }
  }
}
