# frozen_string_literal: true

json.array! @test_runs, partial: 'test_runs/test_run', as: :test_run
