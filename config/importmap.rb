# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin 'application', preload: true
pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true
pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
pin 'init-alpine', to: 'init-alpine.js', preload: true
pin 'focus-trap.js', to: 'focus-trap.js', preload: true
pin_all_from 'app/javascript/controllers', under: 'controllers', preload: true
