# frozen_string_literal: true

class PopulateStatusForTestModelVersionRuns < ActiveRecord::Migration[7.1]
  TestModelVersionRun = Class.new(ActiveRecord::Base)
  SolidQueueFailedExecution = Class.new(ActiveRecord::Base)
  SolidQueueJob = Class.new(ActiveRecord::Base) do
    has_one :solid_queue_failed_execution, foreign_key: :job_id
  end

  def up
    TestModelVersionRun.update_all("status = 'performed'")

    failed_test_model_version_run_ids = Set.new
    SolidQueueJob.where(class_name: 'TestModelVersionRunJob').joins(:solid_queue_failed_execution).select(:id, :arguments).find_each do |failed_job|
      failed_test_model_version_run_ids << JSON.parse(failed_job.arguments).dig('arguments', 0)
    end

    TestModelVersionRun.where(id: failed_test_model_version_run_ids).update_all("status = 'failed'") if failed_test_model_version_run_ids.present?
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
