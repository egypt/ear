class TaskRun < ActiveRecord::Base

  def to_s
    "Task Run: #{task_name}, run on #{task_object_type}:(#{task_object_id})"
  end

end
