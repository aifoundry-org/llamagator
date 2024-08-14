import { Controller } from "@hotwired/stimulus"
const DEFAULT_CONFIGURATION = {
  openai: '{"model":"gpt-3.5-turbo","temperature":0.5}',
  ollama: '{"model":"llama3.1"}',
  llama: '{"n_predict":500,"temperature":0.5,"stop":["<|end|>","<|user|>","<|assistant|>","<|endoftext|>","<|system|>"]}'
}

export default class extends Controller {
  static targets = ["configurationField", "apiKeyField"]

  connect() {
    this.toggleConfiguration()
  }

  toggleConfiguration() {
    const executorType = this.element.querySelector('#executor_type_selector').value
    if (this.hasConfigurationFieldTarget)
      this.configurationFieldTarget.value = DEFAULT_CONFIGURATION[executorType]

    if (executorType == 'openai')
      this.apiKeyFieldTarget.style.display = "block"
    else
      this.apiKeyFieldTarget.style.display = "none"
  }
}
