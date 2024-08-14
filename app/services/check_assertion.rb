# frozen_string_literal: true

class CheckAssertion
  attr_reader :assertion

  def initialize(assertion)
    @assertion = assertion
  end

  def call(result)
    return ['failed', nil] unless assertion&.value && result

    assertion_type = assertion.assertion_type

    Assertions.const_get(assertion_type.camelize).new(assertion.value, assertion.model_version).call(result)
  end
end
