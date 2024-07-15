# frozen_string_literal: true

json.array! @prompts, partial: 'prompts/prompt', as: :prompt
