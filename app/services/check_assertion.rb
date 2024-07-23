# frozen_string_literal: true

class CheckAssertion
  attr_reader :assertion

  def initialize(assertion)
    @assertion = assertion
  end

  def call(result)
    return 'passed' if assertion&.value&.split('\n')&.all? { |value| assertion.include? ? result&.include?(value) : result&.exclude?(value) }

    'failed'
  end
end
