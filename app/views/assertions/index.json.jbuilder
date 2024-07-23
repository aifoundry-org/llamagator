# frozen_string_literal: true

json.array! @assertions, partial: 'assertions/assertion', as: :assertion
